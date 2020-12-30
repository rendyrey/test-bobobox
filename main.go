/**
@author Rendy Reynaldy <rendy@99.co>
@date 2020.12.29


*/

package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
)

/**
ErrorResponse Function is to store code and message if there's any error response
*/
func ErrorResponse(code int, message string) Error {
	var errorMessage Error
	errorMessage.Code = code
	errorMessage.Message = message
	return errorMessage
}

/**
This function is to get all room available by given checkin date, checkout date, room type id, and room qty.
Some examples:
1. If room qty available on one hotel doesn't meet room qty param request. null result will be given
2. If room type id given by request param is not available because in stay_room table there's room booked, the room will not be shown
3. etc.
Room will not be given on the response if:
1. between checkin date and checkout date there's full room booked by any guest on specific room type id
2. On the hotel there's no room qty available by the room qty requests
3. etc.

here's one example of all room_number available to book on below query
id  room_type_id 	room_number
2	1				102
3	1				103
7	1				101
8	1				102
9	1				103
13	1				101
*/
func searchForRoomAvailableQuery(checkin_date, checkout_date, room_qty, room_type_id string) *sql.Rows {
	var connection = os.Getenv("DB_USER") + ":" + os.Getenv("DB_PASSWORD") + "@" + os.Getenv("DB_PROTOCOL") + "(" + os.Getenv("DB_HOST") + ":" + os.Getenv("DB_PORT") + ")/" + os.Getenv("DB")
	db, err := sql.Open("mysql", connection)

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	searchForRoomIdAvailable := `select r.id,r.room_type_id,r.room_number from room r
		 left join roomtype rt on rt.id = r.room_type_id
		 left join price p on rt.id = p.room_type_id
		 where not exists (select * from stayroom sr where sr.room_id = r.id and sr.date between '` + checkin_date + `' and '` + checkout_date + `')
		 and r.room_status = 'available'
		 and p.date between '` + checkin_date + `' and '` + checkout_date + `'`

	if room_type_id != "" {
		searchForRoomIdAvailable += ` and r.room_type_id = '` + room_type_id + `'`
	}

	if room_qty != "" {
		searchForRoomIdAvailable += ` and hotel_id in (select hotel_id from room
			group by hotel_id having count(hotel_id) >= '` + room_qty + `') group by r.id order by r.id asc`
	}

	roomIdResult, errRoom := db.Query(searchForRoomIdAvailable)
	if errRoom != nil {
		panic(errRoom.Error())
	}

	return roomIdResult
}

/**
This function is to get all the price of room that available to book
*/
func searchForPriceAvailableQuery(checkin_date, checkout_date, room_qty, room_type_id string) *sql.Rows {
	var connection = os.Getenv("DB_USER") + ":" + os.Getenv("DB_PASSWORD") + "@" + os.Getenv("DB_PROTOCOL") + "(" + os.Getenv("DB_HOST") + ":" + os.Getenv("DB_PORT") + ")/" + os.Getenv("DB")
	db, err := sql.Open("mysql", connection)

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}
	searchForPriceAvailable := `select r.id,r.room_type_id,p.date,p.price from room r
	left join roomtype rt on rt.id = r.room_type_id
	left join price p on rt.id = p.room_type_id
	where not exists (select * from stayroom sr where sr.room_id = r.id and sr.date between '` + checkin_date + `' and '` + checkout_date + `')
	and r.room_status = 'available'
	and p.date between '` + checkin_date + `' and '` + checkout_date + `'`

	if room_type_id != "" {
		searchForPriceAvailable += ` and r.room_type_id = '` + room_type_id + `'`
	}

	if room_qty != "" {
		searchForPriceAvailable += ` and r.hotel_id in (select hotel_id from room
			group by hotel_id having count(hotel_id) >= '` + room_qty + `') group by date`
	}

	roomPriceResult, errPrice := db.Query(searchForPriceAvailable)

	if errPrice != nil {
		panic(errPrice.Error())
	}

	return roomPriceResult
}

func searchAvailability(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	// get all the params needed
	checkin_date := r.URL.Query().Get("checkin_date")
	checkout_date := r.URL.Query().Get("checkout_date")
	room_qty := r.URL.Query().Get("room_qty")
	room_type_id := r.URL.Query().Get("room_type_id")

	// if there's one param that not given by the request
	if room_qty == "" || room_type_id == "" || checkin_date == "" || checkout_date == "" {
		w.WriteHeader(400)
		json.NewEncoder(w).Encode(ErrorResponse(400, "Required fields must be filled"))
		return
	}

	roomQtyCheck, err := strconv.Atoi(room_qty)

	if err != nil {
		w.WriteHeader(400)
		return
	}

	// check if room qty param is below 1
	if roomQtyCheck < 1 {
		w.WriteHeader(400)
		json.NewEncoder(w).Encode(ErrorResponse(400, "Room quantity must be filled at least 1"))
		return
	}

	roomIdResult := searchForRoomAvailableQuery(checkin_date, checkout_date, room_qty, room_type_id)

	roomPriceResult := searchForPriceAvailableQuery(checkin_date, checkout_date, room_qty, room_type_id)

	var resAR []AvailableRoom
	var resRPA []RoomPriceAvailable

	for roomPriceResult.Next() {
		var tagPrice RoomPriceAvailable
		roomPriceResult.Scan(&tagPrice.RoomID, &tagPrice.RoomTypeID, &tagPrice.Date, &tagPrice.Price)

		resRPA = append(resRPA, RoomPriceAvailable{
			RoomID:     tagPrice.RoomID,
			RoomTypeID: tagPrice.RoomTypeID,
			Date:       tagPrice.Date,
			Price:      tagPrice.Price,
		})
	}
	var totalPrice float32 = 0
	// loop by the room availabe to book
	for roomIdResult.Next() {
		var tagRoom RoomIDAvailable

		roomIdResult.Scan(&tagRoom.RoomID, &tagRoom.RoomTypeID, &tagRoom.RoomNumber)
		var tempPrice []Price

		// loop by room price available to book
		for _, v := range resRPA {

			if v.Date >= checkin_date && v.Date <= checkout_date && v.RoomTypeID == tagRoom.RoomTypeID {
				tempPrice = append(tempPrice, Price{
					Date:  v.Date,
					Price: v.Price,
				})
			}
			// to calculate total price that customer have to pay
			if v.Date >= checkin_date && v.Date < checkout_date && v.RoomTypeID == tagRoom.RoomTypeID {
				if totalPrice < v.Price {
					totalPrice += v.Price
				}
			}
		}

		// save respond for available rooms
		resAR = append(resAR, AvailableRoom{
			RoomID:     tagRoom.RoomID,
			RoomNumber: tagRoom.RoomNumber,
			Price:      tempPrice,
		})

	}

	roomtypeid, errRoomTypeID := strconv.Atoi(room_type_id)
	roomqty, errRoomQty := strconv.Atoi(room_qty)

	if errRoomTypeID != nil {
		panic(errRoomTypeID.Error())
	}
	if errRoomQty != nil {
		panic(errRoomQty.Error())
	}

	// create json template and filled the value
	var jsonRes Response

	jsonRes.RoomQty = roomqty
	jsonRes.RoomTypeID = roomtypeid
	jsonRes.CheckinDate = checkin_date
	jsonRes.CheckoutDate = checkout_date
	jsonRes.TotalPrice = float32(totalPrice * float32(roomqty))
	jsonRes.AvailableRoom = resAR

	json.NewEncoder(w).Encode(jsonRes)
}

func main() {
	os.Setenv("DB_HOST", "localhost")
	os.Setenv("DB_USER", "root")
	os.Setenv("DB_PASSWORD", "")
	os.Setenv("DB", "bobobox")
	os.Setenv("DB_PORT", "3306")
	os.Setenv("DB_PROTOCOL", "tcp")

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/search", searchAvailability).Methods("GET")
	router.HandleFunc("/promo/{promoId}", promotionAvailibility).Methods("GET")
	router.HandleFunc("/getListPriceRoom", getListPriceRoom).Methods("GET")
	log.Fatal(http.ListenAndServe(":8080", router))
}

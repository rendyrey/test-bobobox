package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
)

/**
function to get all list price room available
*/
func getListPriceRoom(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var connection = os.Getenv("DB_USER") + ":" + os.Getenv("DB_PASSWORD") + "@" + os.Getenv("DB_PROTOCOL") + "(" + os.Getenv("DB_HOST") + ":" + os.Getenv("DB_PORT") + ")/" + os.Getenv("DB")
	db, err := sql.Open("mysql", connection)

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	roomPriceQuery := `select date, room_type_id, price from price group by date,room_type_id`
	roomPriceResult, errPrice := db.Query(roomPriceQuery)

	if errPrice != nil {
		panic(errPrice.Error())
	}

	var roomType []RoomPromo
	for roomPriceResult.Next() {
		var date string
		var room_type_id int
		var price float32
		roomPriceResult.Scan(&date, &room_type_id, &price)

		roomType = append(roomType, RoomPromo{
			Date:          date,
			RoomTypeID:    room_type_id,
			OriginalPrice: price,
			FinalPrice:    price,
		})
	}

	json.NewEncoder(w).Encode(roomType)

}

/**
Function to get promo by promoID
*/
func getPromo(promoId string) Promo {
	var connection = os.Getenv("DB_USER") + ":" + os.Getenv("DB_PASSWORD") + "@" + os.Getenv("DB_PROTOCOL") + "(" + os.Getenv("DB_HOST") + ":" + os.Getenv("DB_PORT") + ")/" + os.Getenv("DB")
	db, err := sql.Open("mysql", connection)

	if err != nil {
		panic(err.Error())
	}

	promoQuery := `select p.id, p.promo_amount, p.is_percentage, p.promo_quota, p.start_date, p.end_date, p.quota_remaining, p.daily_quota,
	pr.minimum_nights, pr.minimum_room, pr.checkin_day, pr.booking_day, pr.booking_hour_start, pr.booking_hour_end from promo p
	left join promo_rules pr on p.id = pr.promo_id where p.id = '` + promoId + `' limit 1`

	fmt.Println(promoQuery)
	promoQueryResult := db.QueryRow(promoQuery)

	var promo Promo
	var tag Promo

	promoQueryResult.Scan(
		&tag.ID,
		&tag.PromoAmount,
		&tag.IsPercentage,
		&tag.PromoQuota,
		&tag.StartDate,
		&tag.EndDate,
		&tag.QuotaRemaining,
		&tag.DailyQuota,
		&tag.MinimumNights,
		&tag.MinimumRoom,
		&tag.CheckinDay,
		&tag.BookingDay,
		&tag.BookingHourStart,
		&tag.BookingHourEnd,
	)

	promo = Promo{
		ID:               tag.ID,
		PromoAmount:      tag.PromoAmount,
		IsPercentage:     tag.IsPercentage,
		PromoQuota:       tag.PromoQuota,
		StartDate:        tag.StartDate,
		EndDate:          tag.EndDate,
		QuotaRemaining:   tag.QuotaRemaining,
		DailyQuota:       tag.DailyQuota,
		MinimumNights:    tag.MinimumNights,
		MinimumRoom:      tag.MinimumRoom,
		CheckinDay:       tag.CheckinDay,
		BookingDay:       tag.BookingDay,
		BookingHourStart: tag.BookingHourStart,
		BookingHourEnd:   tag.BookingHourEnd,
	}

	fmt.Println(promo)

	return promo
}

func promotionAvailibility(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	resp, err := http.Get("http://localhost:8080/getListPriceRoom")

	if err != nil {
		w.WriteHeader(500)
	}
	params := mux.Vars(r)

	promoId := params["promoId"]

	var promo = getPromo(promoId)
	fmt.Println(promo)

	if promo.ID == 0 {
		w.WriteHeader(400)
		json.NewEncoder(w).Encode(ErrorResponse(400, "Promo ID not found"))
		return
	}

	body, err := ioutil.ReadAll(resp.Body)
	var roompromo []RoomPromo
	json.Unmarshal([]byte(string(body)), &roompromo)
	// fmt.Printf("Birds : %+v", roomtype)
	// json.NewEncoder(w).Encode(roompromo)
	var newRoomPromo []RoomPromo
	current_time := time.Now()
	today := current_time.Format("2006-01-02 15:04:05")
	now := current_time.Format("15:04:05")

	for _, element := range roompromo {
		var roomPromoTemp RoomPromo
		roomPromoTemp.Date = element.Date
		roomPromoTemp.RoomTypeID = element.RoomTypeID
		roomPromoTemp.OriginalPrice = element.OriginalPrice
		roomPromoTemp.FinalPrice = element.FinalPrice

		// if promo is applied to the rules
		if promo.StartDate <= today && promo.EndDate >= today && promo.QuotaRemaining > 0 && promo.BookingHourStart <= now && promo.BookingHourEnd >= now {
			if promo.IsPercentage == 1 { // if promo is percentage
				roomPromoTemp.FinalPrice = element.FinalPrice - ((element.FinalPrice * promo.PromoAmount) / 100)
			} else { // if promo is amount of currency
				roomPromoTemp.FinalPrice = element.FinalPrice - promo.PromoAmount
			}
		}

		// save the new price response
		newRoomPromo = append(newRoomPromo, RoomPromo{
			Date:          roomPromoTemp.Date,
			RoomTypeID:    roomPromoTemp.RoomTypeID,
			OriginalPrice: roomPromoTemp.OriginalPrice,
			FinalPrice:    roomPromoTemp.FinalPrice,
		})

	}

	json.NewEncoder(w).Encode(newRoomPromo)
}

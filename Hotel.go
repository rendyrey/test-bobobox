package main

import (
	ref "bobobox/reference"
)

type RoomIDAvailable struct {
	RoomID     int    `json:"room_id"`
	RoomTypeID int    `json:"room_type_id"`
	RoomNumber string `json:"room_number"`
}

type RoomPriceAvailable struct {
	RoomID     int     `json:"room_id"`
	RoomTypeID int     `json:"room_type_id"`
	Date       string  `json:"date"`
	Price      float32 `json:"price"`
}

type Room struct {
	ID         int            `json:"id"`
	HotelID    string         `json:"hotel_id"`
	RoomTypeID int            `json:"room_type_id"`
	RoomNumber int            `json:"room_number"`
	RoomStatus ref.RoomStatus `json:"room_status"`
}

type Price struct {
	Date  string  `json:"date"`
	Price float32 `json:"price"`
}

type AvailableRoom struct {
	RoomID     int     `json:"room_id"`
	RoomNumber string  `json:"room_number"`
	Price      []Price `json:"price"`
}

type Response struct {
	RoomQty       int             `json:"room_qty"`
	RoomTypeID    int             `json:"room_type_id"`
	CheckinDate   string          `json:"checkin_date"`
	CheckoutDate  string          `json:"checkout_date"`
	TotalPrice    float32         `json:"total_price"`
	AvailableRoom []AvailableRoom `json:"available_room"`
}

type Error struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type RoomType struct {
	Date       string  `json:"date"`
	RoomTypeID int     `json:"room_type_id"`
	Price      float32 `json:"price"`
}

type RoomPromo struct {
	Date          string  `json:"date"`
	RoomTypeID    int     `json:"room_type_id"`
	OriginalPrice float32 `json:"original_price"`
	FinalPrice    float32 `json:"final_price"`
}

type Promo struct {
	ID               int     `json:"id"`
	PromoAmount      float32 `json:"promo_amount"`
	IsPercentage     int     `json:"is_percentage"`
	PromoQuota       int     `json:"promo_quota"`
	StartDate        string  `json:"start_date"`
	EndDate          string  `json:"end_date"`
	QuotaRemaining   int     `json:"quota_remaining"`
	DailyQuota       int     `json:"daily_quota"`
	MinimumNights    int     `json:"minimum_nights"`
	MinimumRoom      int     `json:"minimum_room"`
	CheckinDay       string  `json:"checkin_day"`
	BookingDay       string  `json:"booking_day"`
	BookingHourStart string  `json:"booking_hour_start"`
	BookingHourEnd   string  `json:"booking_hour_end"`
}

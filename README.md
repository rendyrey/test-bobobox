# test-bobobox-be
repository link: 
https://github.com/rendyrey/test-bobobox


# how to use
1. you should create db on your host. On this repo, I use mysql for db.
you can use my schema on database/bobobox.sql
2. you have to install go on your host to be able run this repo on your host.
3. type "go run ." or "go run *.go" on command-line/terminal

# Hotel Room Search Availibility
1. You can use this example: http://localhost:8080/search?checkin_date=2020-01-10&checkout_date=2020-01-12&room_type_id=1&room_qty=1
2. To get price list of all room type available: http://localhost:8080/getListPriceRoom
3. To get promo price list: http://localhost:8080/promo/{promoId} ex: http://localhost:8080/promo/1

Postman Collection:
https://www.getpostman.com/collections/80f0a5b8a8f9d5546b4c

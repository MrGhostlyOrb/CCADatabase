--1.b 
--a)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (108, '2020-07-29', 'STN', 'BHD', 10, 70);

--b)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (109, '2020-07-29', 'STN', 'BHD', 10, 70);

--c)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (110, '2020-07-29', 'STN', 'BHD', 10, 70);

--1.c
--a)
INSERT INTO passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) VALUES (1025, 'Ernesto', 'Picazo', '3434313', 'Spanish', '1987-07-30 00:00:01');

--b)
INSERT INTO passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) VALUES (1026, 'Ernesto', 'Smith', '8383883', 'British', '2014-02-30 00:00:01');

--2
--a)
--Should delete lead customer where customer ID = 3
DELETE FROM leadcustomer WHERE customer_id = 3;
--b)
--Run task 8 for booking id 504

--c)
--Delete lead cutomer id 3
DELETE FROM leadcustomer WHERE customer_id = 3;
--3
--a)
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(SUM(flightbooking.num_seats),0) AS "Booked Seats", COALESCE(flight.max_capacity - SUM(flightbooking.num_seats),0)  AS "Avaliable Seats" FROM flight LEFT JOIN flightbooking ON flight.flight_id = flightbooking.flight_id GROUP BY flight.flight_id;

--b)
--Should be for flight 103
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(SUM(flightbooking.num_seats),0) AS "Booked Seats", COALESCE(flight.max_capacity - SUM(flightbooking.num_seats),0)  AS "Avaliable Seats" FROM flight LEFT JOIN flightbooking ON flight.flight_id = flightbooking.flight_id WHERE flight.flight_id = 103 GROUP BY flight.flight_id;

--c)
--Should be for destination BRS
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(SUM(flightbooking.num_seats),0) AS "Booked Seats", COALESCE(flight.max_capacity - SUM(flightbooking.num_seats),0)  AS "Avaliable Seats" FROM flight LEFT JOIN flightbooking ON flight.flight_id = flightbooking.flight_id WHERE flight.destination = 'BRS' GROUP BY flight.flight_id;

--d)
--Should be for date '2020-07-24'
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(SUM(flightbooking.num_seats),0) AS "Booked Seats", COALESCE(flight.max_capacity - SUM(flightbooking.num_seats),0)  AS "Avaliable Seats" FROM flight LEFT JOIN flightbooking ON flight.flight_id = flightbooking.flight_id WHERE flight.flight_date = '2020-07-24' GROUP BY flight.flight_id;

--4
--Should check status of all seats for flight 101
SELECT flight.flight_id, flightbooking.status, COUNT(flightbooking.status = 'R') AS "Reserved", COUNT(flightbooking.status = 'C') AS "Cancelled" FROM flight, flightbooking WHERE flight.flight_id = flightbooking.flight_id AND flight.flight_id = 101 GROUP BY flight.flight_id, flightbooking.status;

--5
--Ranked list of all lead customers from highest total cost to lowest
SELECT leadcustomer.customer_id, CONCAT(first_name , ' ' , last_name ) AS "Full Name", count(flightbooking.customer_id) AS "Number of Bookings", SUM (flightbooking.total_cost) AS "Total Spent" FROM leadcustomer, flightbooking WHERE leadcustomer.customer_id = flightbooking.customer_id GROUP BY leadcustomer.customer_id ORDER BY SUM(flightbooking.total_cost) DESC;

--6
--a)
INSERT INTO flightbooking (booking_id, customer_id, flight_id, num_seats, status, booking_time, total_cost) SELECT 513, 12, 103, 3, 'R', current_date, price_per_seat FROM flight * num_seats WHERE EXISTS (SELECT * FROM leadcustomer WHERE customer_id = 12 OR last_name = 'Sayers');

--b)

--c)

--d)


--7
--a)
INSERT INTO seatbooking(booking_id, passenger_id, seat_number) VALUES (510, 1024, '8A');

--b)
INSERT INTO seatbooking(booking_id, passenger_id, seat_number) VALUES (510, 1025, '8B');

--8
--a)
SELECT * FROM flightbooking WHERE booking_id = 509;

--b)
SELECT flight.flight_id, seatbooking.seat_number, flightbooking.status FROM flight, flightbooking, seatbooking WHERE flight.flight_id = flightbooking.flight_id AND flightbooking.booking_id = seatbooking.booking_id AND flight.flight_id = 504;

--c)
SELECT leadcustomer.customer_id, CONCAT(first_name , ' ' , last_name ) AS "Full Name", count(flightbooking.customer_id) AS "Number of Bookings", SUM (flightbooking.total_cost) AS "Total Spent" FROM leadcustomer, flightbooking WHERE leadcustomer.customer_id = flightbooking.customer_id GROUP BY leadcustomer.customer_id ORDER BY SUM(flightbooking.total_cost) DESC;


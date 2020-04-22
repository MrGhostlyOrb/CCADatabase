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
DELETE FROM lead_customer WHERE customer_id = 3;
--b)
--Run task 8 for booking id 504

--c)
--Delete lead cutomer id 3
DELETE FROM lead_customer WHERE customer_id = 3;
--3
--a)
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(num_seats,0) AS "Booked Seats", flight.max_capacity - COALESCE(flight_booking.num_seats,0) AS "Avaliable seats" FROM flight LEFT JOIN flight_booking ON flight.flight_id = flight_booking.flight_id WHERE flight_booking.status = 'r' OR flight_booking.status is null GROUP BY flight.flight_id, num_seats;

--b)
--Should be for flight 103
SELECT flight.flight_id, flight.flight_date, max_capacity, COALESCE(num_seats,0) AS "Booked Seats", flight.max_capacity - COALESCE(flight_booking.num_seats,0) AS "Avaliable seats" FROM flight LEFT JOIN flight_booking ON flight.flight_id = flight_booking.flight_id WHERE flight_booking.status = 'r' OR flight_booking.status is null AND flight.flight_id = 103 GROUP BY flight.flight_id, num_seats;

--c)
--Should be for destination BRS

--d)
--Should be for date '2020-07-24'

--4
--Should check status of all seats for flight 101
SELECT flight.flight_id, seat_booking.seat_number, flight_booking.status FROM flight, flight_booking, seat_booking WHERE flight.flight_id = flight_booking.flight_id AND flight_booking.booking_id = seat_booking.booking_id AND flight.flight_id = 101;

--5
--Ranked list of all lead customers from highest total cost to lowest
SELECT lead_customer.customer_id, CONCAT(first_name , ' ' , last_name ) AS "Full Name", count(flight_booking.customer_id) AS "Number of Bookings", SUM (flight_booking.total_cost) AS "Total Spent" FROM lead_customer, flight_booking WHERE lead_customer.customer_id = flight_booking.customer_id GROUP BY lead_customer.customer_id ORDER BY SUM(flight_booking.total_cost) DESC;

--6
--a)

--7
--a)
INSERT INTO seat_booking(booking_id, passenger_id, seat_number) VALUES (510, 1024, '8A');

--b)
INSERT INTO seat_booking(booking_id, passenger_id, seat_number) VALUES (510, 1025, '8B');

--8
--a)
SELECT * FROM flight_booking WHERE booking_id = 509;

--b)
SELECT flight.flight_id, seat_booking.seat_number, flight_booking.status FROM flight, flight_booking, seat_booking WHERE flight.flight_id = flight_booking.flight_id AND flight_booking.booking_id = seat_booking.booking_id AND flight.flight_id = 504;

--c)
SELECT lead_customer.customer_id, CONCAT(first_name , ' ' , last_name ) AS "Full Name", count(flight_booking.customer_id) AS "Number of Bookings", SUM (flight_booking.total_cost) AS "Total Spent" FROM lead_customer, flight_booking WHERE lead_customer.customer_id = flight_booking.customer_id GROUP BY lead_customer.customer_id ORDER BY SUM(flight_booking.total_cost) DESC;


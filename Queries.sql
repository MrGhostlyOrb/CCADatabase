--1.b 
--a)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (108, '2020-07-29', 'STN', 'BHD', 10, 70);

--b)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (109, '2020-07-29', 'STN', 'BHD', 10, 70);

--c)
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (110, '2020-07-29', 'STN', 'BHD', 10, 70);

--1.c
--a)
INSERT INTO passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) VALUES (1025, 'Ernesto', 'Picazo', '3434313', 'Spanish', '1987-07-30');

--b)
INSERT INTO passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) VALUES (1026, 'Ernesto', 'Smith', '8383883', 'British', '2014-02-30');

--3
--a)
SELECT flight.flight_id, flight_date, SUM(max_capacity - num_seats) FROM flight, flight_booking WHERE flight_booking.flight_id = flight.flight_id GROUP BY flight.flight_id;

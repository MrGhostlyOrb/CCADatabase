CREATE SCHEMA IF NOT EXISTS courseworktest;
SET search_path to courseworktest;

DROP TABLE IF EXISTS lead_customer CASCADE;
DROP TABLE IF EXISTS passenger CASCADE;
DROP TABLE IF EXISTS flight CASCADE;
DROP TABLE IF EXISTS flight_booking CASCADE;
DROP TABLE IF EXISTS seat_booking CASCADE;

CREATE TABLE IF NOT EXISTS lead_customer
(
	customer_id INTEGER UNIQUE PRIMARY KEY,
	first_name VARCHAR(20)  NOT NULL,
	last_name VARCHAR(40)  NOT NULL,
	billing_address VARCHAR(200)  NOT NULL,
	email  VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS passenger 
(
	passenger_id INTEGER UNIQUE PRIMARY KEY,
	first_name VARCHAR(20)  NOT NULL,
	last_name VARCHAR(40)  NOT NULL,
	passport_no VARCHAR(30) NOT NULL,
	nationality VARCHAR(30) NOT NULL,
	dob DATE NOT NULL,
		CONSTRAINT dob_CHK CHECK(dob < current_date),
);

CREATE TABLE IF NOT EXISTS flight 
(
	flight_id INTEGER UNIQUE PRIMARY KEY,
	flight_date TIMESTAMP NOT NULL, 
	origin VARCHAR(30) NOT NULL,
	destination VARCHAR(30) NOT NULL,
	max_capacity INTEGER NOT NULL,
	price_per_seat DECIMAL NOT NULL

);

CREATE TABLE IF NOT EXISTS flight_booking
(
	booking_id INTEGER UNIQUE PRIMARY KEY,
	customer_id INTEGER NOT NULL references lead_customer ON DELETE RESTRICT,
	flight_id INTEGER NOT NULL references flight, 
	num_seats INTEGER NOT NULL,
	status CHAR(1) NOT NULL,
	booking_time TIMESTAMP NOT NULL,
		CONSTRAINT booking_time_CHK CHECK(booking_time >= current_date),
	total_cost DECIMAL
	
);

CREATE TABLE IF NOT EXISTS seat_booking
(
	booking_id INTEGER NOT NULL references flight_booking ON DELETE RESTRICT,
	passenger_id INTEGER NOT NULL references passenger,
	seat_number CHAR(4) NOT NULL,
	PRIMARY KEY(booking_id, passenger_id, seat_number)
	
);

--Lead Customer Example
INSERT INTO lead_customer (customer_id, first_name, last_name, billing_address, email) VALUES (100, 'Dave', 'Lee', '123 Made Up Street', 'notreal@doesnotexist.com');

--Passenger Example
INSERT INTO passenger (passenger_id, first_name, last_name, passport_no, nationality, dob) VALUES (100, 'Dave', 'Lee', '55', 'GB', '2017-04-07');

--Flight Example
INSERT INTO flight (flight_id, flight_date, origin, destination, max_capacity, price_per_seat) VALUES (101, '1970-01-01 00:00:01', 'JFK', 'JFK', 30, 40);

--FlightBooking Example
INSERT INTO flight_booking (booking_id, customer_id, flight_id, num_seats, status, booking_time, total_cost) VALUES (500, 100, 101, 50, 'x', '1970-01-01 00:00:01', 1000.10);

--SeatBooking Example
INSERT INTO seat_booking (booking_id, passenger_id, seat_number) VALUES (500, 100, '6A');


CREATE TRIGGER deleteTrigger ON courseworktest.lead_customer FOR DELETE AS
DELETE FROM 

DROP TABLE lead_customer;
DROP TABLE passenger;
DROP TABLE flight;
DROP TABLE flight_booking;
DROP TABLE seat_booking;
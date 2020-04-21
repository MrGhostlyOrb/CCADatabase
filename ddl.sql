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
		CONSTRAINT dob_CHK CHECK(dob < current_date)
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
		CONSTRAINT status_CHK CHECK(status LIKE 'r%' OR status LIKE 'c%'),
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

CREATE TRIGGER deleteTrigger ON courseworktest.lead_customer FOR DELETE AS
DELETE FROM 
CREATE SCHEMA IF NOT EXISTS Coursework;
SET search_path to Coursework;

DROP TABLE IF EXISTS LeadCustomer CASCADE;
DROP TABLE IF EXISTS Passenger CASCADE;
DROP TABLE IF EXISTS Flight CASCADE;
DROP TABLE IF EXISTS FlightBooking CASCADE;
DROP TABLE IF EXISTS SeatBooking CASCADE;

CREATE TABLE IF NOT EXISTS LeadCustomer
(
	customer_id INTEGER UNIQUE PRIMARY KEY,
	first_name VARCHAR(20)  NOT NULL,
	last_name VARCHAR(40)  NOT NULL,
	billing_address VARCHAR(200)  NOT NULL,
	email  VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Passenger 
(
	passenger_id INTEGER UNIQUE PRIMARY KEY,
	first_name VARCHAR(20)  NOT NULL,
	last_name VARCHAR(40)  NOT NULL,
	passport_no VARCHAR(30) NOT NULL,
	nationality VARCHAR(30) NOT NULL,
	dob DATE NOT NULL,
		CONSTRAINT dob_CHK CHECK(dob < current_date)
);

CREATE TABLE IF NOT EXISTS Flight 
(
	flight_id INTEGER UNIQUE PRIMARY KEY,
	flight_date TIMESTAMP NOT NULL, 
	origin VARCHAR(30) NOT NULL,
	destination VARCHAR(30) NOT NULL,
	max_capacity INTEGER NOT NULL,
	price_per_seat DECIMAL NOT NULL

);

CREATE TABLE IF NOT EXISTS FlightBooking
(
	booking_id INTEGER UNIQUE PRIMARY KEY,
	customer_id INTEGER NOT NULL references LeadCustomer ON DELETE RESTRICT,
	flight_id INTEGER NOT NULL references Flight, 
	num_seats INTEGER NOT NULL,
	status CHAR(1) NOT NULL,
		CONSTRAINT status_CHK CHECK(status LIKE 'R%' OR status LIKE 'C%'),
	booking_time TIMESTAMP NOT NULL,
		CONSTRAINT booking_time_CHK CHECK(booking_time >= current_date),
	total_cost DECIMAL
	
);

CREATE TABLE IF NOT EXISTS SeatBooking
(
	booking_id INTEGER NOT NULL references FlightBooking ON DELETE RESTRICT,
	passenger_id INTEGER NOT NULL references Passenger,
	seat_number CHAR(4) NOT NULL,
	PRIMARY KEY(booking_id, passenger_id, seat_number)
	
); 


CREATE OR REPLACE FUNCTION CheckSeatNum()
 RETURNS trigger AS
$$
begin
 if ((SELECT Coalesce(flight.max_capacity - SUM(flightbooking.num_seats),0) - new.num_seats FROM flight, flightbooking
WHERE flight.flight_id = flightbooking.flight_id AND flightbooking.status != 'C' GROUP BY flight.flight_id HAVING flight.flight_id = new.flight_id) < 0)
then raise EXCEPTION 'Seats cannot be booked';
 else
return new;
 end if;
end;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_num_seats
 BEFORE INSERT
 ON flightbooking
 FOR EACH ROW
 EXECUTE PROCEDURE CheckSeatNum();



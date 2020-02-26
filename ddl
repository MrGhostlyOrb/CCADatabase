CREATE SCHEMA IF NOT EXISTS CourseworkTest;
SET search_path to CourseworkTest;

CREATE TABLE IF NOT EXISTS LeadCustomer 
(
	CustomerID INTEGER UNIQUE PRIMARY KEY,
	FirstName VARCHAR(20)  NOT NULL,
	Surname VARCHAR(40)  NOT NULL,
	BillingAddress VARCHAR(200)  NOT NULL,
	email  VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Passenger 
(
	PassengerID INTEGER UNIQUE PRIMARY KEY,
	FirstName VARCHAR(20)  NOT NULL,
	Surname VARCHAR(40)  NOT NULL,
	PassportNo VARCHAR(30) NOT NULL,
	Nationality VARCHAR(30) NOT NULL,
	Dob DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Flight 
(
	FlightID INTEGER UNIQUE PRIMARY KEY,
	FlightDate TIMESTAMP NOT NULL, 
	Origin VARCHAR(30) NOT NULL,
	Destination VARCHAR(30) NOT NULL,
	MaxCapacity INTEGER NOT NULL,
	PricePerSeat DECIMAL NOT NULL

);

CREATE TABLE IF NOT EXISTS FlightBooking 
(
	BookingID INTEGER UNIQUE PRIMARY KEY,
	CustomerID INTEGER NOT NULL references LeadCustomer ON DELETE RESTRICT,
	FlightID INTEGER NOT NULL references Flight, 
	NumSeats INTEGER NOT NULL,
	Status CHAR(1) NOT NULL,
	BookingTime TIMESTAMP NOT NULL,
	TotalCost DECIMAL
	
);

CREATE TABLE IF NOT EXISTS SeatBooking
(
	BookingID INTEGER NOT NULL references FlightBooking ON DELETE RESTRICT,
	PassengerID INTEGER NOT NULL references Passenger,
	SeatNumber CHAR(4) NOT NULL,
	PRIMARY KEY(BookingID, PassengerID, SeatNumber)
	
);

--Lead Customer Example
INSERT INTO LeadCustomer (CustomerID, FirstName, Surname, BillingAddress, email) VALUES (100, 'Dave', 'Lee', '123 Made Up Street', 'notreal@doesnotexist.com');

--Passenger Example
INSERT INTO Passenger (PassengerID, FirstName, Surname, PassportNo, Nationality, Dob) VALUES (100, 'Dave', 'Lee', '55', 'GB', '2017-04-07');

--Flight Example
INSERT INTO Flight (FlightID, FlightDate, Origin, Destination, MaxCapacity, PricePerSeat) VALUES (101, '1970-01-01 00:00:01', 'JFK', 'JFK', 30, 40);

--FlightBooking Example
INSERT INTO FlightBooking (BookingID, CustomerID, FlightID, NumSeats, Status, BookingTime, TotalCost) VALUES (500, 100, 101, 50, 'x', '1970-01-01 00:00:01', 1000.10);

--SeatBooking Example
INSERT INTO SeatBooking (BookingID, PassengerID, SeatNumber) VALUES (500, 100, '6A');


CREATE TRIGGER deleteTrigger ON CourseworkTest.LeadCustomer FOR DELETE AS
DELETE FROM 

DROP TABLE LeadCustomer;
DROP TABLE Passenger;
DROP TABLE Flight;
DROP TABLE FlightBooking;
DROP TABLE SeatBooking;
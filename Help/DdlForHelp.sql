DROP DATABASE IF EXISTS property;  #erase the database if it exists
CREATE DATABASE property;          #create a new database
USE property;                      #use the database

CREATE TABLE property(
  propertyID INT AUTO_INCREMENT,
  address varchar(40),
  PRIMARY KEY(propertyID)
  );
  
CREATE TABLE tenant(
  tenantID INT AUTO_INCREMENT,
  firstName varchar(40),
  lastName varchar(40),
  PRIMARY KEY(tenantID)
  );
  
CREATE TABLE contractor(
  contractorID INT AUTO_INCREMENT,
  companyName varchar(40),
  trade varchar(40),
  PRIMARY KEY(contractorID)
  );
  
CREATE TABLE rental(
  rentalID INT AUTO_INCREMENT,
  tenantID INT,
  propertyID INT,
  PRIMARY KEY(rentalID),
  FOREIGN KEY tenant_key(tenantID) REFERENCES tenant(tenantID),
  FOREIGN KEY property_key(propertyID) REFERENCES property(propertyID)
  ); 
  
CREATE TABLE _job(
  jobID INT AUTO_INCREMENT,
  contractorID INT,
  propertyID INT,
  details varchar(40),
  PRIMARY KEY(jobID),
  FOREIGN KEY contractor_key(contractorID) REFERENCES contractor(contractorID),
  FOREIGN KEY property_key2(propertyID) REFERENCES property(propertyID)
  );
  
CREATE TABLE rent(
  rentID INT AUTO_INCREMENT,
  rentalID INT,
  payment FLOAT,
  _month varchar(10),
  PRIMARY KEY(rentID),
  FOREIGN KEY rental_key(rentalID) REFERENCES rental(rentalID)
  );
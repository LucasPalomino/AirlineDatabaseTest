USE [Airline Database]

CREATE TABLE Airplane
(
Airplane_number varchar(5),
Capacity int,
model varchar(15),

CONSTRAINT PK_Airplane PRIMARY KEY(Airplane_number)
)

CREATE TABLE Flight
(
Flight_key varchar(6),
Origin varchar(20),
Destination varchar(21),
Departure_time DATETIME,
Arrival_time DATETIME,
Airplane_number varchar(5),

CONSTRAINT PK_Flight PRIMARY KEY(Flight_key),
CONSTRAINT FK_Flight_Airplane FOREIGN KEY(Airplane_number)
	REFERENCES Airplane(Airplane_number)
)

CREATE TABLE Customer
(
First_name varchar(30),
Last_name varchar(31),
SSN varchar(9),

CONSTRAINT PK_Customer PRIMARY KEY(SSN)
)

CREATE TABLE Purchases
(
Flight_key varchar(6),
Customer_SSN varchar(9),
Purchase_date DATE,
Purchase_price MONEY,

CONSTRAINT PK_Purchases PRIMARY KEY(Flight_key,Customer_SSN),
CONSTRAINT FK_Purchases_Flight FOREIGN KEY(Flight_key)
	REFERENCES Flight(Flight_key),
CONSTRAINT FK_Purchases_Customer FOREIGN KEY(Customer_SSN)
	REFERENCES Customer(SSN)
)


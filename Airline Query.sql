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

----- Inserts -----
SELECT * FROM Airplane
SELECT * FROM Flight
SELECT * FROM Purchases
SELECT * FROM Customer

INSERT INTO Airplane(Airplane_number,model,Capacity)
VALUES('1227','Boeing',100),('2325','Rizer',150),('9922','Virgin',30),('1132','Cirus',160)

INSERT INTO Flight(Flight_key,Airplane_number,Origin,Destination,Departure_time,Arrival_time)
VALUES ('AB12','1227','Sao Paulo','Bogota','2023-12-21 10:15:00','2023-12-21 13:30:00'),
	   ('FF11','1227','Chicago','Florida','2023-05-12 10:40:00','2023-05-12 14:10:00'),
	   ('SC56','9922','Tokyo','Florence','2023-04-09 05:55:00','2023-04-09 09:25:00'),
	   ('TE28','1132','Paris','New York','2023-07-24 17:30:00','2023-07-24 21:30:00'),
	   ('PO86','2325','Seul','Kadmanthu','2023-12-12 04:00:00','2023-12-13 04:00:00')

INSERT INTO Customer(First_name,Last_name,SSN)
VALUES('Lucas','Palomino','160237552'),('Tamami','Igeta','111333456'),('Sofia','Candela','939212583'),
	  ('Sam','Samuel','333656432'),('Thomas','Barton','142632777'),('Eduardo','Marquez','888222034')

INSERT INTO Purchases(Flight_key,Customer_SSN,Purchase_date,Purchase_price)
VALUES('AB12','160237552','2023-05-12',500),('SC56','111333456','2023-07-12',300),('FF11','939212583','2023-04-12',200),
	  ('FF11','160237552','2023-05-12',700),('TE28','142632777','2023-12-10',600),('TE28','888222034','2023-08-02',500)

-----------------

INSERT INTO Airplane(Airplane_number,model,Capacity)
VALUES('3333','TinyCo',1)

INSERT INTO Flight(Flight_key,Airplane_number,Origin,Destination,Departure_time,Arrival_time)
VALUES ('AA11','1132','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00'),
	   ('AA32','1227','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00'),
	   ('AA21','3333','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00'),
	   ('AA51','1132','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00'),
	   ('AA61','9922','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00'),
	   ('AA71','9922','Duluth','Duluth','2023-01-01 11:30:00','2023-01-01 13:30:00')

INSERT INTO Purchases(Flight_key,Customer_SSN,Purchase_date,Purchase_price)
VALUES('AA71','160237552','2023-05-12',500),('AA71','111333456','2023-07-12',300),
	  ('AA71','142632777','2023-05-12',500),('AA61','111333456','2023-07-12',300),
	  ('AA32','160237552','2023-05-12',500),('AA61','160237552','2023-07-12',300)

------ Querys -----------

SELECT Flight.Flight_key
FROM Flight INNER JOIN Airplane
ON Flight.Airplane_number = Airplane.Airplane_number
WHERE(SELECT COUNT(1) FROM Purchases) > Airplane.Capacity

SELECT *
FROM
(SELECT Customer.First_name, COUNT(1) AS Test FROM Customer GROUP BY Customer.First_name) AS Cus1
INNER JOIN
(SELECT Customer.First_name, COUNT(1) AS Test FROM Customer GROUP BY Customer.First_name) AS Cus2
ON Cus1.First_name = Cus2.First_name

--- Flight_key of all flights whose price for the same flight had seats with a difference in price of at least $300

SELECT MaxPrices.Flight_key
FROM 
(
(SELECT Purchases.Flight_key, MAX(Purchases.Purchase_price) AS MaxPrice 
FROM Purchases 
GROUP BY Purchases.Flight_key) AS MaxPrices
INNER JOIN
(SELECT Purchases.Flight_key, MIN(Purchases.Purchase_price) AS MinPrice 
FROM Purchases
GROUP BY Purchases.Flight_key) AS MinPrices
ON MaxPrices.Flight_key = MinPrices.Flight_key
)
WHERE MaxPrices.MaxPrice - MinPrices.MinPrice >= 300

--- Airplane model of top 3 most sold flights originating from Duluth


SELECT Airplane.model, COUNT(1) AS FlightsSold
FROM Purchases INNER JOIN 
(SELECT Flight.Flight_key, Flight.Airplane_number FROM Flight WHERE Flight.origin = 'Duluth') AS DuluthFlights
ON Purchases.Flight_key = DuluthFlights.Flight_key
INNER JOIN Airplane ON DuluthFlights.Airplane_number = Airplane.Airplane_number
GROUP BY Airplane.model
ORDER BY FlightsSold DESC

SELECT TOP 3 SoldFlights.model, COUNT(1) AS AmountSold
FROM 
(SELECT Airplane.model,Flight.Origin
 FROM Purchases INNER JOIN Flight
 ON Purchases.Flight_key = Flight.Flight_key
 INNER JOIN Airplane
 ON Flight.Airplane_number = Airplane.Airplane_number
) AS SoldFlights
GROUP BY SoldFlights.model



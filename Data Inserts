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

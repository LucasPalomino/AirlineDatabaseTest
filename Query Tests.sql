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

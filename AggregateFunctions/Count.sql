USE Northwind

-- SELECT ColName, HamGomNhom(), ...from <Table>
-- SELECT ColName, HamGomNhom(), ...from <Table> WHERE... GROUP BY (GomTheoCumColumnNao)
-- SELECT ColName, HamGomNhom(), ...from <Table> WHERE... GROUP BY (GomTheoCumColumnNao) HAVING
-- COUNT(*): count rows
-- COUNT(nameColumn): count column with value (or without NULL)

SELECT * from Employees
SELECT COUNT(*) AS [Number of employees] from Employees
SELECT COUNT(*) AS [No employees] from Employees WHERE City = 'London'

SELECT COUNT(City) from Employees
SELECT COUNT(Region) from Employees

SELECT DISTINCT City from Employees
SELECT COUNT(*) from (SELECT DISTINCT City from Employees) AS [No Cities]
--<=> 
SELECT COUNT(DISTINCT City) from Employees

SELECT City, COUNT(City) AS [No employees] from Employees GROUP BY City

SELECT City, COUNT(City) AS [No employees] from Employees GROUP BY City HAVING COUNT(City) >= 2

SELECT City, COUNT(City) from Employees WHERE City IN('London', 'Seattle') GROUP BY City

SELECT * from Orders WHERE ShipCountry = 'USA'
SELECT COUNT(ShipCountry) AS [No Orders from USA] from Orders WHERE ShipCountry = 'USA'
SELECT ShipCountry, COUNT(*) AS [No Orders] from Orders WHERE ShipCountry IN('France', 'UK', 'USA') GROUP BY ShipCountry
SELECT ShipCountry, COUNT(*) from Orders WHERE ShipCountry IN('France', 'UK', 'USA') 
										GROUP BY ShipCountry HAVING COUNT (ShipCountry) >= 100
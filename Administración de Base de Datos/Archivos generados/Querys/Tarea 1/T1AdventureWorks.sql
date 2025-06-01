-- Seleccionar la base de datos AdventureWorks2019
USE AdventureWorks2019;
GO

-- Ver los empleados y sus cargos
SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee;
GO

-- Seleccionar la base de datos AdventureWorksDW2019
USE AdventureWorksDW2019;
GO

-- Ver algunos clientes del data warehouse
SELECT TOP 10 CustomerKey, GeographyKey, Gender, YearlyIncome
FROM dbo.DimCustomer;
GO

-- Ver algunas ventas por producto
SELECT TOP 10 ProductKey, OrderDateKey, SalesAmount
FROM dbo.FactInternetSales
ORDER BY SalesAmount DESC;
GO
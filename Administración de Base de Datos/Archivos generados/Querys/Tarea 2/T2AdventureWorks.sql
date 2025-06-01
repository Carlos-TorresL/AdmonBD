--Creación de usuarios a nivel servidor
USE [master];
GO

--Creación login
CREATE LOGIN Lector WITH PASSWORD = '123';
GO

--Creación de usuarios en la base de datos
USE AdventureWorks2019;
GO

--Creación del usuario de Solo Lectura
CREATE USER AdventureLector FOR LOGIN Lector;
-- Asignar rol de solo lectura (db_datareader)
EXEC sp_addrolemember 'db_datareader', 'AdventureLector';
GO

USE AdventureWorks2019;
GO
--Pruebas de verificación
SELECT TOP 5 BusinessEntityID, FirstName, LastName -- Permitido
FROM Person.Person;
GO

ALTER TABLE Person.Person ADD prueba_columna INT; -- No Permitido
GO
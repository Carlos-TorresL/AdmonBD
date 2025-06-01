--Creación de usuarios a nivel servidor
USE [master];
GO

--Primer login
CREATE LOGIN LoginTest WITH PASSWORD = '123';
GO

--Segundo login
CREATE LOGIN Enfermero With PASSWORD = '123';
GO

--Creación de usuarios en la base de datos
USE ExpedientesClinicos;
GO

--Creación del usuario de Solo Lectura
CREATE USER UsuarioLector FOR LOGIN LoginTest;
-- Asignar rol de solo lectura (db_datareader)
EXEC sp_addrolemember 'db_datareader', 'UsuarioLector';
GO

--Creación del usuario de Solo Lectura de una tabla individual
CREATE USER UsuarioEnfermero FOR LOGIN Enfermero;
--Creación del rol de Solo Lectura para la tabla Paciente
CREATE ROLE RolSoloLecturaPaciente;
GRANT SELECT ON dbo.Paciente TO RolSoloLecturaPaciente;
-- Asignar el rol al usuario
EXEC sp_addrolemember 'RolSoloLecturaPaciente', 'UsuarioEnfermero';
GO

--Pruebas 
USE ExpedientesClinicos;
GO
-- Como UsuarioLector
SELECT * FROM dbo.Paciente; -- Permitido
GO
UPDATE Paciente --No Permitido
SET domicilio_paciente = 'Nuevo domicilio de prueba'
WHERE paciente_id = 1;
GO

-- Como UsuarioEnfermero
SELECT * FROM dbo.Paciente; -- Permitido

SELECT * FROM dbo.PrestadorServicios; -- No Permitido

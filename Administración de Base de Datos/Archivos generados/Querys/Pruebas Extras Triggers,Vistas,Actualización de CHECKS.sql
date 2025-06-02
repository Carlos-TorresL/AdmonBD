-- Decimos que vamos a usar la base de datos "ExpedientesClinicos"
USE ExpedientesClinicos;
GO

--Prueba de Trigger
SELECT * FROM ExpedientesClinicos WHERE paciente_id IN (1, 2);

DELETE FROM Paciente WHERE paciente_id = 1;

--Prueba de Vista
SELECT * FROM VistaEvolucionClinica;
SELECT * FROM Paciente;

--Actualización de CHECKS
--Consulto el nombre de los CHECKS de "ExploraciónFísica"
SELECT name
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('ExploracionFisica');

--Elimino el CHECK
ALTER TABLE ExploracionFisica
DROP CONSTRAINT CK__Exploraci__tempe__4BAC3F29;

--Agrego el nuevo CHECK
ALTER TABLE ExploracionFisica
ADD CONSTRAINT CK_Temperatura_Rango
CHECK (temperatura BETWEEN 35.0 AND 38.0);

SELECT * FROM ExploracionFisica;


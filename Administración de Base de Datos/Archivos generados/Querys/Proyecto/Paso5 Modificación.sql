USE ExpedientesClinicos;
GO

ALTER TABLE Establecimiento
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE PrestadorServicios
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE Paciente
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE ExpedientesClinicos
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE NotasMedicas
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE HistoriaClinica
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE ExploracionFisica
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE EstudioDiagnostico
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE NotasEvolucion
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE NotasInterconsulta
ADD deleted BIT NOT NULL DEFAULT 0;
GO

ALTER TABLE NotasTraslado
ADD deleted BIT NOT NULL DEFAULT 0;
GO

SELECT TOP 2 * FROM Paciente;
SELECT TOP 2 * FROM NotasMedicas;
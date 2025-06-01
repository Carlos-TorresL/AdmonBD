
-- Creación de la base de datos "ExpedientesClinicos"
CREATE DATABASE ExpedientesClinicos;
GO

-- Decimos que vamos a usar la base de datos "ExpedientesClinicos"
USE ExpedientesClinicos;
GO

-- Creación de la tabla "Establecimiento"
CREATE TABLE Establecimiento (
    establecimiento_id INT PRIMARY KEY IDENTITY(1,1),
    tipo_establecimiento VARCHAR(255) NOT NULL,
    nombre_establecimiento VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255) NOT NULL,
    nombre_institucion VARCHAR(255) NOT NULL,
    denominacion_social VARCHAR(255) NOT NULL
);
GO

-- Creación de la tabla "PrestadorServicios"
CREATE TABLE PrestadorServicios (
    prestador_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_prestador VARCHAR(255) NOT NULL,
    sexo_prestador VARCHAR(10) CHECK (sexo_prestador IN ('Masculino', 'Femenino')),
    tipo_contrato VARCHAR(100),
    establecimiento_id INT,
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimiento(establecimiento_id)
);
GO

-- Creación de la tabla "Paciente"
CREATE TABLE Paciente (
    paciente_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_paciente VARCHAR(255),
    sexo_paciente VARCHAR(10) CHECK (sexo_paciente IN ('Masculino', 'Femenino')),
    fecha_nacimiento DATE NOT NULL,
    domicilio_paciente VARCHAR(255) NOT NULL
);
GO

-- Creación de la tabla "ExpedienteClinico"
CREATE TABLE ExpedientesClinicos (
    expediente_id INT PRIMARY KEY IDENTITY(1,1),
    paciente_id INT,
    prestador_id INT,
    establecimiento_id INT,
    fecha_creacion DATETIME NOT NULL,
    Diagnostico TEXT NOT NULL,
    Tratamiento TEXT NOT NULL,
    Observaciones TEXT,
    FOREIGN KEY (paciente_id) REFERENCES Paciente(paciente_id),
    FOREIGN KEY (prestador_id) REFERENCES PrestadorServicios(prestador_id),
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimiento(establecimiento_id)
);
GO

-- Creación de la tabla "NotasMedicas"
CREATE TABLE NotasMedicas (
    nota_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    fecha_hora DATETIME DEFAULT GETDATE(),
    nombre_autor VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    firma TEXT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de la tabla "HistoriaClinica"
CREATE TABLE HistoriaClinica (
    historia_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    ficha_identificacion TEXT NOT NULL,
    grupo_etnico VARCHAR(100),
    antecedentes_heredo_familiares TEXT NOT NULL,
    antecedentes_personales_patologicos TEXT NOT NULL,
    uso_sustancias TEXT NOT NULL,
    antecedentes_no_patologicos TEXT NOT NULL,
    padecimiento_actual TEXT NOT NULL,
    interrogatorio_sistemas TEXT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de la tabla "ExploracionFisica"
CREATE TABLE ExploracionFisica (
    exploracion_id INT PRIMARY KEY IDENTITY(1,1),
    historia_id INT NOT NULL,
    habitus_exterior TEXT NOT NULL,
    temperatura DECIMAL(4,2) NOT NULL CHECK (temperatura BETWEEN 30.0 AND 45.0),
    tension_arterial VARCHAR(20) NOT NULL,
    frecuencia_cardiaca INT NOT NULL CHECK (frecuencia_cardiaca > 0), 
    frecuencia_respiratoria INT NOT NULL CHECK (frecuencia_respiratoria > 0),
    peso DECIMAL(5,2) NOT NULL CHECK (peso > 0),
    talla DECIMAL(5,2) NOT NULL CHECK (talla > 0),
    observaciones TEXT,
    FOREIGN KEY (historia_id) REFERENCES HistoriaClinica(historia_id)
);
GO

-- Creación de la tabla "EstudioDiagnostico"
CREATE TABLE EstudioDiagnostico (
    estudio_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    tipo_estudio VARCHAR(255) NOT NULL,
    resultados TEXT NOT NULL,
    fecha_estudio DATETIME NOT NULL CHECK (fecha_estudio <= GETDATE()),
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de la tabla "NotasEvolucion"
CREATE TABLE NotasEvolucion (
    evolucion_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    evolucion_clinica TEXT NOT NULL,
    signos_vitales TEXT NOT NULL,
    resultados_estudios TEXT NOT NULL,
    diagnostico TEXT NOT NULL,
    pronostico TEXT NOT NULL,
    tratamiento TEXT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de la tabla "NotasInterconsulta"
CREATE TABLE NotasInterconsulta (
    interconsulta_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    criterios_diagnosticos TEXT NOT NULL,
    plan_estudios TEXT NOT NULL,
    sugerencias TEXT,
    observaciones TEXT,
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de la tabla "NotasTraslado"
CREATE TABLE NotasTraslado (
    traslado_id INT PRIMARY KEY IDENTITY(1,1),
    expediente_id INT NOT NULL,
    establecimiento_envia VARCHAR(255) NOT NULL,
    establecimiento_receptor VARCHAR(255) NOT NULL,
    motivo_envio TEXT NOT NULL,
    impresion_diagnostica TEXT NOT NULL,
    terapeutica_empleada TEXT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (expediente_id) REFERENCES ExpedientesClinicos(expediente_id)
);
GO

-- Creación de índices
CREATE INDEX idx_expediente_estudios ON EstudioDiagnostico(expediente_id);
GO
CREATE INDEX idx_historia_expediente ON HistoriaClinica(expediente_id);
GO
CREATE INDEX idx_evolucion_expediente ON NotasEvolucion(expediente_id);
GO
CREATE INDEX idx_interconsulta_expediente ON NotasInterconsulta(expediente_id);
GO
CREATE INDEX idx_traslado_expediente ON NotasTraslado(expediente_id);
GO

--Creación de triggers
--Para prevenir eliminar registros que tengan un expediente clinico
--Trigger de "Paciente"
CREATE TRIGGER trigger_Paciente
ON Paciente
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM ExpedientesClinicos
        WHERE paciente_id IN (SELECT paciente_id FROM deleted)
    )
    BEGIN
        RAISERROR ('No se puede eliminar el paciente porque tiene un expediente.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Paciente WHERE paciente_id IN (SELECT paciente_id FROM deleted);
    END
END;
GO
--Trigger de "Establecimiento"
CREATE TRIGGER trigger_Establecimiento
ON Establecimiento
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM PrestadorServicios
        WHERE establecimiento_id IN (SELECT establecimiento_id FROM deleted)
    ) OR EXISTS (
        SELECT 1 FROM ExpedientesClinicos
        WHERE establecimiento_id IN (SELECT establecimiento_id FROM deleted)
    )
    BEGIN
        RAISERROR ('No se puede eliminar el establecimiento porque tiene datos relacionados.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Establecimiento
        WHERE establecimiento_id IN (SELECT establecimiento_id FROM deleted);
    END
END;
GO

--Para prevenir eliminar expedientes clinicos que tengan: historia clinica, notas medicas, etc...
--Trigger de "ExpedienteClinico"
CREATE TRIGGER trigger_Expediente
ON ExpedientesClinicos
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM NotasMedicas
        WHERE expediente_id IN (SELECT expediente_id FROM deleted)
    )
    OR EXISTS (
        SELECT 1 FROM HistoriaClinica
        WHERE expediente_id IN (SELECT expediente_id FROM deleted)
    )
    OR EXISTS (
        SELECT 1 FROM NotasEvolucion
        WHERE expediente_id IN (SELECT expediente_id FROM deleted)
    )
    OR EXISTS (
        SELECT 1 FROM NotasInterconsulta
        WHERE expediente_id IN (SELECT expediente_id FROM deleted)
    )
    OR EXISTS (
        SELECT 1 FROM NotasTraslado
        WHERE expediente_id IN (SELECT expediente_id FROM deleted)
    )
    BEGIN
        RAISERROR ('No se puede eliminar el expediente clínico porque tiene registros asociados.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM ExpedientesClinicos
        WHERE expediente_id IN (SELECT expediente_id FROM deleted);
    END
END;
GO

--Creación de Vistas
--Vista de "Evolución Clinica de Paciente"
CREATE VIEW VistaEvolucionClinica AS
SELECT 
    p.nombre_paciente,
    e.expediente_id,
    ne.fecha,
    ne.evolucion_clinica,
    ne.diagnostico,
    ne.tratamiento
FROM NotasEvolucion ne
JOIN ExpedientesClinicos e ON ne.expediente_id = e.expediente_id
JOIN Paciente p ON e.paciente_id = p.paciente_id;
GO
--Vista de "Resumen de Expediente"
CREATE VIEW VistaResumenExpediente AS
SELECT 
    e.expediente_id,
    p.nombre_paciente,
    ps.nombre_prestador,
    est.nombre_establecimiento,
    e.fecha_creacion,
    e.Diagnostico,
    e.Tratamiento
FROM ExpedientesClinicos e
JOIN Paciente p ON e.paciente_id = p.paciente_id
JOIN PrestadorServicios ps ON e.prestador_id = ps.prestador_id
JOIN Establecimiento est ON e.establecimiento_id = est.establecimiento_id;
GO

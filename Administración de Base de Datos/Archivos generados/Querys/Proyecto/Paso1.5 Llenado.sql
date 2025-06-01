
USE ExpedientesClinicos;
GO

-- Establecimientos
INSERT INTO Establecimiento (tipo_establecimiento, nombre_establecimiento, domicilio, nombre_institucion, denominacion_social)
VALUES 
('Hospital', 'Hospital Central', 'Av. Reforma 123', 'Instituto Nacional de Salud', 'INS S.A.'),
('Cl�nica', 'Cl�nica del Norte', 'Calle 45 #789', 'Salud P�blica', 'SP S.A.');
GO

-- Prestador de Servicios
INSERT INTO PrestadorServicios (nombre_prestador, sexo_prestador, tipo_contrato, establecimiento_id)
VALUES
('Dr. Juan P�rez', 'Masculino', 'Contrato Indefinido', 1),
('Dra. Ana G�mez', 'Femenino', 'Contrato Temporal', 2);
GO

-- Pacientes
INSERT INTO Paciente (nombre_paciente, sexo_paciente, fecha_nacimiento, domicilio_paciente)
VALUES
('Luis Mart�nez', 'Masculino', '1980-05-20', 'Calle Luna 123'),
('Mar�a S�nchez', 'Femenino', '1992-10-15', 'Av. Sol 456');
GO

-- Expedientes Cl�nicos
INSERT INTO ExpedientesClinicos (paciente_id, prestador_id, establecimiento_id, fecha_creacion, Diagnostico, Tratamiento, Observaciones)
VALUES
(1, 1, 1, GETDATE(), 'Hipertensi�n arterial', 'Medicamento A, control de dieta', 'Paciente con buen progreso'),
(2, 2, 2, GETDATE(), 'Diabetes tipo 2', 'Insulina, dieta y ejercicio', NULL);
GO

-- Notas M�dicas
INSERT INTO NotasMedicas (expediente_id, nombre_autor, contenido, firma)
VALUES
(1, 'Dr. Juan P�rez', 'Control de presi�n arterial estable', 'firma'),
(2, 'Dra. Ana G�mez', 'Ajuste de dosis de insulina', 'firma');
GO

-- Historia Cl�nica
INSERT INTO HistoriaClinica (expediente_id, ficha_identificacion, grupo_etnico, antecedentes_heredo_familiares, antecedentes_personales_patologicos, uso_sustancias, antecedentes_no_patologicos, padecimiento_actual, interrogatorio_sistemas)
VALUES
(1, 'Identificaci�n completa del paciente Luis Mart�nez', 'Mestizo', 'Padre con hipertensi�n', 'Hipertensi�n desde 2015', 'No', 'No fuma ni bebe', 'Presi�n alta controlada', 'Sin s�ntomas neurol�gicos'),
(2, 'Identificaci�n completa de Mar�a S�nchez', 'Mestizo', 'Madre con diabetes', 'Diagn�stico reciente de diabetes', 'No', 'No fuma', 'Control gluc�mico', 'Fatiga frecuente');
GO

-- Exploraci�n F�sica
INSERT INTO ExploracionFisica (historia_id, habitus_exterior, temperatura, tension_arterial, frecuencia_cardiaca, frecuencia_respiratoria, peso, talla, observaciones)
VALUES
(1, 'Buen estado general', 36.8, '120/80', 75, 16, 70.5, 1.75, 'Sin anomal�as visibles'),
(2, 'Estado general aceptable', 37.0, '130/85', 80, 18, 65.0, 1.65, 'Observaciones normales');
GO

-- Estudios Diagn�sticos
INSERT INTO EstudioDiagnostico (expediente_id, tipo_estudio, resultados, fecha_estudio)
VALUES
(1, 'Electrocardiograma', 'Ritmo sinusal normal', GETDATE()),
(2, 'Perfil gluc�mico', 'Glucosa en ayunas elevada', GETDATE());
GO

-- Notas Evoluci�n
INSERT INTO NotasEvolucion (expediente_id, evolucion_clinica, signos_vitales, resultados_estudios, diagnostico, pronostico, tratamiento)
VALUES
(1, 'Mejora progresiva de presi�n arterial', 'TA 120/80, FC 75', 'Electrocardiograma normal', 'Hipertensi�n controlada', 'Buen pron�stico', 'Medicamentos continuados'),
(2, 'Glucosa estable con tratamiento', 'TA 130/85, FC 80', 'Perfil gluc�mico en rango', 'Diabetes tipo 2 estable', 'Pron�stico reservado', 'Insulina y dieta');
GO

-- Notas Interconsulta
INSERT INTO NotasInterconsulta (expediente_id, criterios_diagnosticos, plan_estudios, sugerencias, observaciones)
VALUES
(1, 'Hipertensi�n arterial', 'Monitoreo ambulatorio de presi�n', 'Continuar tratamiento', 'Paciente coopera bien'),
(2, 'Diabetes tipo 2', 'Controles mensuales', 'Evaluar funci�n renal', NULL);
GO

-- Notas Traslado
INSERT INTO NotasTraslado (expediente_id, establecimiento_envia, establecimiento_receptor, motivo_envio, impresion_diagnostica, terapeutica_empleada)
VALUES
(1, 'Hospital Central', 'Hospital Regional', 'Control especializado', 'Hipertensi�n bien controlada', 'Medicamentos y dieta'),
(2, 'Cl�nica del Norte', 'Hospital General', 'Complicaciones metab�licas', 'Diabetes tipo 2 con buen manejo', 'Insulina ajustada');
GO

--Ver el contenido
SELECT * FROM Establecimiento;
GO
SELECT * FROM PrestadorServicios;
GO
SELECT * FROM Paciente;
GO
SELECT * FROM ExpedientesClinicos;
GO
SELECT * FROM NotasMedicas;
GO
SELECT * FROM HistoriaClinica;
GO
SELECT * FROM ExploracionFisica;
GO
SELECT * FROM EstudioDiagnostico;
GO
SELECT * FROM NotasEvolucion;
GO
SELECT * FROM NotasInterconsulta;
GO
SELECT * FROM NotasTraslado;
GO
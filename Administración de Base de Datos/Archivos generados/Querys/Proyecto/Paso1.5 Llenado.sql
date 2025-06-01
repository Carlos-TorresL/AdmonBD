
USE ExpedientesClinicos;
GO

-- Establecimientos
INSERT INTO Establecimiento (tipo_establecimiento, nombre_establecimiento, domicilio, nombre_institucion, denominacion_social)
VALUES 
('Hospital', 'Hospital Central', 'Av. Reforma 123', 'Instituto Nacional de Salud', 'INS S.A.'),
('Clínica', 'Clínica del Norte', 'Calle 45 #789', 'Salud Pública', 'SP S.A.');
GO

-- Prestador de Servicios
INSERT INTO PrestadorServicios (nombre_prestador, sexo_prestador, tipo_contrato, establecimiento_id)
VALUES
('Dr. Juan Pérez', 'Masculino', 'Contrato Indefinido', 1),
('Dra. Ana Gómez', 'Femenino', 'Contrato Temporal', 2);
GO

-- Pacientes
INSERT INTO Paciente (nombre_paciente, sexo_paciente, fecha_nacimiento, domicilio_paciente)
VALUES
('Luis Martínez', 'Masculino', '1980-05-20', 'Calle Luna 123'),
('María Sánchez', 'Femenino', '1992-10-15', 'Av. Sol 456');
GO

-- Expedientes Clínicos
INSERT INTO ExpedientesClinicos (paciente_id, prestador_id, establecimiento_id, fecha_creacion, Diagnostico, Tratamiento, Observaciones)
VALUES
(1, 1, 1, GETDATE(), 'Hipertensión arterial', 'Medicamento A, control de dieta', 'Paciente con buen progreso'),
(2, 2, 2, GETDATE(), 'Diabetes tipo 2', 'Insulina, dieta y ejercicio', NULL);
GO

-- Notas Médicas
INSERT INTO NotasMedicas (expediente_id, nombre_autor, contenido, firma)
VALUES
(1, 'Dr. Juan Pérez', 'Control de presión arterial estable', 'firma'),
(2, 'Dra. Ana Gómez', 'Ajuste de dosis de insulina', 'firma');
GO

-- Historia Clínica
INSERT INTO HistoriaClinica (expediente_id, ficha_identificacion, grupo_etnico, antecedentes_heredo_familiares, antecedentes_personales_patologicos, uso_sustancias, antecedentes_no_patologicos, padecimiento_actual, interrogatorio_sistemas)
VALUES
(1, 'Identificación completa del paciente Luis Martínez', 'Mestizo', 'Padre con hipertensión', 'Hipertensión desde 2015', 'No', 'No fuma ni bebe', 'Presión alta controlada', 'Sin síntomas neurológicos'),
(2, 'Identificación completa de María Sánchez', 'Mestizo', 'Madre con diabetes', 'Diagnóstico reciente de diabetes', 'No', 'No fuma', 'Control glucémico', 'Fatiga frecuente');
GO

-- Exploración Física
INSERT INTO ExploracionFisica (historia_id, habitus_exterior, temperatura, tension_arterial, frecuencia_cardiaca, frecuencia_respiratoria, peso, talla, observaciones)
VALUES
(1, 'Buen estado general', 36.8, '120/80', 75, 16, 70.5, 1.75, 'Sin anomalías visibles'),
(2, 'Estado general aceptable', 37.0, '130/85', 80, 18, 65.0, 1.65, 'Observaciones normales');
GO

-- Estudios Diagnósticos
INSERT INTO EstudioDiagnostico (expediente_id, tipo_estudio, resultados, fecha_estudio)
VALUES
(1, 'Electrocardiograma', 'Ritmo sinusal normal', GETDATE()),
(2, 'Perfil glucémico', 'Glucosa en ayunas elevada', GETDATE());
GO

-- Notas Evolución
INSERT INTO NotasEvolucion (expediente_id, evolucion_clinica, signos_vitales, resultados_estudios, diagnostico, pronostico, tratamiento)
VALUES
(1, 'Mejora progresiva de presión arterial', 'TA 120/80, FC 75', 'Electrocardiograma normal', 'Hipertensión controlada', 'Buen pronóstico', 'Medicamentos continuados'),
(2, 'Glucosa estable con tratamiento', 'TA 130/85, FC 80', 'Perfil glucémico en rango', 'Diabetes tipo 2 estable', 'Pronóstico reservado', 'Insulina y dieta');
GO

-- Notas Interconsulta
INSERT INTO NotasInterconsulta (expediente_id, criterios_diagnosticos, plan_estudios, sugerencias, observaciones)
VALUES
(1, 'Hipertensión arterial', 'Monitoreo ambulatorio de presión', 'Continuar tratamiento', 'Paciente coopera bien'),
(2, 'Diabetes tipo 2', 'Controles mensuales', 'Evaluar función renal', NULL);
GO

-- Notas Traslado
INSERT INTO NotasTraslado (expediente_id, establecimiento_envia, establecimiento_receptor, motivo_envio, impresion_diagnostica, terapeutica_empleada)
VALUES
(1, 'Hospital Central', 'Hospital Regional', 'Control especializado', 'Hipertensión bien controlada', 'Medicamentos y dieta'),
(2, 'Clínica del Norte', 'Hospital General', 'Complicaciones metabólicas', 'Diabetes tipo 2 con buen manejo', 'Insulina ajustada');
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
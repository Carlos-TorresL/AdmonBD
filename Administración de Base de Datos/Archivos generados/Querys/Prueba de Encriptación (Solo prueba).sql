-- Decimos que vamos a usar la base de datos "ExpedientesClinicos"
USE ExpedientesClinicos;
GO

-- Creaci�n de clave maestra
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '1234';
GO

--Pruebas de Encriptaci�n

-- Crear un certificado
CREATE CERTIFICATE CertificadoPaciente
WITH SUBJECT = 'Protecci�n de datos sensibles de pacientes';
GO

-- Crear clave sim�trica
CREATE SYMMETRIC KEY ClavePaciente
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificadoPaciente;
GO

ALTER TABLE Paciente
ADD nombre_paciente_encriptado VARBINARY(MAX);
GO

-- Abrir la clave sim�trica
OPEN SYMMETRIC KEY ClavePaciente
DECRYPTION BY CERTIFICATE CertificadoPaciente;

-- Actualizar valores encriptados
UPDATE Paciente
SET nombre_paciente_encriptado = EncryptByKey(Key_GUID('ClavePaciente'), nombre_paciente);
GO

-- Cerrar la clave
CLOSE SYMMETRIC KEY ClavePaciente;
GO

-- Abrir clave
OPEN SYMMETRIC KEY ClavePaciente
DECRYPTION BY CERTIFICATE CertificadoPaciente;

-- Consultar y desencriptar
SELECT 
    paciente_id,
    nombre_paciente,
    CONVERT(VARCHAR, DecryptByKey(nombre_paciente_encriptado)) AS nombre_desencriptado
FROM Paciente;

-- Cerrar clave
CLOSE SYMMETRIC KEY ClavePaciente;
GO

DENY VIEW DEFINITION ON CERTIFICATE::CertificadoPaciente TO UsuarioLector;

SELECT * FROM Paciente;
SELECT nombre_paciente_encriptado FROM Paciente;
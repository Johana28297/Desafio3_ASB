-- ******************************************************
-- PROYECTO: SISTEMA DE GESTIÓN DE ADOPCIONES DE MASCOTAS
-- AUTOR: Yeymi Johana De Paz Fernandez
-- FECHA: 30 de Mayo de 2025
-- ******************************************************

-- 1. Crear la base de datos para el sistema de adopción
CREATE DATABASE IF NOT EXISTS AdopcionMascotas;
USE AdopcionMascotas;

-- Tabla Mascotas
CREATE TABLE Mascotas (
    IdMascota INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Especie VARCHAR(50) NOT NULL, -- Perro, Gato, etc.
    Raza VARCHAR(50),
    Edad INT, -- en años o meses, especifica en los comentarios
    EstadoSalud VARCHAR(100), -- Bueno, Requiere tratamiento, Vacunas al día, etc.
    EstadoAdopcion ENUM('Disponible', 'Adoptada', 'En Proceso', 'No Adoptable') NOT NULL DEFAULT 'Disponible',
    Descripcion TEXT, -- Comportamiento, necesidades especiales
    FechaIngreso DATE NOT NULL
);

-- Tabla Adoptantes
CREATE TABLE Adoptantes (
    IdAdoptante INT AUTO_INCREMENT PRIMARY KEY,
    NombreCompleto VARCHAR(100) NOT NULL,
    DocumentoIdentidad VARCHAR(20) UNIQUE NOT NULL, -- DNI, DUI, etc.
    FechaNacimiento DATE,
    Direccion VARCHAR(200),
    Telefono VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Tabla Empleados
CREATE TABLE Empleados (
    IdEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    NombreCompleto VARCHAR(100) NOT NULL,
    DocumentoIdentidad VARCHAR(20) UNIQUE NOT NULL,
    Puesto VARCHAR(50), -- Veterinario, Cuidador, Administrador, etc.
    FechaContratacion DATE NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Tabla Adopciones
CREATE TABLE Adopciones (
    IdAdopcion INT AUTO_INCREMENT PRIMARY KEY,
    IdMascota INT NOT NULL,
    IdAdoptante INT NOT NULL,
    IdEmpleado INT NOT NULL, -- Empleado que gestionó la adopción
    FechaAdopcion DATE NOT NULL,
    EstadoContrato VARCHAR(50), -- Firmado, Pendiente, etc.
    FOREIGN KEY (IdMascota) REFERENCES Mascotas(IdMascota),
    FOREIGN KEY (IdAdoptante) REFERENCES Adoptantes(IdAdoptante),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleados(IdEmpleado)
);

-- Tabla Controles_PostAdopcion
CREATE TABLE Controles_PostAdopcion (
    IdControl INT AUTO_INCREMENT PRIMARY KEY,
    IdAdopcion INT NOT NULL,
    FechaControl DATE NOT NULL,
    RealizadoPor_IdEmpleado INT NOT NULL, -- Empleado que realizó el control
    Observaciones TEXT,
    EstadoSeguimiento ENUM('Exitoso', 'Necesita Visita Adicional', 'Preocupante', 'Finalizado') NOT NULL,
    FOREIGN KEY (IdAdopcion) REFERENCES Adopciones(IdAdopcion),
    FOREIGN KEY (RealizadoPor_IdEmpleado) REFERENCES Empleados(IdEmpleado)
);

-- ******************************************************
-- 2. Carga de Datos
-- ******************************************************
USE AdopcionMascotas;

-- Insertar datos en Mascotas (al menos 20)
INSERT INTO Mascotas (Nombre, Especie, Raza, Edad, EstadoSalud, EstadoAdopcion, Descripcion, FechaIngreso) VALUES
('Max', 'Perro', 'Labrador', 3, 'Excelente', 'Disponible', 'Muy juguetón y amigable.', '2024-01-15'),
('Luna', 'Gato', 'Siamés', 2, 'Bueno', 'Adoptada', 'Tranquila y cariñosa.', '2024-02-01'),
('Rocky', 'Perro', 'Pastor Alemán', 5, 'Excelente', 'Disponible', 'Necesita espacio y ejercicio.', '2024-03-10'),
('Mona', 'Gato', 'Común Europeo', 1, 'Bueno', 'Disponible', 'Le gusta jugar con pelotas.', '2024-04-05'),
('Buddy', 'Perro', 'Golden Retriever', 4, 'Excelente', 'En Proceso', 'Ideal para familias con niños.', '2024-05-20'),
('Bella', 'Gato', 'Persa', 6, 'Requiere tratamiento', 'Disponible', 'Necesita cepillado diario.', '2024-06-01'),
('Duke', 'Perro', 'Bulldog', 7, 'Excelente', 'Adoptada', 'Un poco perezoso, pero leal.', '2024-07-11'),
('Daisy', 'Gato', 'Maine Coon', 2, 'Bueno', 'Disponible', 'Muy grande y curiosa.', '2024-08-03'),
('Charlie', 'Perro', 'Beagle', 1, 'Excelente', 'Disponible', 'Activo y le gusta explorar.', '2024-09-19'),
('Coco', 'Gato', 'Ragdoll', 3, 'Bueno', 'En Proceso', 'Muy dócil y se lleva bien con otros gatos.', '2024-10-25'),
('Simba', 'Perro', 'Pug', 8, 'Requiere tratamiento', 'Disponible', 'Problemas respiratorios leves.', '2024-11-01'),
('Nala', 'Gato', 'Esfinge', 4, 'Bueno', 'Adoptada', 'Necesita ropa en invierno.', '2024-12-07'),
('Zeus', 'Perro', 'Doberman', 2, 'Excelente', 'Disponible', 'Requiere entrenamiento firme.', '2025-01-05'),
('Mia', 'Gato', 'Bengala', 1, 'Excelente', 'Disponible', 'Muy enérgica y ruidosa.', '2025-02-14'),
('Thor', 'Perro', 'Husky', 3, 'Bueno', 'En Proceso', 'Le gusta el frío y correr.', '2025-03-20'),
('Chloe', 'Gato', 'Birmano', 5, 'Excelente', 'Disponible', 'Tranquila y observadora.', '2025-04-01'),
('Lucky', 'Perro', 'Mestizo', 6, 'Excelente', 'Adoptada', 'Muy agradecido y amigable.', '2024-01-20'),
('Tiger', 'Gato', 'Mestizo', 2, 'Bueno', 'Disponible', 'Le gusta cazar ratones.', '2024-02-28'),
('Polo', 'Perro', 'Chihuahua', 10, 'Bueno', 'Adoptada', 'Necesita un hogar tranquilo.', '2024-03-05'),
('Snowball', 'Gato', 'Angora', 4, 'Excelente', 'Disponible', 'Pelaje blanco y suave.', '2024-04-10');

-- Insertar datos en Adoptantes (al menos 10)
INSERT INTO Adoptantes (NombreCompleto, DocumentoIdentidad, FechaNacimiento, Direccion, Telefono, Email) VALUES
('Juan Pérez', '01234567-8', '1980-01-20', 'Calle Principal #1, San Salvador', '7890-1234', 'juan.perez@example.com'),
('María González', '09876543-2', '1992-05-15', 'Av. Central #2, Santa Ana', '6789-0123', 'maria.g@example.com'),
('Carlos Ramírez', '12345678-9', '1975-11-30', 'Urb. Las Flores #3, La Libertad', '7123-4567', 'carlos.r@example.com'),
('Ana Torres', '23456789-0', '1988-03-10', 'Res. Los Pinos #4, San Miguel', '6012-3456', 'ana.t@example.com'),
('Luis Herrera', '34567890-1', '1995-07-22', 'Pasaje La Paz #5, Sonsonate', '7234-5678', 'luis.h@example.com'),
('Sofía Castro', '45678901-2', '1983-09-01', 'Calle El Sol #6, Usulután', '6345-6789', 'sofia.c@example.com'),
('Pedro Martínez', '56789012-3', '1970-04-05', 'Blvd. Constitución #7, San Salvador', '7456-7890', 'pedro.m@example.com'),
('Laura Gómez', '67890123-4', '1990-12-12', 'Col. Escalón #8, San Salvador', '6567-8901', 'laura.g@example.com'),
('Roberto Ruiz', '78901234-5', '1981-06-25', 'Carr. al Puerto #9, La Libertad', '7678-9012', 'roberto.r@example.com'),
('Elena Díaz', '89012345-6', '1978-02-28', 'Av. Bernal #10, San Salvador', '6890-1234', 'elena.d@example.com');

-- Insertar datos en Empleados (al menos 5)
INSERT INTO Empleados (NombreCompleto, DocumentoIdentidad, Puesto, FechaContratacion, Telefono, Email) VALUES
('Marta López', '11223344-5', 'Administrador', '2020-01-01', '7000-1111', 'marta.l@example.com'),
('José García', '22334455-6', 'Veterinario', '2019-03-15', '7000-2222', 'jose.g@example.com'),
('Laura Flores', '33445566-7', 'Cuidador', '2021-06-20', '7000-3333', 'laura.f@example.com'),
('David Mena', '44556677-8', 'Gestor de Adopciones', '2022-09-10', '7000-4444', 'david.m@example.com'),
('Sofía Rivas', '55667788-9', 'Voluntario', '2023-01-05', '7000-5555', 'sofia.r@example.com');

-- Insertar datos en Adopciones (varias)
INSERT INTO Adopciones (IdMascota, IdAdoptante, IdEmpleado, FechaAdopcion, EstadoContrato) VALUES
(2, 1, 4, '2024-03-01', 'Firmado'), -- Luna por Juan Pérez, gestionado por David Mena
(6, 2, 4, '2024-07-15', 'Firmado'), -- Bella por María González, gestionado por David Mena
(7, 3, 4, '2024-08-01', 'Firmado'), -- Duke por Carlos Ramírez, gestionado por David Mena
(12, 4, 4, '2025-01-10', 'Firmado'), -- Nala por Ana Torres, gestionado por David Mena
(17, 5, 4, '2024-02-05', 'Firmado'), -- Lucky por Luis Herrera, gestionado por David Mena
(20, 6, 4, '2024-05-20', 'Firmado'), -- Polo por Sofía Castro, gestionado por David Mena
(5, 7, 4, '2025-05-10', 'Pendiente'); -- Buddy por Pedro Martínez, gestionado por David Mena (Estado "En Proceso")

-- Insertar datos en Controles_PostAdopcion (varios)
INSERT INTO Controles_PostAdopcion (IdAdopcion, FechaControl, RealizadoPor_IdEmpleado, Observaciones, EstadoSeguimiento) VALUES
(1, '2024-04-01', 3, 'Mascota adaptándose bien al nuevo hogar. Adoptante feliz.', 'Exitoso'),
(1, '2024-06-01', 3, 'Visita de seguimiento. Todo en orden, mascota integrada.', 'Finalizado'),
(2, '2024-08-01', 3, 'Mascota un poco tímida al principio, pero mejorando.', 'Exitoso'),
(3, '2024-09-01', 3, 'Adoptante reporta buen comportamiento. No hay problemas.', 'Exitoso'),
(4, '2025-02-01', 3, 'Mascota se adaptó rápidamente, casa limpia y ordenada.', 'Exitoso'),
(5, '2024-03-05', 3, 'Mascota juguetona, adoptante cumple con todas las indicaciones.', 'Exitoso'),
(6, '2024-06-20', 3, 'Todo bien, mascota sana y feliz en su nuevo hogar.', 'Exitoso');

-- ******************************************************
-- 3. Consultas SQL (para ver los resultados, ejecuta estas sentencias)
-- ******************************************************
USE AdopcionMascotas;

-- a. Listar mascotas disponibles filtradas por especie, edad o estado de salud.

-- Ejemplo 1: Mascotas disponibles que son perros y tienen menos de 5 años.
SELECT
    IdMascota,
    Nombre,
    Especie,
    Raza,
    Edad,
    EstadoSalud,
    EstadoAdopcion
FROM
    Mascotas
WHERE
    EstadoAdopcion = 'Disponible'
    AND Especie = 'Perro'
    AND Edad < 5;

-- Ejemplo 2: Mascotas disponibles con estado de salud "Bueno"
SELECT
    IdMascota,
    Nombre,
    Especie,
    Raza,
    Edad,
    EstadoSalud,
    EstadoAdopcion
FROM
    Mascotas
WHERE
    EstadoAdopcion = 'Disponible'
    AND EstadoSalud = 'Bueno';

-- b. Mostrar historial de adopciones por adoptante.

-- Ejemplo: Historial de adopciones para 'Juan Pérez'
SELECT
    A.NombreCompleto AS Adoptante,
    M.Nombre AS NombreMascota,
    M.Especie,
    M.Raza,
    AD.FechaAdopcion,
    E.NombreCompleto AS EmpleadoGestor
FROM
    Adopciones AS AD
JOIN
    Adoptantes AS A ON AD.IdAdoptante = A.IdAdoptante
JOIN
    Mascotas AS M ON AD.IdMascota = M.IdMascota
JOIN
    Empleados AS E ON AD.IdEmpleado = E.IdEmpleado
WHERE
    A.NombreCompleto = 'Juan Pérez';

-- c. Consultar seguimientos post-adopción realizados por empleado o por mascota.

-- Ejemplo 1: Seguimientos realizados por el empleado 'Laura Flores'
SELECT
    C.IdControl,
    M.Nombre AS NombreMascota,
    A.NombreCompleto AS Adoptante,
    C.FechaControl,
    E.NombreCompleto AS EmpleadoQueRealizoControl,
    C.Observaciones,
    C.EstadoSeguimiento
FROM
    Controles_PostAdopcion AS C
JOIN
    Adopciones AS AD ON C.IdAdopcion = AD.IdAdopcion
JOIN
    Mascotas AS M ON AD.IdMascota = M.IdMascota
JOIN
    Adoptantes AS A ON AD.IdAdoptante = A.IdAdoptante
JOIN
    Empleados AS E ON C.RealizadoPor_IdEmpleado = E.IdEmpleado
WHERE
    E.NombreCompleto = 'Laura Flores';

-- Ejemplo 2: Seguimientos para la mascota 'Luna'

SELECT
    C.IdControl,
    M.Nombre AS NombreMascota,
    A.NombreCompleto AS Adoptante,
    C.FechaControl,
    E.NombreCompleto AS EmpleadoQueRealizoControl,
    C.Observaciones,
    C.EstadoSeguimiento
FROM
    Controles_PostAdopcion AS C
JOIN
    Adopciones AS AD ON C.IdAdopcion = AD.IdAdopcion
JOIN
    Mascotas AS M ON AD.IdMascota = M.IdMascota
JOIN
    Adoptantes AS A ON AD.IdAdoptante = A.IdAdoptante
JOIN
    Empleados AS E ON C.RealizadoPor_IdEmpleado = E.IdEmpleado
WHERE
    M.Nombre = 'Luna';

-- ******************************************************
-- 4. Vistas (para ver los resultados
-- ******************************************************
USE AdopcionMascotas;

CREATE VIEW Vista_AdopcionesDetalle AS
SELECT
    AD.IdAdopcion,
    Adopt.NombreCompleto AS NombreAdoptante,
    Masc.Nombre AS NombreMascota,
    Masc.Especie AS EspecieMascota,
    Masc.Raza AS RazaMascota,
    Masc.Edad AS EdadMascota,
    Masc.EstadoSalud AS SaludMascota,
    AD.FechaAdopcion,
    Emp.NombreCompleto AS EmpleadoGestorAdopcion
FROM
    Adopciones AS AD
JOIN
    Adoptantes AS Adopt ON AD.IdAdoptante = Adopt.IdAdoptante
JOIN
    Mascotas AS Masc ON AD.IdMascota = Masc.IdMascota
JOIN
    Empleados AS Emp ON AD.IdEmpleado = Emp.IdEmpleado;

-- Para probar la vista:
SELECT * FROM Vista_AdopcionesDetalle;

-- ******************************************************
-- 5. Procedimiento Almacenado 
-- ******************************************************
USE AdopcionMascotas;

DELIMITER $$
CREATE PROCEDURE RegistrarNuevaAdopcion(
    IN p_IdMascota INT,
    IN p_IdAdoptante INT,
    IN p_IdEmpleado INT,
    IN p_FechaAdopcion DATE,
    IN p_EstadoContrato VARCHAR(50)
)
BEGIN
    -- Insertar la nueva adopción en la tabla Adopciones
    INSERT INTO Adopciones (IdMascota, IdAdoptante, IdEmpleado, FechaAdopcion, EstadoContrato)
    VALUES (p_IdMascota, p_IdAdoptante, p_IdEmpleado, p_FechaAdopcion, p_EstadoContrato);

    -- Actualizar el estado de la mascota a 'Adoptada'
    UPDATE Mascotas
    SET EstadoAdopcion = 'Adoptada'
    WHERE IdMascota = p_IdMascota;
END$$
DELIMITER ;

-- Para probar el procedimiento almacenado (Ejemplo):
-- Primero, puede encontrar una mascota disponible y un adoptante y empleado válidos para la prueba:
-- SELECT IdMascota, Nombre FROM Mascotas WHERE EstadoAdopcion = 'Disponible' LIMIT 1;
-- SELECT IdAdoptante, NombreCompleto FROM Adoptantes LIMIT 1;
-- SELECT IdEmpleado, NombreCompleto FROM Empleados LIMIT 1;

-- Luego, ejecute el procedimiento:
-- CALL RegistrarNuevaAdopcion(1, 1, 4, '2025-05-27', 'Firmado'); -- Asegúrate de que IdMascota 1 esté 'Disponible' antes de ejecutar

-- Después de ejecutar, verificar si la adopción se registró y la mascota se actualizó:
-- SELECT * FROM Adopciones ORDER BY IdAdopcion DESC LIMIT 1;
-- SELECT IdMascota, Nombre, EstadoAdopcion FROM Mascotas WHERE IdMascota = 1;

-- ******************************************************
-- 6. Reporte en Power BI (Este código es solo para referencia en el script SQL.
-- ******************************************************
-- Esta sección es una guía sobre cómo cree los gráficos en Power BI.
-- Los resultados visuales de estos gráficos se presentan en el archivo PDF del reporte.

-- a. Número de adopciones por mes:
-- SELECT
--     DATE_FORMAT(FechaAdopcion, '%Y-%m') AS AñoMes,
--     COUNT(IdAdopcion) AS NumeroAdopciones
-- FROM
--     Adopciones
-- GROUP BY
--     AñoMes
-- ORDER BY
--     AñoMes;

-- b. Tipos de mascotas más adoptadas:
-- SELECT
--     EspecieMascota,
--     COUNT(IdAdopcion) AS TotalAdopciones
-- FROM
--     Vista_AdopcionesDetalle
-- GROUP BY
--     EspecieMascota
-- ORDER BY
--     TotalAdopciones DESC;

-- c. Estado actual de las mascotas (adoptadas vs disponibles):
-- SELECT
--     EstadoAdopcion,
--     COUNT(IdMascota) AS CantidadMascotas
-- FROM
--     Mascotas
-- GROUP BY
--     EstadoAdopcion;

-- d. Porcentaje de adopciones con seguimiento post-adopción exitoso:
-- SELECT
--     (SUM(CASE WHEN EstadoSeguimiento = 'Exitoso' THEN 1 ELSE 0 END) / COUNT(IdControl)) * 100 AS PorcentajeExitoso
-- FROM
--     Controles_PostAdopcion;
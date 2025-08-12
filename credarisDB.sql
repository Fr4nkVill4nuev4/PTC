CREATE DATABASE CREDARIS;
GO
USE CREDARIS;
GO

-- 2. TABLA: USUARIOS (Administrador y Empleado)
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY IDENTITY(1,1),
    nombreCompleto VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('Administrador', 'Empleado')),
    activo BIT DEFAULT 1
);

-- 3. TABLA: PRÉSTAMOS
CREATE TABLE Prestamos (
    idPrestamo INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    numeroCuotas INT NOT NULL,
    tasaInteres DECIMAL(5,2) NOT NULL,
    fechaInicio DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Activo', 'Finalizado')),
    CONSTRAINT FK_Prestamos_Usuarios FOREIGN KEY (id_usuario)
        REFERENCES Usuarios(idUsuario)
);

-- 4. TABLA: CUOTAS
CREATE TABLE Cuotas (
    idCuota INT PRIMARY KEY IDENTITY(1,1),
    id_prestamo INT NOT NULL,
    numeroCuota INT NOT NULL,
    fechaPago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Pendiente', 'Pagada', 'Vencida')),
    fechaPagoReal DATE NULL,
    comentario VARCHAR(255),
    CONSTRAINT FK_Cuotas_Prestamos FOREIGN KEY (id_prestamo)
        REFERENCES Prestamos(idPrestamo)
);

-- 5. TABLA: ALERTAS
CREATE TABLE Alertas (
    idAlerta INT PRIMARY KEY IDENTITY(1,1),
    id_cuota INT NOT NULL,
    tipoAlerta VARCHAR(100) NOT NULL,
    fechaGenerada DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Activa', 'Revisada')),
    CONSTRAINT FK_Alertas_Cuotas FOREIGN KEY (id_cuota)
        REFERENCES Cuotas(idCuota)
);

-- 6. TABLA OPCIONAL: BITÁCORA DE CAMBIOS (esto es para mas adelante)
-- CREATE TABLE BitacoraCambios (
--     idCambio INT PRIMARY KEY IDENTITY(1,1),
--     idPrestamo INT NOT NULL,
--     fechaCambio DATETIME DEFAULT GETDATE(),
--     descripcionCambio VARCHAR(255) NOT NULL,
--     realizadoPor VARCHAR(50) NOT NULL,
--     CONSTRAINT FK_Bitacora_Prestamos FOREIGN KEY (idPrestamo)
--         REFERENCES Prestamos(idPrestamo)
-- );

-- 7. INSERTAR USUARIOS (15 REGISTROS REALES)
INSERT INTO Usuarios (nombreCompleto, usuario, contrasena, rol) VALUES
('Juan Pérez', 'juan.perez', 'clave123', 'Empleado'),
('Ana Ramírez', 'ana.ramirez', 'clave456', 'Empleado'),
('Carlos Torres', 'carlos.torres', 'clave789', 'Empleado'),
('Luis Rivas', 'luis.rivas', 'clave321', 'Empleado'),
('Mario Gómez', 'mario.gomez', 'clave000', 'Empleado'),
('Sandra López', 'sandra.lopez', 'clave147', 'Empleado'),
('Esteban Mejía', 'esteban.mejia', 'clave258', 'Empleado'),
('Sara Núñez', 'sara.nunez', 'clave369', 'Empleado'),
('Beatriz Morales', 'beatriz.morales', 'clave741', 'Empleado'),
('Fernando Castillo', 'fernando.castillo', 'clave852', 'Empleado'),
('Marcela Díaz', 'marcela.diaz', 'clave963', 'Empleado'),
('Jorge Mendoza', 'jorge.mendoza', 'clave159', 'Empleado'),
('Gabriela Herrera', 'gabriela.herrera', 'clave357', 'Empleado'),
('Admin1', 'admin1', 'admin123', 'Administrador'),
('Admin2', 'admin2', 'admin456', 'Administrador');

-- 8. INSERTAR PRÉSTAMOS
INSERT INTO Prestamos (id_usuario, monto, numeroCuotas, tasaInteres, fechaInicio, estado)
VALUES
(1, 2000, 10, 0.00, '2025-08-01', 'Activo'),
(2, 1500, 5, 0.00, '2025-07-01', 'Activo'),
(3, 1000, 4, 0.00, '2025-06-01', 'Finalizado'),
(4, 1800, 6, 0.00, '2025-05-01', 'Activo'),
(5, 2500, 10, 2.5, '2025-04-01', 'Activo'),
(6, 1200, 6, 0.00, '2025-03-01', 'Finalizado'),
(7, 900, 3, 0.00, '2025-02-01', 'Finalizado'),
(8, 3000, 12, 0.00, '2025-01-01', 'Activo'),
(1, 1500, 5, 0.00, '2025-07-01', 'Finalizado'),
(2, 1700, 8, 1.5, '2025-06-01', 'Activo'),
(3, 1100, 4, 0.00, '2025-05-01', 'Finalizado'),
(4, 1300, 6, 0.00, '2025-04-01', 'Activo'),
(5, 2100, 7, 0.00, '2025-03-01', 'Activo'),
(6, 950, 3, 0.00, '2025-02-01', 'Finalizado'),
(7, 1000, 4, 0.00, '2025-01-01', 'Finalizado');

-- 9. INSERTAR CUOTAS
INSERT INTO		 (id_prestamo, numeroCuota, fechaPago, monto, estado, fechaPagoReal, comentario)
VALUES
(1, 1, '2025-08-01', 200.00, 'Pagada', '2025-08-01', 'Pagó a tiempo'),
(1, 2, '2025-09-01', 200.00, 'Pendiente', NULL, NULL),
(1, 3, '2025-10-01', 200.00, 'Vencida', NULL, 'No ha pagado'),
(2, 1, '2025-07-01', 300.00, 'Pagada', '2025-07-01', NULL);

-- 10. INSERTAR ALERTAS
INSERT INTO Alertas (id_cuota, tipoAlerta, fechaGenerada, estado)
VALUES
(3, 'Cuota vencida', '2025-10-02', 'Activa'),
(2, 'Próxima cuota', '2025-08-28', 'Revisada');

-- 11. CONSULTAS BÁSICAS PARA USO Y DEFENSA

-- a) Mostrar todos los usuarios
SELECT * FROM Usuarios;

-- b) Mostrar préstamos por usuario
SELECT * FROM Prestamos WHERE id_usuario = 1;

-- c) Ver cuotas de un préstamo
SELECT * FROM Cuotas WHERE id_prestamo = 1;

-- d) Marcar cuota como pagada
UPDATE Cuotas 
SET estado = 'Pagada', 
    fechaPagoReal = GETDATE(), 
    comentario = 'Pagado en ventanilla' 
WHERE idCuota = 2;

-- e) Eliminar una alerta (mantenimiento)
DELETE FROM Alertas WHERE idAlerta = 2;

-- f) Préstamos con nombre del empleado
SELECT 
    P.idPrestamo,
    U.nombreCompleto,
    P.monto,
    P.numeroCuotas,
    P.tasaInteres,
    P.fechaInicio,
    P.estado
FROM Prestamos P
INNER JOIN Usuarios U ON P.id_usuario = U.idUsuario;

-- g) Cuotas detalladas con usuario y préstamo
SELECT 
    C.idCuota,
    C.numeroCuota,
    C.fechaPago,
    C.estado,
    P.idPrestamo,
    U.nombreCompleto
FROM Cuotas C
INNER JOIN Prestamos P ON C.id_prestamo = P.idPrestamo
INNER JOIN Usuarios U ON P.id_usuario = U.idUsuario;

-- h) Alertas con datos del empleado y cuota
SELECT 
    A.idAlerta,
    A.tipoAlerta,
    A.fechaGenerada,
    A.estado,
    C.numeroCuota,
    U.nombreCompleto
FROM Alertas A
INNER JOIN Cuotas C ON A.id_cuota = C.idCuota
INNER JOIN Prestamos P ON C.id_prestamo = P.idPrestamo
INNER JOIN Usuarios U ON P.id_usuario = U.idUsuario;
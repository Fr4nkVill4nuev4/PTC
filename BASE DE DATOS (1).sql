DROP DATABASE IF EXISTS CREDARIS; -- Para borrar si hay otra base igual 
CREATE DATABASE CREDARIS;  --creando la base de datos
GO
USE CREDARIS;
GO

--CREADO LAS TABLAS

--TABLA USUARIO 
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY IDENTITY(1,1),  -- ID único de cada usuario, autoincremental
    usuario NVARCHAR(50) UNIQUE NOT NULL,      -- Nombre de usuario único y obligatorio
    contrasena NVARCHAR(100) NOT NULL,            -- Contraseña obligatoria
    rol NVARCHAR(20) CHECK (rol IN ('Administrador', 'Empleado')) NOT NULL   -- Rol que define permisos
);


--TABLA EMPLEADOS
CREATE TABLE Empleados (
    idEmpleado INT PRIMARY KEY IDENTITY(1,1),  -- ID único del empleado
    id_usuario INT NOT NULL,                   -- Relación con la tabla Usuarios
    nombreCompleto NVARCHAR(100) NOT NULL,     -- Nombre completo del empleado
    fechaIngreso DATE NOT NULL,                 -- Fecha de ingreso
    estado BIT NOT NULL,                        -- 1 = activo, 0 = inactivo
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(idUsuario) ON DELETE CASCADE  -- Si se borra usuario, se borra empleado
);



--TABLA PRESTAMOS
CREATE TABLE Prestamos (
    idPrestamo INT PRIMARY KEY IDENTITY(1,1), -- ID único del préstamo
    id_empleado INT NOT NULL,                 -- Relación con el empleado
    monto DECIMAL(10,2) NOT NULL,               -- Cantidad prestada
    tasaInteres DECIMAL(5,2) NOT NULL,          -- Interés del préstamo
    plazoMeses INT NOT NULL,                       -- Duración en meses
    cuotaMensual DECIMAL(10,2) NOT NULL,          -- Cuota mensual
    fechaInicio DATE NOT NULL,                    -- Fecha de inicio del préstamo
    fechaFin DATE NOT NULL,                       -- Fecha de finalización
    estado NVARCHAR(20) CHECK (estado IN ('Activo', 'Finalizado')) NOT NULL,   -- Estado
    FOREIGN KEY (id_empleado) REFERENCES Empleados(idEmpleado) ON DELETE CASCADE -- Si se borra empleado, se borran sus préstamos
);


-- TABLA PAGOS
CREATE TABLE Pagos (
    idPago INT PRIMARY KEY IDENTITY(1,1),  -- ID único del pago
    id_prestamo INT NOT NULL,                -- Relación con el préstamo
    fechaPago DATE NOT NULL,                 -- Fecha del pago
    monto DECIMAL(10,2) NOT NULL,             -- Monto del pago
    estado NVARCHAR(20) CHECK (estado IN ('Pendiente', 'Pagado')) NOT NULL, -- Estado del pago
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(idPrestamo) ON DELETE CASCADE  -- Si se borra préstamo, se borran pagos
); 

---------------------------------
--TABLAS PARA MAS ADELANTE DEL PTC 

--------------------------------------

-- TABLA DE HISTORIAL DE PRESTAMOS
CREATE TABLE HistorialPrestamos (
    idHistorial INT PRIMARY KEY IDENTITY(1,1), -- ID único del historial
    id_empleado INT NOT NULL,                  -- Relación con el empleado
    montoAnterior DECIMAL(10,2),               -- Monto anterior del préstamo
    fechaRegistro DATE,                         -- Fecha del registro
    FOREIGN KEY (id_empleado) REFERENCES Empleados(idEmpleado)  -- FK al empleado
);


--TABLA NOTIFICACIONES 
CREATE TABLE Notificaciones (
    idNotificacion INT PRIMARY KEY IDENTITY(1,1), -- ID único de notificación
    id_empleado INT NOT NULL,                         -- Relación con el empleado
    mensaje NVARCHAR(255),                         -- Mensaje de notificación
    fechaEnvio DATETIME,                             -- Fecha de envío
    leido BIT DEFAULT 0,                                -- 0 = no leído, 1 = leído
    FOREIGN KEY (id_empleado) REFERENCES Empleados(idEmpleado) ON DELETE CASCADE -- Si se borra empleado, se borran sus notificaciones
);

--TABLA CALENDARIO 
CREATE TABLE Calendario (
    idCalendario INT PRIMARY KEY IDENTITY(1,1), -- ID único del evento
    id_pago INT NOT NULL,                        -- Relación con un pago
    fechaEvento DATE,                            -- Fecha del evento
    descripcion NVARCHAR(255),                   -- Descripción del evento
    FOREIGN KEY (id_pago) REFERENCES Pagos(idPago) ON DELETE CASCADE -- Si se borra el pago, se borra el evento
);


----------------------------
-- INDICES PARA MEJORAR RENDIMIENTO
/*Para qué sirven:
Mejoran la velocidad de las búsquedas y filtrados en una tabla, evitando que SQL revise fila por fila.
Son como el índice de un libro que te permite ir directo a la página que buscas.

Ejemplo en CREDARIS:
idxEmpleadoEstado → ayuda a encontrar rápido todos los empleados activos (estado = 1).
idxPrestamoEstado → acelera la búsqueda de préstamos activos o finalizados.
idxPagoEstado → permite listar rápido los pagos pendientes o ya pagados.*/

CREATE INDEX idxEmpleadoEstado ON Empleados(estado);
CREATE INDEX idxPrestamoEstado ON Prestamos(estado);
CREATE INDEX idxPagoEstado ON Pagos(estado);

-- Insertar Usuarios
INSERT INTO Usuarios (usuario, contrasena, rol) VALUES
('JNRL17', '20250764', 'Administrador'),
('JSRR01', '20250236', 'Empleado'),
('jlopez', 'pass123', 'Empleado'),
('mgarcia', 'secure456', 'Empleado'),
('admin01', 'adminpass', 'Administrador'),
('rmenendez', 'clave789', 'Empleado'),
('cortega', 'pass321', 'Empleado'),
('admin02', 'adminsecure', 'Administrador'),
('lrojas', 'rojaspass', 'Empleado'),
('nfuentes', 'fuentes456', 'Empleado'),
('admin03', 'adminclave', 'Administrador'),
('dcastro', 'castro123', 'Empleado'),
('vhernandez', 'vhpass', 'Empleado'),
('admin04', 'rootadmin', 'Administrador'),
('sramirez', 'ramirezpass', 'Empleado'),
('jtorres', 'torresclave', 'Empleado'),
('admin05', 'adminfinal', 'Administrador');

-- Insertar Empleados
INSERT INTO Empleados (id_usuario, nombreCompleto, fechaIngreso, estado) VALUES
(1, 'Josue Nahum Rodriguez Lopez', '2025-08-01', 1),
(2, 'Jhonathan Samuel Rivera Rojas', '2025-07-15', 1),
(3, 'José López', '2023-02-15', 1),
(4, 'María García', '2022-11-10', 1),
(5, 'Carlos Méndez', '2021-07-01', 1),
(6, 'Rosa Menéndez', '2024-01-20', 1),
(7, 'Cristina Ortega', '2023-05-05', 1),
(8, 'Luis Rojas', '2022-03-18', 1),
(9, 'Natalia Fuentes', '2023-09-12', 1),
(10, 'Daniel Castro', '2021-12-01', 1),
(11, 'Valeria Hernández', '2024-04-25', 1),
(12, 'Sofía Ramírez', '2022-08-30', 1),
(13, 'Jorge Torres', '2023-06-14', 1),
(14, 'Ana Morales', '2022-01-01', 0),
(15, 'Pedro Sánchez', '2023-03-03', 1),
(16, 'Lucía Delgado', '2024-02-28', 1),
(17, 'Raúl Castillo', '2021-10-10', 1);

-- Insertar Prestamos
INSERT INTO Prestamos (id_empleado, monto, tasaInteres, plazoMeses, cuotaMensual, fechaInicio, fechaFin, estado) VALUES
(2, 480.00, 5.2, 10, 48.00, '2025-08-10', '2026-06-10', 'Activo'),
(3, 500.00, 5.5, 12, 45.00, '2025-01-10', '2026-01-10', 'Activo'),
(4, 300.00, 4.0, 6, 52.00, '2025-03-01', '2025-09-01', 'Activo'),
(5, 450.00, 6.2, 24, 19.00, '2024-06-15', '2026-06-15', 'Activo'),
(6, 250.00, 3.8, 5, 52.00, '2025-02-20', '2025-07-20', 'Finalizado'),
(7, 400.00, 5.0, 10, 43.00, '2025-04-05', '2026-02-05', 'Activo'),
(8, 480.00, 6.0, 18, 27.00, '2024-12-01', '2026-06-01', 'Activo'),
(9, 150.00, 3.5, 4, 39.00, '2025-05-10', '2025-09-10', 'Activo'),
(10, 490.00, 5.8, 12, 42.00, '2025-06-01', '2026-06-01', 'Activo'),
(11, 200.00, 4.2, 6, 35.00, '2025-01-15', '2025-07-15', 'Finalizado'),
(12, 470.00, 5.9, 15, 32.00, '2025-03-20', '2026-06-20', 'Activo');

-- Insertar Pagos
INSERT INTO Pagos (id_prestamo, fechaPago, monto, estado) VALUES
(1, '2025-09-10', 48.00, 'Pendiente'),
(2, '2025-02-10', 45.00, 'Pagado'),
(2, '2025-03-10', 45.00, 'Pagado'),
(3, '2025-04-01', 52.00, 'Pagado'),
(3, '2025-05-01', 52.00, 'Pendiente'),
(4, '2024-07-15', 19.00, 'Pagado'),
(4, '2024-08-15', 19.00, 'Pagado'),
(5, '2025-03-20', 52.00, 'Pagado'),
(6, '2025-05-05', 43.00, 'Pagado'),
(7, '2025-01-01', 27.00, 'Pendiente'),
(8, '2025-06-10', 39.00, 'Pagado'),
(9, '2025-07-01', 42.00, 'Pendiente'),
(10, '2025-02-15', 35.00, 'Pagado'),
(11, '2025-04-20', 32.00, 'Pagado');

-- Consultas SELECT arregladas
SELECT * FROM Usuarios;
SELECT * FROM Empleados;
SELECT * FROM Prestamos;
SELECT * FROM Pagos;
SELECT * FROM HistorialPrestamos;
SELECT * FROM Notificaciones;
SELECT * FROM Calendario;

-- Extras útiles
SELECT * FROM Prestamos WHERE id_empleado = 3;
SELECT * FROM Pagos WHERE estado = 'Pendiente';
SELECT * FROM Empleados WHERE estado = 1;




/*Qué hace:

Une la tabla Prestamos con Empleados usando la relación p.id_empleado = e.idEmpleado.
Trae información de los préstamos junto con el nombre del empleado que lo recibió.

Ejemplo de uso en CREDARIS:
Mostrar un listado completo de todos los préstamos con el nombre del empleado que los solicitó.
Útil para la interfaz del administrador o empleado para ver quién tiene qué préstamo.*/
SELECT 
    p.idPrestamo,
    e.nombreCompleto,
    p.monto,
    p.tasaInteres,
    p.plazoMeses,
    p.cuotaMensual,
    p.fechaInicio,
    p.fechaFin,
    p.estado
FROM Prestamos p
JOIN Empleados e ON p.id_empleado = e.idEmpleado;



/*Qué hace:

Igual que el primer JOIN, une préstamos con empleados.
Además, filtra solo los préstamos que empezaron entre el 1 de enero y el 30 de junio de 2025.

Ejemplo de uso en CREDARIS:
Un administrador quiere ver todos los préstamos otorgados en los primeros seis meses del año 2025 para reportes o auditoría.*/
SELECT 
    e.nombreCompleto,
    p.idPrestamo,
    p.monto,
    p.fechaInicio,
    p.fechaFin,
    p.estado
FROM Prestamos p
JOIN Empleados e ON p.id_empleado = e.idEmpleado
WHERE p.fechaInicio BETWEEN '2025-01-01' AND '2025-06-30';





/*Qué hace:
Une préstamos con empleados, como antes.
Filtra solo los préstamos que todavía están activos (no finalizados).

Ejemplo de uso en CREDARIS:
Mostrar en la pantalla del administrador todos los préstamos que todavía están activos y requieren seguimiento de pagos.*/
SELECT 
    e.nombreCompleto,
    p.idPrestamo,
    p.monto,
    p.plazoMeses,
    p.cuotaMensual,
    p.fechaInicio,
    p.fechaFin,
    p.estado
FROM Prestamos p
JOIN Empleados e ON p.id_empleado = e.idEmpleado
WHERE p.estado = 'Activo';



-------------------------------------------------------------
--CREO QUE LE HACEN MAS FALTAS DE JOIN PARA LAS INTERFASES (LOS FROM)
------------------------------------------------------------------




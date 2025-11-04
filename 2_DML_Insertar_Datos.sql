

USE pollitos_pio;

INSERT INTO Cliente (id_cliente, estado) VALUES
(1, 'ACTIVO'),
(2, 'ACTIVO'),
(3, 'ACTIVO'),
(4, 'ACTIVO'),
(5, 'ACTIVO'),
(6, 'ACTIVO'),
(7, 'ACTIVO'),
(8, 'INACTIVO');

INSERT INTO Cliente_Particular (id_clienteP, nombres, apellidos, tel_particular) VALUES
(1, 'Juan Carlos', 'García López', '5512345678'),
(2, 'María Elena', 'Martínez Pérez', '5523456789'),
(3, 'Pedro Antonio', 'Rodríguez Sánchez', '5534567890'),
(4, 'Ana Isabel', 'Hernández Cruz', '5545678901'),
(5, 'Luis Fernando', 'González Ramírez', '5556789012');

INSERT INTO Cliente_Empresarial (id_clienteE, nombres, apellidos, tel_empresa, razon_social) VALUES
(6, 'Roberto', 'Méndez Castro', '5567890123', 'Eventos y Banquetes SA de CV'),
(7, 'Carmen', 'López Flores', '5578901234', 'Catering Profesional del Sur'),
(8, 'Jorge', 'Silva Torres', '5589012345', 'Restaurantes Modernos SC');

INSERT INTO emails_particular (id_clienteP, direccion_email) VALUES
(1, 'juan.garcia@email.com'),
(1, 'jgarcia@trabajo.com'),
(2, 'maria.martinez@gmail.com'),
(3, 'pedro.rodriguez@outlook.com'),
(4, 'ana.hernandez@yahoo.com'),
(5, 'luis.gonzalez@hotmail.com');


INSERT INTO Sucursal (nombre_sucursal, ubi_sucursal, id_cliente, telefono_sucursal) VALUES
('Sucursal Centro', 'Av. Juárez 123, Centro, CDMX', 6, '5512340001'),
('Sucursal Norte', 'Calzada Vallejo 456, Gustavo A. Madero, CDMX', 7, '5512340002'),
('Sucursal Sur', 'Av. División del Norte 789, Coyoacán, CDMX', NULL, '5512340003'),
('Sucursal Oriente', 'Av. Zaragoza 321, Iztapalapa, CDMX', NULL, '5512340004'),
('Sucursal Poniente', 'Av. Observatorio 654, Miguel Hidalgo, CDMX', NULL, '5512340005');


INSERT INTO Producto (nombre_prod, precio_unitario, stock, id_categoria) VALUES
('Pollo Entero Rostizado', 120.00, 50, 1),
('Medio Pollo Rostizado', 65.00, 75, 1),
('Cuarto de Pollo', 35.00, 100, 1),
('Papas Fritas Chicas', 25.00, 80, 2),
('Papas Fritas Grandes', 40.00, 60, 2),
('Ensalada Fresca', 30.00, 45, 2),
('Refresco 600ml', 20.00, 150, 3),
('Agua Natural 1L', 15.00, 120, 3),
('Salsa Verde', 10.00, 200, 4),
('Salsa Roja', 10.00, 200, 4);


INSERT INTO Ventas (tipo_pago, fecha_compra, venta_total, descuento_apli, id_cliente, id_sucursal) VALUES
('EFECTIVO', '2025-10-15 12:30:00', 185.00, 0.00, 1, 1),
('TARJETA', '2025-10-15 13:45:00', 250.00, 10.00, 2, 1),
('TRANSFERENCIA', '2025-10-16 14:20:00', 450.00, 0.00, 6, 2),
('EFECTIVO', '2025-10-16 15:10:00', 130.00, 5.00, 3, 3),
('TARJETA', '2025-10-17 16:30:00', 95.00, 0.00, 4, 2),
('EFECTIVO', '2025-10-17 17:45:00', 370.00, 15.00, 7, 1),
('TARJETA', '2025-10-18 12:15:00', 220.00, 0.00, 5, 4),
('EFECTIVO', '2025-10-18 13:30:00', 165.00, 0.00, 1, 5);


INSERT INTO Detalle_de_compra (id_compras, id_producto, cantidad, precio_unitario_venta) VALUES
-- Venta 1
(1, 1, 1, 120.00),
(1, 4, 1, 25.00),
(1, 7, 2, 20.00),
-- Venta 2
(2, 2, 2, 65.00),
(2, 5, 1, 40.00),
(2, 8, 2, 15.00),
-- Venta 3
(3, 1, 3, 120.00),
(3, 5, 2, 40.00),
-- Venta 4
(4, 2, 1, 65.00),
(4, 4, 1, 25.00),
(4, 7, 2, 20.00),
-- Venta 5
(5, 3, 2, 35.00),
(5, 4, 1, 25.00),
-- Venta 6
(6, 1, 2, 120.00),
(6, 5, 2, 40.00),
(6, 6, 1, 30.00),
-- Venta 7
(7, 2, 2, 65.00),
(7, 4, 2, 25.00),
(7, 7, 2, 20.00),
-- Venta 8
(8, 1, 1, 120.00),
(8, 7, 1, 20.00),
(8, 9, 2, 10.00);

-- VERIFICAR DATOS INSERTADOS


SELECT 'Clientes' AS Tabla, COUNT(*) AS Total FROM Cliente
UNION ALL
SELECT 'Clientes Particulares', COUNT(*) FROM Cliente_Particular
UNION ALL
SELECT 'Clientes Empresariales', COUNT(*) FROM Cliente_Empresarial
UNION ALL
SELECT 'Emails', COUNT(*) FROM emails_particular
UNION ALL
SELECT 'Sucursales', COUNT(*) FROM Sucursal
UNION ALL
SELECT 'Productos', COUNT(*) FROM Producto
UNION ALL
SELECT 'Ventas', COUNT(*) FROM Ventas
UNION ALL
SELECT 'Detalles de Compra', COUNT(*) FROM Detalle_de_compra;

-- Mostrar algunos datos insertados
SELECT * FROM Producto;
SELECT * FROM Ventas LIMIT 5;


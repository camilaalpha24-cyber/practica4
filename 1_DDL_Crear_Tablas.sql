-- Tejeda Marquez Leandro Gabriel | Cardenas Martinez Camila

-- Eliminación segura de base de datos existente
DROP DATABASE IF EXISTS pollitos_pio;

-- Creación de la base de datos
CREATE DATABASE pollitos_pio
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE pollitos_pio;

-- TABLAS

-- Tabla 1: Cliente (Superentidad)
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'ACTIVO',

    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT chk_cliente_estado CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

-- Tabla 2: Cliente_Particular
CREATE TABLE Cliente_Particular (
    id_clienteP INT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    tel_particular VARCHAR(15),

    CONSTRAINT pk_cliente_particular PRIMARY KEY (id_clienteP),
    CONSTRAINT fk_clienteP_cliente FOREIGN KEY (id_clienteP) 
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_nombres_particular CHECK (CHAR_LENGTH(nombres) >= 2),
    CONSTRAINT chk_apellidos_particular CHECK (CHAR_LENGTH(apellidos) >= 2),
    CONSTRAINT chk_tel_particular CHECK (tel_particular REGEXP '^[0-9]{10,15}$' OR tel_particular IS NULL)
);

-- Tabla 3: Cliente_Empresarial
CREATE TABLE Cliente_Empresarial (
    id_clienteE INT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    tel_empresa VARCHAR(15),
    razon_social VARCHAR(150),

    CONSTRAINT pk_cliente_empresarial PRIMARY KEY (id_clienteE),
    CONSTRAINT fk_clienteE_cliente FOREIGN KEY (id_clienteE) 
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_nombres_empresarial CHECK (CHAR_LENGTH(nombres) >= 2),
    CONSTRAINT chk_apellidos_empresarial CHECK (CHAR_LENGTH(apellidos) >= 2),
    CONSTRAINT chk_tel_empresarial CHECK (tel_empresa REGEXP '^[0-9]{10,15}$' OR tel_empresa IS NULL)
);

-- Tabla 4: emails_particular
CREATE TABLE emails_particular (
    id_clienteP INT,
    direccion_email VARCHAR(255),

    CONSTRAINT pk_emails_particular PRIMARY KEY (id_clienteP, direccion_email),
    CONSTRAINT fk_emails_clienteP FOREIGN KEY (id_clienteP) 
        REFERENCES Cliente_Particular(id_clienteP)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_formato_email CHECK (direccion_email LIKE '%_@_%._%')
);

-- Tabla 5: Sucursal
CREATE TABLE Sucursal (
    id_sucursal INT AUTO_INCREMENT,
    nombre_sucursal VARCHAR(100) NOT NULL,
    ubi_sucursal VARCHAR(255),
    id_cliente INT,
    telefono_sucursal VARCHAR(15),

    CONSTRAINT pk_sucursal PRIMARY KEY (id_sucursal),
    CONSTRAINT fk_sucursal_cliente FOREIGN KEY (id_cliente) 
        REFERENCES Cliente(id_cliente)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT uq_sucursal_cliente UNIQUE (id_cliente),
    CONSTRAINT uq_nombre_sucursal UNIQUE (nombre_sucursal),
    CONSTRAINT chk_nombre_sucursal CHECK (CHAR_LENGTH(nombre_sucursal) >= 3)
);

-- Tabla 6: Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT,
    nombre_prod VARCHAR(150) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    id_categoria INT,

    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT uq_nombre_producto UNIQUE (nombre_prod),
    CONSTRAINT chk_precio_positivo CHECK (precio_unitario > 0),
    CONSTRAINT chk_stock_no_negativo CHECK (stock >= 0),
    CONSTRAINT chk_nombre_prod_longitud CHECK (CHAR_LENGTH(nombre_prod) >= 3)
);

-- Tabla 7: Ventas
CREATE TABLE Ventas (
    id_compras INT AUTO_INCREMENT,
    tipo_pago VARCHAR(20) NOT NULL,
    fecha_compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    venta_total DECIMAL(10,2) NOT NULL,
    descuento_apli DECIMAL(5,2) DEFAULT 0.00,
    id_cliente INT,
    id_sucursal INT NOT NULL,

    CONSTRAINT pk_ventas PRIMARY KEY (id_compras),
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente) 
        REFERENCES Cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_ventas_sucursal FOREIGN KEY (id_sucursal) 
        REFERENCES Sucursal(id_sucursal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_tipo_pago CHECK (tipo_pago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA')),
    CONSTRAINT chk_venta_total_positivo CHECK (venta_total >= 0),
    CONSTRAINT chk_descuento_rango CHECK (descuento_apli BETWEEN 0 AND 100)
);

-- Tabla 8: Detalle_de_compra
CREATE TABLE Detalle_de_compra (
    id_detallecompra INT AUTO_INCREMENT,
    id_compras INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario_venta DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_detalle_compra PRIMARY KEY (id_detallecompra),
    CONSTRAINT fk_detalle_ventas FOREIGN KEY (id_compras) 
        REFERENCES Ventas(id_compras)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) 
        REFERENCES Producto(id_producto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_compra_producto UNIQUE (id_compras, id_producto),
    CONSTRAINT chk_cantidad_positiva CHECK (cantidad > 0),
    CONSTRAINT chk_precio_venta_positivo CHECK (precio_unitario_venta > 0)
);


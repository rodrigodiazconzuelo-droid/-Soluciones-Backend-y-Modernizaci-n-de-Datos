-- ==============================================================================
-- PROYECTO: Migración de Base de Datos Heredada a Esquema Relacional Normalizado
-- OBJETIVO: Eliminar redundancia de datos y mejorar la velocidad de consulta (JOINs)
-- ==============================================================================

-- 1. Creación de tabla de Clientes (Llave Primaria optimizada)
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_empresa VARCHAR(150) NOT NULL,
    rfc VARCHAR(13) UNIQUE NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Creación de tabla de Ventas con Llave Foránea
CREATE TABLE Ventas_Historicas (
    venta_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    monto_total DECIMAL(10, 2) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    estado_pago VARCHAR(20) DEFAULT 'Pendiente',
    
    -- Relación para mantener la integridad referencial de los datos
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (cliente_id) 
    REFERENCES Clientes(cliente_id)
);

-- Índice para acelerar las búsquedas de reportes mensuales
CREATE NONCLUSTERED INDEX IX_FechaTransaccion ON Ventas_Historicas(fecha_transaccion);

USE WalmartDB;
GO

-- ==============================================================================
-- 1. VISTAS DE DIMENSIONES (Catálogos o Tablas Maestras)
-- ==============================================================================

-- Dimensión Tiendas (Trae solo lo necesario para filtrar)
CREATE OR ALTER VIEW vDim_Tiendas AS
SELECT 
    Store_ID,
    Nombre_Tienda,
    Type AS Tipo_Tienda,
    Size AS Tamano_Metros
FROM Tiendas;
GO

-- Dimensión Productos (Pre-une Producto y Categoría para facilitarle la vida a Power BI)
CREATE OR ALTER VIEW vDim_Productos AS
SELECT 
    P.Producto_ID,
    P.Nombre AS Nombre_Producto,
    P.Precio,
    P.TipoProducto,
    C.TipoCategoria AS Categoria,
    P.Department_ID
FROM Productos P
LEFT JOIN Categoria C ON P.Categoria_ID = C.Categoria_ID;
GO

-- Dimensión Departamentos
CREATE OR ALTER VIEW vDim_Departamentos AS
SELECT 
    Department_ID,
    Num_Department AS Codigo_Departamento,
    Department_Name AS Nombre_Departamento
FROM Departamentos;
GO

-- Dimensión Calendario
CREATE OR ALTER VIEW vDim_Calendario AS
SELECT 
    Fecha,
    IsHoliday AS Es_Festivo,
    YEAR(Fecha) AS Anio,
    MONTH(Fecha) AS Mes,
    DATENAME(MONTH, Fecha) AS Nombre_Mes
FROM Calendar;
GO

-- ==============================================================================
-- 2. VISTAS DE HECHOS (Tablas Transaccionales para medir)
-- ==============================================================================

-- Hechos Ventas (Tu tabla principal de análisis)
CREATE OR ALTER VIEW vFact_Ventas AS
SELECT 
    Sale_ID,
    Store_ID,
    Department_ID,
    Producto_ID,
    Fecha,
    Cantidad,
    Sale_Amount AS Monto_Venta
FROM Ventas;
GO

-- Hechos Inventario (La foto de tu stock actual)
CREATE OR ALTER VIEW vFact_Stock AS
SELECT 
    Stock_ID,
    Store_ID,
    Producto_ID,
    Fecha AS Fecha_Ultima_Actualizacion,
    Cantidad_Existencia,
    Stock_Minimo
FROM Stock;
GO

-- Hechos Contexto (Tus indicadores macroeconómicos)
CREATE OR ALTER VIEW vFact_Contexto AS
SELECT 
    Store_ID,
    Fecha,
    Temperature AS Temperatura,
    Fuel_Price AS Precio_Combustible,
    CPI AS Inflacion,
    Unemployment AS Tasa_Desempleo
FROM Store_Context_Features;
GO

-- ==============================================================================
-- 3. VISTAS ADICIONALES (Para KPIs de Logística, Calidad y Marketing)
-- ==============================================================================

-- Hechos Ingresos (Uniendo Cabecera y Detalle para Power BI)
-- Esto te permitirá analizar el volumen de entrada de mercancía por tienda y proveedor.
CREATE OR ALTER VIEW vFact_Ingresos AS
SELECT 
    C.Ingreso_ID,
    C.Store_ID,
    C.Fecha_Ingreso,
    D.Producto_ID,
    D.Cantidad AS Cantidad_Ingresada
FROM Ingresos_Cabecera C
INNER JOIN Ingresos_Detalle D ON C.Ingreso_ID = D.Ingreso_ID;
GO

-- Hechos Devoluciones (Para medir el % de defectos o mermas)
CREATE OR ALTER VIEW vFact_Devoluciones AS
SELECT 
    Devoluciones_ID,
    Producto_ID,
    Fecha AS Fecha_Devolucion,
    Tipo_Devolucion,
    Cantidad AS Cantidad_Devuelta
FROM Devoluciones;
GO

-- Dimensión Promociones
CREATE OR ALTER VIEW vDim_Promociones AS
SELECT 
    Promociones_ID,
    TipoDePromocion AS Tipo_Promocion,
    Fecha_Inicio,
    Fecha_Fin
FROM Promociones;
GO

-- Tabla Puente Promociones-Productos (Factless Fact Table)
-- Necesaria en Power BI para resolver la relación Muchos a Muchos
CREATE OR ALTER VIEW vBridge_Producto_Promocion AS
SELECT 
    Producto_ID,
    Promociones_ID
FROM Producto_Promocion;
GO


------------------------------------------------------------------------------------------------------
---Modificando la Vista de Deluciones, por el error en la creación de la tabla---
USE WalmartDB;
GO

CREATE OR ALTER VIEW vFact_Devoluciones AS
SELECT 
    Devoluciones_ID,
    Producto_ID,
    Store_ID, -- <--- Agregamos la nueva llave de relación con las tiendas
    Fecha AS Fecha_Devolucion,
    Tipo_Devolucion,
    Cantidad AS Cantidad_Devuelta
FROM Devoluciones;
GO

SELECT 'Vistas creadas exitosamente ;)' AS Estado;
GO
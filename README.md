# 📊 Walmart Sales, Stock & Quality Analytics Dashboard
---

## ⚠️ Aclaración sobre los Datos
* **Origen:** La base de datos se estructuró tomando como base un conjunto de datos público de **Kaggle**.
* **Naturaleza de los datos:** Toda la información contenida en la base de datos y reflejada en los tableros (nombres de productos, sucursales, fechas, montos y transacciones) es **completamente ficticia y simulada** con fines estrictamente académicos y demostrativos. No representa datos reales, comerciales ni operativos de la empresa mencionada.

---

Este proyecto implementa una solución completa de Business Intelligence para la gestión operativa en sucursales de **Walmart El Salvador**. Abarca desde el modelado y la reestructuración
de la base de datos relacional en **SQL Server (T-SQL)** hasta el diseño y optimización de un modelo en estrella interactivo en **Power BI**.

> 💡 *Proyecto académico desarrollado con enfoque profesional y estándares listos para la toma de decisiones directivas.*

---

## 🛠️ Tecnologías Utilizadas
* **Base de Datos:** SQL Server (T-SQL) - Diseño de tablas, triggers, vistas e integridad referencial.
* **Herramienta BI:** Power BI Desktop - Modelado en estrella, métricas avanzadas en DAX y UX/UI Layout.
* **Control de Versiones:** Git & GitHub.

---

## 🏗️ Arquitectura y Modelado de Datos (SQL Server)

El origen de los datos se optimizó en el motor de base de datos para desacoplar las consultas directas de Power BI utilizando la mejor práctica de **Capa de Presentación mediante Vistas (Views)**.

### ## Destacados de Ingeniería de Datos:
* **Integridad Referencial Corregida:** Implementación de sentencias `ALTER TABLE` para la adición de llaves foráneas (`Store_ID`) en la tabla de hechos, garantizando consistencia.
* **Capa de Vistas:** Creación de vistas optimizadas (`CREATE OR ALTER VIEW vFact_Devoluciones`) para asegurar cargas incrementales limpias y aislar la lógica del negocio del almacenamiento físico.

*(
CREATE OR ALTER VIEW vFact_Devoluciones AS
SELECT 
    Devoluciones_ID,
    Producto_ID,
    Store_ID,
    Fecha AS Fecha_Devolucion,
    Tipo_Devolucion,
    Cantidad AS Cantidad_Devuelta
FROM Devoluciones;
GO
)*

---

## 📈 Paneles y Dashboards Interactivos (Power BI)

El reporte final cuenta con **3 pantallas operativas** que mantienen una estricta simetría visual (Layout corporativo, paleta de colores y una matriz uniforme de 10 tarjetas de KPIs superiores).

### 1. Panel de Ventas (`Ventas`)
* Análisis macro del ticket promedio, precio por unidad e ingresos históricos ($67,221.83 totales).
* Análisis de participación por departamento (Abarrotes liderando con 71.55%).
* **Métricas DAX Implementadas:** Análisis temporales avanzados Year-over-Year (`YoY %`).

### 2. Control de Stock (`Control de Stock`)
* Medición de rotación de inventarios, días de stock disponible y alertas del estado actual del inventario ("Normal").
* Visibilidad del valor estimado total en existencias por sucursal.

### 3. Devoluciones y Calidad (`Devoluciones y Calidad`)
* Análisis detallado de mermas y causas de incidencias ("Por daño" vs "Por defectos").
* **Optimización de UX:** Uso de filtros dinámicos basados en métricas explícitas (`Total Devoluciones`) para limpiar el segmentador de fechas, eliminando periodos vacíos y asegurando una navegación intuitiva.

---

## 🗺️ Modelo de Datos (Esquema en Estrella)

El proyecto utiliza un modelo relacional en estrella limpio con dirección de filtrado único ($1:*$), permitiendo un rendimiento óptimo de las consultas DAX.

![Modelo Relacional](./Vista%20de%20Modelo(Power%20BI).png)

---

## 📸 Capturas del Proyecto

### ## Dashboard de Ventas
![Dashboard Ventas](./Ventas(1).png)

### ## Control de Inventarios
![Control de Stock](./Stock(1).png)

### ## Gestión de Calidad y Devoluciones
![Devoluciones](./Devoluciones(1).png)

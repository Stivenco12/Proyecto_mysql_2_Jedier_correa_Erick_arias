# Gestión de una Finca de Producción Agrícola

## Descripción del Proyecto

El proyecto "Gestión de una Finca de Producción Agrícola" tiene como objetivo desarrollar un sistema integral para la gestión eficiente de la producción agrícola, proporcionando un marco para almacenar, consultar y analizar datos relacionados con detalles de parcelas, productos, proveedores, clientes y ventas. La base de datos está diseñada para ofrecer funcionalidad completa que incluye el registro de información sobre cultivos, inventarios, transacciones de compra y venta, así como la gestión de recursos humanos dentro de la finca.

Las funcionalidades implementadas abarcan la gestión de:

- Ubicaciones geográficas (países, regiones, ciudades, barrios).
- Parcelas y detalles relacionados, incluyendo el tipo y tamaño de cada parcela.
- Empleados y sus cargos, con soporte para las relaciones entre ellos.
- Proveedores y sus productos, con características y precios asociados.
- Ventas que incluyen detalles sobre los clientes y productos vendidos, así como el registro de compras.

## Requisitos del Sistema

Para ejecutar este proyecto, necesitas:

- **MySQL** versión 5.7 o superior.
- **MySQL Workbench** para la administración y consulta de bases de datos (opcional).
- Una herramienta de línea de comandos de MySQL para ejecutar scripts directamente (opcional).

## Instalación y Configuración

### Paso 1: Instalación de MySQL

1. Descarga e instala MySQL desde su sitio oficial
2. Durante la instalación, puedes seleccionar la opción de instalar MySQL Server y MySQL Workbench.

### Paso 2: Ejecución del archivo `ddl.sql`

1. Abre MySQL Workbench y conéctate a tu servidor MySQL.

2. Crea una nueva base de datos utilizando el siguiente comando:

   ```sql
   CREATE DATABASE Finca;
   USE Finca;
   ```

3. Selecciona la base de datos `Finca`.

4. Abre y ejecuta el script `ddl.sql` para crear la estructura de la base de datos.

### Paso 3: Carga de datos iniciales con `dml.sql`

1. Sigue el mismo procedimiento para cargar el archivo `dml.sql` para poblar la base de datos con datos iniciales relevantes.

### Paso 4: Ejecución de consultas y scripts adicionales

Ejecuta tus consultas SQL, procedimientos almacenados, y funciones directamente desde MySQL Workbench.

## Estructura de la Base de Datos

La base de datos se compone de las siguientes tablas principales:

- **Pais, Region, Ciudad:** Para almacenar la jerarquía geográfica.
- **Ubicacion:** Contiene detalles de las ubicaciones específicas.
- **Detalle_Parcela y Parcela:** Para la gestión de parcelas agrícolas.
- **Empleado y Detalle_Empleado:** Para el registro de la información de los empleados.
- **Proveedor y Detalle_Proveedor:** Para la gestión de los proveedores de insumos.
- **Producto y Detalle_Producto:** Incluye la información de los productos con sus especificaciones.
- **Cliente y Detalle_Cliente:** Para almacenar información de los clientes.
- **Detalle_Venta y Venta:** Para gestionar las transacciones de venta.
- **Detalle_Pedido, Pedido:** Para la gestión de pedidos de productos.
- **Detalle_Compra y Compra:** Para gestionar las compras realizadas.

Las relaciones entre las tablas permiten un seguimiento eficiente y la conservación de la integridad de los datos.

## Ejemplos de Consultas

Algunos ejemplos de consultas SQL (tanto básicas como avanzadas) que puedes realizar incluyen:

### Consultas Básicas

- Listado de empleados con sus detalles:

  

  ```sql
  SELECT Empleado.id AS id_empleado, Empleado.nombre AS nombre_empleado, Detalle_empleado.*, Cargo_empleado.*
  FROM Empleado
  LEFT JOIN Detalle_empleado ON Empleado.detalle_empleado_fk = Detalle_empleado.id
  LEFT JOIN Cargo_empleado ON Empleado.cargo_empleado_fk = Cargo_empleado.id
  LIMIT 10;
  ```

### Consultas Avanzadas

- Total de ventas por producto:

  

  ```sql
  SELECT p.nombre AS producto_nombre, COUNT(dv.id) AS total_ventas
  FROM Producto p
  LEFT JOIN Detalle_venta dv ON dv.producto_fk = p.id
  GROUP BY p.id;
  ```

## Procedimientos, Funciones, Triggers y Eventos

### Funciones

Se han creado varias funciones para realizar cálculos útiles en el contexto del sistema:

1. **`costo_operativo_total`:** Calcula el total de costos operativos en un rango de fechas.
2. **`total_ventas_cliente2`:** Calcula el total de ventas realizadas a un cliente específico.
3. **`stock_disponible`:** Devuelve el stock disponible de un producto específico.
4. **`rentabilidad_producto`:** Calcula la rentabilidad de un producto a partir de ingresos y costos.

### Procedimientos Almacenados

Ejemplos de procedimientos que ayudan en la gestión de la base de datos:

- **Registrar una nueva venta:**

  

  ```sql
  CREATE PROCEDURE RegistrarVenta (IN clienteId INT, IN productoId INT, IN cantidad INT, OUT total DECIMAL(10, 2))
  BEGIN
      DECLARE valor DECIMAL(10, 2);
      DECLARE nuevo_stock INT;
      SELECT valor INTO valor FROM Detalle_producto WHERE id = productoId;
      SET total = valor * cantidad;
      INSERT INTO Detalle_venta (ubicacion_fk, cliente_fk, producto_fk) VALUES (
          (SELECT ubicacion_fk FROM ubicacion LIMIT 10), clienteId,productoId
      );
      SELECT stock_actual INTO nuevo_stock FROM Detalle_Inventario WHERE producto_fk = productoId;
      UPDATE Detalle_Inventario
      SET stock_actual = nuevo_stock - cantidad
      WHERE producto_fk = productoId;
  END;
  ```

- **Actualizar el inventario después de una venta:**

  

  ```sql
  CREATE PROCEDURE ActualizarInventario (IN productoId INT, IN cantidad INT)
  BEGIN
      UPDATE Detalle_Inventario
      SET stock_actual = stock_actual + cantidad
      WHERE producto_fk = productoId;
  END;
  ```

### Triggers

Se han implementado triggers para mantener integridad referencial y lógica de negocio:

- **`actualizar_inventario_al_insertar_venta`:** Disminuye el stock al insertar una nueva venta.
- **`verificar_disponibilidad_producto`:** Asegura que el stock de un producto sea suficiente antes de crear un pedido.

## Contribuciones

Este proyecto fue desarrollado en un entorno de trabajo colaborativo, cada integrante tuvo diferentes responsabilidades.

- **Jedier stivenson:** Diseño del esquema de la base de datos y la estructura de las tablas.
- **Erick arias:** Documentación y pruebas.

## Licencia y Contacto

Este proyecto está bajo la licencia MIT. Para cualquier pregunta o problema con la implementación, por favor contáctame a través de **stivencorrealol89123@gmail.com**.


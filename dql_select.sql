
--consulta 1: Datos Del Empleado
SELECT Empleado.id AS id_empleado, Empleado.nombre AS nombre_empleado,Detalle_empleado.*,Cargo_empleado.*
FROM Empleado
LEFT JOIN Detalle_empleado ON Empleado.detalle_empleado_fk = Detalle_empleado.id
LEFT JOIN Cargo_empleado ON Empleado.cargo_empleado_fk = Cargo_empleado.id
LIMIT 10;
--consulta 2: Datos del pedido
SELECT Pedido.id AS id_pedido,Pedido.nombre AS nombre_pedido, Tipo_pedido.*, Detalle_pedido.*
FROM Pedido
LEFT JOIN Tipo_pedido ON Pedido.tipo_pedido_fk = Tipo_pedido.id
LEFT JOIN Detalle_pedido ON Pedido.detalle_pedido_fk = Detalle_pedido.id
LIMIT 10;
--consulta 3: Datos de region:
SELECT r.id, r.nombre AS region_name, p.nombre AS pais_name
FROM Region r
JOIN Pais p ON r.pais_fk = p.id;
--consulta 4: Datos de ciudad:
SELECT c.id, c.nombre AS ciudad_name, r.nombre AS region_name
FROM Ciudad c
JOIN Region r ON c.region_fk = r.id;
--consulta 5: Datos de ubicacion:
SELECT u.id, u.barrio, u.direccion, c.nombre AS ciudad_name
FROM ubicacion u
JOIN Ciudad c ON u.ciudad_fk = c.id;
--consulta 6: Datos de detalle parcela :
SELECT dp.id, dp.tamaño, dp.Tipo_Parcela, u.barrio, u.direccion
FROM Detalle_parcela dp
JOIN ubicacion u ON dp.ubicacion_fk = u.id;
--consulta 7: Datos de parcela :
SELECT p.id, p.nombre AS parcela_name, dp.tamaño, dp.Tipo_Parcela, e.nombre AS empleado_name
FROM Parcela p
JOIN Detalle_parcela dp ON p.detalle_parcela_fk = dp.id
JOIN Empleado e ON p.empleado_parcela_fk = e.id;
-- consulta 8: Detalle empleado:
SELECT de.id, de.apellido, de.cedula, de.Correo, ce.Cargo_Nombre
FROM Detalle_empleado de
JOIN Empleado e ON de.id = e.detalle_empleado_fk
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id;
-- consulta 9: Cargo empleado : 
SELECT ce.id, ce.Cargo_Nombre, ce.Horas_Trabajo, ce.sueldo, e.nombre AS empleado_name
FROM Cargo_empleado ce
JOIN Empleado e ON ce.id = e.cargo_empleado_fk;
-- consulta 10: empleado :
SELECT e.id, e.nombre AS empleado_nombre, de.apellido, de.cedula, ce.Cargo_Nombre
FROM Empleado e
JOIN Detalle_empleado de ON e.detalle_empleado_fk = de.id
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id;
-- consulta 11: Detalle proveedor:
SELECT dp.id, dp.cedula, dp.Telefono, dp.Email, u.barrio, u.direccion 
FROM Detalle_proveedor dp 
JOIN ubicacion u ON dp.ubicacion_fk = u.id;
--consulta 12 : detalle producto:
SELECT dp.id, dp.valor, dp.tamaño, dp.Kilogramos, dp.litros, p.nombre AS proveedor_nombre 
FROM Detalle_producto dp 
JOIN Proveedor p ON dp.Proveedor_fk = p.id;-
-- consulta 13: tipo producto : 
SELECT id, Liquido, solido, comestible, organicos FROM Tipo_producto;
-- consulta 13: producto :
SELECT p.id, p.nombre, tp.Liquido, tp.solido, tp.comestible, tp.organicos, dp.valor 
FROM Producto p 
JOIN Tipo_producto tp ON p.tipo_producto_fk = tp.id 
JOIN Detalle_producto dp ON p.detalle_producto_fk = dp.id;
-- consulta 14: detalle cliente:
SELECT id, apellido, cedula FROM Detalle_cliente;
-- consulta 15: cliente
SELECT c.id, c.nombre, dc.apellido, dc.cedula 
FROM Cliente c 
JOIN Detalle_cliente dc ON c.detalle_cliente_fk = dc.id;
-- consulta 16: detalle venta:
SELECT dv.id, u.barrio, u.direccion, c.nombre AS cliente_nombre, p.nombre AS producto_nombre 
FROM Detalle_venta dv 
JOIN ubicacion u ON dv.ubicacion_fk = u.id 
JOIN Cliente c ON dv.cliente_fk = c.id 
JOIN Producto p ON dv.producto_fk = p.id;
-- consulta 17: venta:
SELECT v.id, v.nombre AS venta_nombre, c.nombre AS cliente_nombre, p.nombre AS producto_nombre,dv.ubicacion_fk 
FROM Venta v
JOIN Detalle_venta dv ON v.detalle_venta_fk = dv.id
JOIN Cliente c ON dv.cliente_fk = c.id
JOIN Producto p ON dv.producto_fk = p.id;
-- consulta 18 : detalle pedido :
SELECT dp.id AS pedido_id, dp.descripcion, p.nombre AS producto_nombre, v.nombre AS venta_nombre, c.nombre AS cliente_nombre 
FROM Detalle_pedido dp 
JOIN Producto p ON dp.producto_fk = p.id 
JOIN Venta v ON dp.venta_fk = v.id 
JOIN Cliente c ON dp.cliente_fk = c.id;
-- consulta 19 : pedido tipo:
SELECT id, Tipo_de_pedido, Clasificacion, prioridad FROM Tipo_pedido;
--consulta 20: pedido :
SELECT p.id AS pedido_id, p.nombre AS pedido_nombre, tp.Tipo_de_pedido,  tp.Clasificacion, tp.prioridad, dp.descripcion AS detalle_descripcion 
FROM Pedido p 
JOIN Tipo_pedido tp ON p.tipo_pedido_fk = tp.id 
JOIN Detalle_pedido dp ON p.detalle_pedido_fk = dp.id;
--consulta 21: detalle compra:
SELECT dc.id AS compra_id, dc.descripcion, dc.fecha_Compra, p.nombre AS producto_nombre, e.nombre AS empleado_nombre 
FROM Detalle_compra dc 
JOIN Producto p ON dc.producto_fk = p.id 
JOIN Empleado e ON dc.empleado_fk = e.id;
--consulta 22: tipo compra
SELECT tc.id AS tipo_compra_id, p.nombre AS pedido_nombre 
FROM Tipo_Compra tc 
JOIN Pedido p ON tc.Pedido_fk = p.id;
--consulta 23 : compra:
SELECT c.id AS compra_id, cl.nombre AS cliente_nombre, dc.descripcion AS detalle_descripcion, tc.id AS tipo_compra_id 
FROM Compra c 
JOIN Cliente cl ON c.cliente_fk = cl.id 
JOIN Detalle_compra dc ON c.Detalle_compra_fk = dc.id 
JOIN Tipo_Compra tc ON c.Tipo_Compra_fk = tc.id;
-- consulta 24 :detalle almacen:
SELECT da.id AS detalle_almacen_id, da.Can_Productos_max, u.barrio, u.direccion 
FROM Detalle_almacen da 
JOIN ubicacion u ON da.ubicacion_fk = u.id;
--consulta 25: almacen:
SELECT a.id AS almacen_id, a.Descrision AS almacen_descripcion, da.Can_Productos_max 
FROM Almacen a 
JOIN Detalle_almacen da ON a.Detalle_almacen_FK = da.id;
--consulta 26: detalle inventario:
SELECT di.id AS inventario_id, p.nombre AS producto_nombre, di.fecha, di.stock_actual, a.Descrision AS almacen_descripcion 
FROM Detalle_Inventario di 
JOIN Producto p ON di.producto_fk = p.id 
JOIN Almacen a ON di.Almacen_fk = a.id;
--consulta 27: Inventario:
SELECT i.id AS inventario_id, i.Descrision AS inventario_descripcion, di.fecha, di.stock_actual 
FROM Inventario i 
JOIN Detalle_Inventario di ON i.Detalle_Inventario_fk = di.id;
--consulta 28: Listar todas las ventas junto con el cliente y la ubicación.
SELECT v.id AS venta_id, v.nombre AS venta_nombre, c.nombre AS cliente_nombre, u.barrio, u.direccion 
FROM Venta v 
JOIN Detalle_venta dv ON v.detalle_venta_fk = dv.id 
JOIN Cliente c ON dv.cliente_fk = c.id 
JOIN ubicacion u ON dv.ubicacion_fk = u.id;
--consulta 29: listar stock
SELECT di.producto_fk, p.nombre AS producto_nombre, di.stock_actual, a.Descrision AS almacen_descripcion 
FROM Detalle_Inventario di 
JOIN Producto p ON di.producto_fk = p.id 
JOIN Almacen a ON di.Almacen_fk = a.id;
--consulta 30: pedidos con su descricion:
SELECT o.id AS pedido_id, o.nombre AS pedido_nombre, tp.Tipo_de_pedido, tp.Clasificacion 
FROM Pedido o 
JOIN Tipo_pedido tp ON o.tipo_pedido_fk = tp.id;
--consulta 31 : total compras por cliente
SELECT c.nombre AS cliente_nombre, COUNT(co.id) AS total_compras 
FROM Compra co 
JOIN Cliente c ON co.cliente_fk = c.id 
GROUP BY c.id;
-- consulta 32 : pedidos y el cliente que los realizo
SELECT dp.id AS detalle_pedido_id, dp.descripcion, c.nombre AS cliente_nombre 
FROM Detalle_pedido dp 
JOIN Cliente c ON dp.cliente_fk = c.id;
-- consulta 33 : fecha de compra
SELECT c.id AS compra_id, c.cliente_fk, dc.descripcion, dc.fecha_Compra 
FROM Compra c 
JOIN Detalle_compra dc ON c.Detalle_compra_fk = dc.id;
--consulta 33: ventas por ubicacion
SELECT dv.ubicacion_fk, COUNT(dv.id) AS total_ventas 
FROM Detalle_venta dv 
GROUP BY dv.ubicacion_fk;
--consulta 34 : parcelas con su destalles y ubicaciones
SELECT pa.nombre AS parcela_nombre, dp.tamaño, dp.Tipo_Parcela, u.barrio, u.direccion 
FROM Parcela pa 
JOIN Detalle_parcela dp ON pa.detalle_parcela_fk = dp.id 
JOIN ubicacion u ON dp.ubicacion_fk = u.id;
-- consulta 35: ordenes de compra y productos relacionados
SELECT p.id AS pedido_id, p.nombre AS pedido_nombre, dp.descripcion AS detalle_descripcion 
FROM Pedido p 
JOIN Detalle_pedido dp ON p.detalle_pedido_fk = dp.id;
-- consulta 36: empleados ordenados por salario
SELECT e.nombre AS empleado_nombre, ce.Cargo_Nombre, ce.sueldo 
FROM Empleado e 
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id 
ORDER BY ce.sueldo DESC;
-- consulta 37: compras y pedidos asociados
SELECT tc.id AS tipo_compra_id, tc.Pedido_fk, p.nombre AS pedido_nombre 
FROM Tipo_Compra tc 
JOIN Pedido p ON tc.Pedido_fk = p.id;
--consulta 38: empleados por parcelas
SELECT pa.nombre AS parcela_nombre, e.nombre AS empleado_nombre, de.apellido 
FROM Parcela pa 
JOIN Empleado e ON pa.empleado_parcela_fk = e.id 
JOIN Detalle_empleado de ON e.detalle_empleado_fk = de.id;
-- consulta 39: resumen de los tipos:
SELECT tp.Tipo_de_pedido, COUNT(p.id) AS total_pedidos 
FROM Tipo_pedido tp 
LEFT JOIN Pedido p ON tp.id = p.tipo_pedido_fk 
GROUP BY tp.Tipo_de_pedido;
-- consulta 40: resumen de compra por cliente
SELECT c.nombre AS cliente_nombre, COUNT(co.id) AS total_compras 
FROM Cliente c 
LEFT JOIN Compra co ON c.id = co.cliente_fk 
GROUP BY c.id;
-- consulta 41: provedores y sus productos
SELECT pr.nombre AS proveedor_nombre, p.nombre AS producto_nombre 
FROM Proveedor pr 
JOIN Detalle_proveedor dp ON pr.detalle_proveedor_fk = dp.id 
JOIN Detalle_producto dp2 ON dp.id = dp2.Proveedor_fk 
JOIN Producto p ON dp2.id = p.detalle_producto_fk;
-- consulta 42: listar producto con sus precio y unidades
SELECT p.nombre AS producto_nombre, dp.valor, dp.tamaño 
FROM Producto p 
JOIN Detalle_producto dp ON p.detalle_producto_fk = dp.id;
-- consulta 43: lista de producto y su inventario
SELECT p.nombre AS producto_nombre, di.stock_actual 
FROM Producto p 
LEFT JOIN Detalle_Inventario di ON p.id = di.producto_fk;
--- consulta 44: comparar tipos 
SELECT tp.Tipo_de_pedido, COUNT(p.id) AS total_pedidos 
FROM Tipo_pedido tp 
LEFT JOIN Pedido p ON tp.id = p.tipo_pedido_fk 
GROUP BY tp.id;
-- consulta 45 : empleados con todos sus detalles
SELECT e.id AS empleado_id, e.nombre AS nombre_empleado, de.apellido, de.cedula, ce.Cargo_Nombre 
FROM Empleado e 
JOIN Detalle_empleado de ON e.detalle_empleado_fk = de.id 
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id;
-- consulta 46: resumen de las parcelas
SELECT dp.Tipo_Parcela, COUNT(p.id) AS total_parcelas 
FROM Detalle_parcela dp 
JOIN Parcela p ON dp.id = p.detalle_parcela_fk 
GROUP BY dp.Tipo_Parcela;
--consulta 47: detalle venta y lugar
SELECT dv.id AS detalle_venta_id, u.barrio, u.direccion 
FROM Detalle_venta dv 
JOIN ubicacion u ON dv.ubicacion_fk = u.id;
--consulta 48: resumen de ventas por producto 
SELECT p.nombre AS producto_nombre, COUNT(dv.id) AS total_ventas 
FROM Producto p 
JOIN Detalle_venta dv ON dv.producto_fk = p.id 
GROUP BY p.id;
-- consulta 49 : compradores y productos vendidos
SELECT c.nombre AS cliente_nombre, p.nombre AS producto_nombre 
FROM Cliente c 
JOIN Detalle_venta dv ON c.id = dv.cliente_fk 
JOIN Producto p ON dv.producto_fk = p.id;
-- consulta 50 : empleado que gestiono venta
SELECT e.nombre AS empleado_nombre, c.id AS compra_id, dc.descripcion 
FROM Compra c 
JOIN Detalle_compra dc ON c.Detalle_compra_fk = dc.id 
JOIN Empleado e ON dc.empleado_fk = e.id;
-- consulta 51 stock maximo por almacen
SELECT a.Descrision AS almacen_descripcion, da.Can_Productos_max 
FROM Almacen a 
JOIN Detalle_almacen da ON a.Detalle_almacen_FK = da.id;
-- consulta 52 total clientes registrados
SELECT COUNT(*) AS total_clientes FROM Cliente;
-- consulta 53 todos lo producto disponible y su stock
SELECT p.nombre AS producto_nombre, di.stock_actual 
FROM Producto p 
LEFT JOIN Detalle_Inventario di ON p.id = di.producto_fk;
-- consulta 54 resumen de ventas
SELECT tp.Tipo_de_pedido, COUNT(p.id) AS total_pedidos 
FROM Tipo_pedido tp 
LEFT JOIN Pedido p ON tp.id = p.tipo_pedido_fk 
GROUP BY tp.id;
-- consulta 55 listar productos organicos
SELECT p.nombre AS producto_nombre 
FROM Producto p 
JOIN Tipo_producto tp ON p.tipo_producto_fk = tp.id 
WHERE tp.organicos = 'Sí';
-- consulta 56 ver a quien estan dirigidos los pedidos 
SELECT dp.descripcion, c.nombre AS cliente_nombre 
FROM Detalle_pedido dp 
JOIN Cliente c ON dp.cliente_fk = c.id;
-- consulta 57 listar producto y sus caracteristicas
SELECT tp.id AS tipo_producto_id, tp.Liquido, tp.solido, tp.comestible, tp.organicos 
FROM Tipo_producto tp;
-- consulta 58 gestion de comprass
SELECT c.id AS compra_id, e.nombre AS empleado_nombre 
FROM Compra c 
JOIN Detalle_compra dc ON c.Detalle_compra_fk = dc.id 
JOIN Empleado e ON dc.empleado_fk = e.id;
-- consulta 59 empleados por cargo
SELECT ce.Cargo_Nombre, COUNT(e.id) AS total_empleados 
FROM Empleado e 
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id 
GROUP BY ce.Cargo_Nombre;
-- consulta 60 ventas por zona espesifica
SELECT v.id AS venta_id, v.nombre AS venta_nombre, u.barrio 
FROM Venta v 
JOIN Detalle_venta dv ON v.detalle_venta_fk = dv.id 
JOIN ubicacion u ON dv.ubicacion_fk = u.id 
WHERE u.barrio = 'Barrio Norte'; 

-- consulta 61
SELECT 
    p.nombre AS producto, 
    v.id AS venta, 
    c.nombre AS cliente, 
    dp.descripcion
FROM Detalle_pedido dp
JOIN Producto p ON dp.producto_fk = p.id
JOIN Venta v ON dp.venta_fk = v.id
JOIN Cliente c ON dp.cliente_fk = c.id
LIMIT 10;
-- consulta 62
SELECT 
    p.nombre AS parcela, 
    dp.tamaño AS tamaño, 
    dp.Tipo_Parcela AS tipo, 
    u.barrio, 
    u.direccion, 
    c.nombre AS ciudad
FROM Parcela p
JOIN Detalle_parcela dp ON p.detalle_parcela_fk = dp.id
JOIN ubicacion u ON dp.ubicacion_fk = u.id
JOIN Ciudad c ON u.ciudad_fk = c.id
LIMIT 10;
-- consulta 63 
SELECT 
    a.Descrision AS almacen, 
    dp.nombre AS producto, 
    di.stock_actual AS stock, 
    di.fecha
FROM Inventario i
JOIN Detalle_Inventario di ON i.Detalle_Inventario_fk = di.id
JOIN Producto dp ON di.producto_fk = dp.id
JOIN Almacen a ON di.Almacen_fk = a.id
LIMIT 10;
--- consulta 64
SELECT 
    e.nombre AS empleado, 
    ce.Cargo_Nombre AS cargo, 
    p.nombre AS parcela
FROM Empleado e
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id
JOIN Parcela p ON p.empleado_parcela_fk = e.id
LIMIT 10;
--- consulta 65
SELECT 
    prov.nombre AS proveedor, 
    dp.valor AS precio, 
    p.nombre AS producto
FROM Proveedor prov
JOIN Detalle_producto dp ON prov.id = dp.Proveedor_fk
JOIN Producto p ON dp.id = p.detalle_producto_fk
LIMIT;

-- consulta 66
SELECT pr.nombre AS proveedor_nombre, dp.cedula, dp.Telefono, dp.Email, u.barrio, u.direccion 
FROM Proveedor pr 
JOIN Detalle_proveedor dp ON pr.detalle_proveedor_fk = dp.id 
JOIN ubicacion u ON dp.ubicacion_fk = u.id;

-- consulta 67
SELECT * FROM Tipo_producto;
-- consulta 68
SELECT e.nombre AS empleado_nombre, ce.Cargo_Nombre, ce.sueldo 
FROM Empleado e 
JOIN Cargo_empleado ce ON e.cargo_empleado_fk = ce.id;
-- consulta 69
SELECT v.id AS venta_id, c.nombre AS cliente_nombre, COUNT(dv.id) AS total_ventas 
FROM Venta v 
JOIN Detalle_venta dv ON v.detalle_venta_fk = dv.id 
JOIN Cliente c ON dv.cliente_fk = c.id
GROUP BY v.id;
-- consulta 70
SELECT DISTINCT Tipo_de_pedido FROM Tipo_pedido;
-- consulta 71
SELECT p.nombre AS producto_nombre, prov.nombre AS proveedor_nombre 
FROM Producto p 
JOIN Detalle_producto dp ON p.detalle_producto_fk = dp.id 
JOIN Proveedor prov ON dp.Proveedor_fk = prov.id;
-- consulta 72
SELECT pa.nombre AS parcela_nombre, e.nombre AS empleado_nombre 
FROM Parcela pa 
LEFT JOIN Empleado e ON pa.empleado_parcela_fk = e.id;
-- consulta 73
SELECT * FROM ubicacion WHERE id = 1;
-- consulta 74
SELECT p.nombre AS producto_nombre 
FROM Producto p 
JOIN Tipo_producto tp ON p.tipo_producto_fk = tp.id 
WHERE tp.Liquido = 'Sí';
-- consulta 75
SELECT p.nombre AS producto_nombre 
FROM Producto p 
JOIN Tipo_producto tp ON p.tipo_producto_fk = tp.id 
WHERE tp.Liquido = 'No';
-- consulta 76
SELECT v.nombre AS venta_nombre, p.nombre AS producto_nombre 
FROM Venta v 
JOIN Detalle_venta dv ON v.detalle_venta_fk = dv.id 
JOIN Producto p ON dv.producto_fk = p.id;
-- consulta 77
SELECT p.nombre AS producto_nombre, dp.valor 
FROM Producto p 
JOIN Detalle_producto dp ON p.detalle_producto_fk = dp.id 
WHERE dp.valor < 50;
-- consulta 78
SELECT ce.Cargo_Nombre, COUNT(e.id) AS total_empleados 
FROM Cargo_empleado ce 
LEFT JOIN Empleado e ON ce.id = e.cargo_empleado_fk 
GROUP BY ce.Cargo_Nombre;
-- consulta 79
SELECT p.nombre AS nombre_pedido, tp.Clasificacion 
FROM Pedido p 
JOIN Tipo_pedido tp ON p.tipo_pedido_fk = tp.id;
-- consulta 80
SELECT 
    p.nombre AS nombre_pedido, 
    c.nombre AS cliente_nombre, 
    u.barrio, 
    u.direccion 
FROM Pedido p 
JOIN Detalle_pedido dp ON p.detalle_pedido_fk = dp.id 
JOIN Cliente c ON dp.cliente_fk = c.id 
JOIN ubicacion u ON c.detalle_cliente_fk = u.ciudad_fk;
--- subconsultas 


-- subconsulta 1 :listar pedidos urgestes y que son a domicilios
SELECT nombre
FROM Pedido
WHERE tipo_pedido_fk IN (
    SELECT id
    FROM Tipo_pedido
    WHERE Tipo_de_pedido = 'A domicilio' AND Clasificacion = 'Urgente'
);
-- subconsulta 2 : obtener detalles que a un superar un cierto valor
SELECT *
FROM Venta
WHERE detalle_venta_fk IN (
    SELECT id
    FROM Detalle_venta
    WHERE producto_fk IN (
        SELECT id
        FROM Producto
        WHERE detalle_producto_fk IN (
            SELECT id
            FROM Detalle_producto
            WHERE valor > 100.00 
        )
    )
);
-- subconsulta 3 : empleados que ganan mas que el promedio
SELECT e.nombre
FROM Empleado e
WHERE e.cargo_empleado_fk IN (
    SELECT id
    FROM Cargo_empleado
    WHERE sueldo > (
        SELECT AVG(sueldo) FROM Cargo_empleado
    )
);
-- subconsulta 4 : provedores que suministran productos liquidos
SELECT DISTINCT p.nombre
FROM Proveedor p
JOIN Detalle_producto dp ON p.id = dp.Proveedor_fk
JOIN Producto pr ON dp.id = pr.detalle_producto_fk
WHERE pr.tipo_producto_fk IN (
    SELECT id
    FROM Tipo_producto
    WHERE Liquido = 'Sí'
);
-- subconsulta 5 : provedores que no suministran productos liquidos
SELECT DISTINCT p.nombre
FROM Proveedor p
JOIN Detalle_producto dp ON p.id = dp.Proveedor_fk
JOIN Producto pr ON dp.id = pr.detalle_producto_fk
WHERE pr.tipo_producto_fk IN (
    SELECT id
    FROM Tipo_producto
    WHERE Liquido = 'No'
);
--- subconsulta 6 : parcelas que son mas grandes que el promedio
SELECT nombre
FROM Parcela
WHERE detalle_parcela_fk IN (
    SELECT id
    FROM Detalle_parcela
    WHERE tamaño > (
        SELECT AVG(CAST(tamaño AS SIGNED))
        FROM Detalle_parcela
    )
);
-- subconsulta 7 : productos que su stock menor al promedio
SELECT p.nombre
FROM Producto p
WHERE p.id IN (
    SELECT di.producto_fk
    FROM Detalle_Inventario di
    GROUP BY di.producto_fk
    HAVING SUM(di.stock_actual) < (
        SELECT AVG(stock_actual)
        FROM Detalle_Inventario
    )
);
-- subconsulta 8 : provedores que venden productos menor al promedio
SELECT p.nombre
FROM Proveedor p
WHERE p.id IN (
    SELECT dp.Proveedor_fk
    FROM Detalle_producto dp
    WHERE dp.valor < (
        SELECT AVG(valor)
        FROM Detalle_producto
    )
);
-- subconsulta 9 : informacion de todo los pedidos urgentes
SELECT pd.nombre
FROM Pedido pd
WHERE pd.tipo_pedido_fk IN (
    SELECT id
    FROM Tipo_pedido
    WHERE Clasificacion = 'Urgente'
);
-- subconsulta 10 : informacion de todos lo pedidos regulares
SELECT *
FROM Pedido
WHERE tipo_pedido_fk IN (
    SELECT id
    FROM Tipo_pedido
    WHERE Clasificacion = 'Regular'
);
-- subconsulta 11:
SELECT p.nombre 
FROM Producto p 
WHERE p.detalle_producto_fk IN (
    SELECT id 
    FROM Detalle_producto 
    WHERE valor > (
        SELECT AVG(valor) 
        FROM Detalle_producto
    )
);
-- subconsulta 12.
SELECT c.nombre 
FROM Cliente c 
WHERE c.id IN (
    SELECT cliente_fk 
    FROM Compra 
    GROUP BY cliente_fk 
    HAVING COUNT(*) > 2
);
-- subconsulta 13:
SELECT e.nombre 
FROM Empleado e 
WHERE e.cargo_empleado_fk IN (
    SELECT id 
    FROM Cargo_empleado 
    WHERE sueldo > (
        SELECT AVG(sueldo) 
        FROM Cargo_empleado
    )
);
-- subconsulta 14:
SELECT p.nombre 
FROM Proveedor p 
WHERE p.id NOT IN (
    SELECT Proveedor_fk 
    FROM Detalle_producto
);
-- subconsulta 15:
SELECT nombre 
FROM Parcela 
WHERE detalle_parcela_fk IN (
    SELECT id 
    FROM Detalle_parcela 
    WHERE tamaño > (
        SELECT AVG(tamaño) 
        FROM Detalle_parcela
    )
);
-- subconsulta 16:
SELECT * 
FROM Detalle_venta 
WHERE precio > (
    SELECT AVG(precio) FROM Detalle_venta
);
-- subconsulta 17:
SELECT DISTINCT c.nombre 
FROM Cliente c 
JOIN Detalle_pedido dp ON c.id = dp.cliente_fk 
JOIN Producto p ON dp.producto_fk = p.id 
WHERE p.tipo_producto_fk IN (
    SELECT id FROM Tipo_producto WHERE organicos = 'Sí'
);
-- subconsulta 18:
SELECT dc.descripcion 
FROM Detalle_compra dc 
WHERE dc.producto_fk IN (
    SELECT id 
    FROM Producto 
    WHERE nombre = 'Producto 1'
);
-- subconsulta 19:

SELECT p.nombre 
FROM Parcela p 
WHERE p.detalle_parcela_fk IN (
    SELECT id 
    FROM Detalle_parcela 
    WHERE ubicacion_fk IN (
        SELECT u.id 
        FROM ubicacion u 
        JOIN Empleado e ON u.id = e.detalle_empleado_fk 
        GROUP BY u.id 
        HAVING COUNT(e.id) > 5
    )
);
-- subconsulta 20:
SELECT DISTINCT prov.nombre 
FROM Proveedor prov 
WHERE prov.id IN (
    SELECT dp.Proveedor_fk 
    FROM Detalle_producto dp 
    WHERE dp.id IN (
        SELECT p.tipo_producto_fk 
        FROM Producto p 
        WHERE p.tipo_producto_fk IN (
            SELECT id 
            FROM Tipo_producto 
            WHERE comestible = 'No'
        )
    )
);
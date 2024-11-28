
-- funcion 1 costo operativo
DELIMITER $$
CREATE FUNCTION costo_operativo_total(fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(valor), 0) INTO total 
    FROM Detalle_compra 
    WHERE fecha_Compra BETWEEN fecha_inicio AND fecha_fin;
    RETURN total;
END $$
DELIMITER ;
SELECT costo_operativo_total('2023-01-01', '2023-12-31') AS total_costo_operativo;

-- funcion 2 rendimiento promedio de parcela
DELIMITER $$
CREATE FUNCTION rendimiento_promedio(tipo_parcela VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(tamaño), 0) INTO promedio 
    FROM Detalle_parcela 
    WHERE Tipo_Parcela = tipo_parcela;
    RETURN promedio;
END $$
DELIMITER ;
SELECT rendimiento_promedio('Cultivo A') AS rendimiento_promedio;

--funcion 3
DELIMITER $$
CREATE FUNCTION total_ventas_cliente2(cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(precio), 0) INTO total 
    FROM Detalle_venta 
    WHERE cliente_fk = cliente_id;
    RETURN total;
END $$
DELIMITER ;
SELECT total_ventas_cliente2(2) AS total_ventas;

-- funcion 4
DELIMITER $$
CREATE FUNCTION stock_disponible(producto_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock INT;
    SELECT IFNULL(SUM(stock_actual), 0) INTO stock 
    FROM Detalle_Inventario 
    WHERE producto_fk = producto_id;
    RETURN stock;
END $$
DELIMITER ;
SELECT stock_disponible(1) AS stock_producto;

-- funcion 5
DELIMITER $$
CREATE FUNCTION promedio_horas_trabajo(empleado_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(Horas_Trabajo), 0) INTO promedio 
    FROM Cargo_empleado 
    JOIN Empleado ON Cargo_empleado.id = Empleado.cargo_empleado_fk  
    WHERE Empleado.id = empleado_id;
    RETURN promedio;
END $$
DELIMITER ;
SELECT promedio_horas_trabajo(1) AS promedio_horas;

-- funcion 6
DELIMITER $$
CREATE FUNCTION precio_promedio_producto(proveedor_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(valor), 0) INTO promedio 
    FROM Detalle_producto 
    WHERE Proveedor_fk = proveedor_id;
    RETURN promedio;
END $$
DELIMITER ;
SELECT precio_promedio_producto(1) AS precio_promedio;

-- funcion 7    
DELIMITER $$
CREATE FUNCTION total_compras() 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(valor), 0) INTO total 
    FROM Detalle_compra;
    RETURN total;
END $$
DELIMITER ;
SELECT total_compras() AS total_compras;

--funcion 8 
DELIMITER $$
CREATE FUNCTION costo_total_pedido2(venta_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(valor), 0) INTO total 
    FROM Detalle_pedido 
    WHERE venta_fk = venta_id;  
    RETURN total;
END $$
DELIMITER ;
SELECT costo_total_pedido2(1) AS total_costo_pedido;

-- funcion 9
DELIMITER $$
CREATE FUNCTION stock_promedio_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(di.stock_actual), 0) INTO promedio
    FROM Detalle_Inventario di;
    RETURN promedio;
END $$
DELIMITER ;
SELECT stock_promedio_productos() AS stock_promedio;

--funcion 10
DELIMITER $$
CREATE FUNCTION total_pedidos_por_cliente(cliente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Detalle_pedido
    WHERE cliente_fk = cliente_id;
    RETURN total;
END $$
DELIMITER ;
SELECT total_pedidos_por_cliente(1) AS total_pedidos;

--funcion 11
DELIMITER $$
CREATE FUNCTION costo_promedio_hectarea()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(valor), 0) INTO promedio 
    FROM Detalle_compra;
    RETURN promedio;
END $$
DELIMITER ;
SELECT costo_promedio_hectarea() AS costo_promedio_hectarea;

--funcion 12
DELIMITER $$
CREATE FUNCTION rendimiento_total_inventario()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT IFNULL(SUM(stock_actual * valor), 0) INTO total 
    FROM Detalle_Inventario 
    JOIN Detalle_producto ON Detalle_Inventario.producto_fk = Detalle_producto.id;
    RETURN total;
END $$
DELIMITER ;
SELECT rendimiento_total_inventario() AS rendimiento_total_inventario;

-- funcion 13
DELIMITER $$
CREATE FUNCTION cantidad_pedidos_cliente(cliente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT IFNULL(COUNT(*), 0) INTO cantidad 
    FROM Detalle_pedido 
    WHERE cliente_fk = cliente_id;
    RETURN cantidad;
END $$
DELIMITER ;
SELECT cantidad_pedidos_cliente(1) AS cantidad_pedidos;

-- funcion 14
DELIMITER $$
CREATE FUNCTION total_productos_tipo(tipo_producto_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM Producto 
    WHERE tipo_producto_fk = tipo_producto_id;
    RETURN total;
END $$
DELIMITER ;
SELECT total_productos_tipo(1) AS total_productos;

--funcion 15
DELIMITER $$
CREATE FUNCTION costo_total_ventas_cliente(cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(precio_total) INTO total 
    FROM Detalle_venta 
    WHERE cliente_fk = cliente_id;
    RETURN total;
END $$
DELIMITER ;
SELECT costo_total_ventas_cliente(1) AS ingresos_totales;  

-- funcion 16
DELIMITER $$
CREATE FUNCTION total_proveedores_por_ubicacion(ubicacion_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(DISTINCT(p.id)) INTO cantidad
    FROM Proveedor p
    JOIN Detalle_proveedor dp ON p.detalle_proveedor_fk = dp.id
    WHERE dp.ubicacion_fk = ubicacion_id;
    RETURN cantidad;
END $$
DELIMITER ;
SELECT total_proveedores_por_ubicacion(1) AS total_proveedores;

--funcion 17
DELIMITER $$
CREATE FUNCTION total_empleados_por_cargo(cargo_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM Empleado 
    WHERE cargo_empleado_fk = cargo_id;
    RETURN total;
END $$
DELIMITER ;
SELECT total_empleados_por_cargo(1) AS total_empleados;

--funcion 18
DELIMITER $$
CREATE FUNCTION cantidad_productos_almacen(almacen_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(stock_actual) INTO total 
    FROM Detalle_Inventario 
    WHERE Almacen_fk = almacen_id;
    RETURN total;
END $$
DELIMITER ;
SELECT cantidad_productos_almacen(1) AS cantidad_productos;

-- funcion 19
DELIMITER $$
CREATE FUNCTION rentabilidad_producto(producto_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE ingresos DECIMAL(10, 2);
    DECLARE costos DECIMAL(10, 2);
    SELECT IFNULL(SUM(dv.precio), 0) INTO ingresos
    FROM Detalle_venta dv
    WHERE dv.producto_fk = producto_id;
    SELECT IFNULL(SUM(dc.valor), 0) INTO costos
    FROM Detalle_compra dc
    WHERE dc.producto_fk = producto_id;

    RETURN (ingresos - costos);
END $$
DELIMITER ;
SELECT rentabilidad_producto(1) AS rentabilidad; 

-- funcion 20
DELIMITER $$
CREATE FUNCTION cantidad_productos_por_tipo(tipo_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Producto p
    WHERE p.tipo_producto_fk = tipo_id;
    RETURN total;
END $$
DELIMITER ;
SELECT cantidad_productos_por_tipo(1) AS cantidad_productos;  



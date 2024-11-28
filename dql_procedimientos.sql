```sql
# Procedimiento 1 registrar venta
DELIMITER $
CREATE PROCEDURE RegistrarVenta (
    IN clienteId INT,
    IN productoId INT,
    IN cantidad INT,
    OUT total DECIMAL(10, 2)
)
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
END $
DELIMITER ;
CALL RegistrarVenta(1, 2, 5, @total);
SELECT  * FROM Detalle_venta;
# Procedimiento 2 : registrar provedor
DELIMITER $
CREATE PROCEDURE RegistrarProveedor (
    IN nombre VARCHAR(50),
    IN cedula INT,
    IN telefono VARCHAR(50),
    IN email VARCHAR(50)
)
BEGIN
    INSERT INTO Detalle_proveedor (cedula, Telefono, Email) VALUES (cedula, telefono, email);
    SET @ultimo_id = LAST_INSERT_ID();
    INSERT INTO Proveedor (nombre, detalle_proveedor_fk) VALUES (nombre, @ultimo_id);
END $
DELIMITER ;
CALL RegistrarProveedor('Proveedor XYZ', 123456, '555-1234', 'proveedor@ejemplo.com');
SELECT * FROM Proveedor;
SELECT * FROM Detalle_proveedor;
# procedimiento 3 : registrar empleado
DELIMITER $
CREATE PROCEDURE RegistrarEmpleado (
    IN nombre VARCHAR(50),
    IN apellido VARCHAR(50),
    IN cedula VARCHAR(50),
    IN correo VARCHAR(50),
    IN cargoId INT
)
BEGIN
    INSERT INTO Detalle_empleado (apellido, cedula, Correo) VALUES (apellido, cedula, correo);
    SET @detalle_id = LAST_INSERT_ID();
    INSERT INTO Empleado (nombre, detalle_empleado_fk, cargo_empleado_fk) VALUES (nombre, @detalle_id, cargoId);
END $
DELIMITER ;
CALL RegistrarEmpleado('Juan', 'Pérez', '123456789', 'juan.p@example.com', 1); 
SELECT * FROM Detalle_empleado;
# procedimiento 4 : actualizar inventario
DELIMITER $
CREATE PROCEDURE ActualizarInventario (
    IN productoId INT,
    IN cantidad INT
)
BEGIN
    UPDATE Detalle_Inventario
    SET stock_actual = stock_actual + cantidad
    WHERE producto_fk = productoId;
END $
DELIMITER ;
CALL ActualizarInventario(2, 10);
SELECT  * FROM Detalle_Inventario;
# procedimiento 5: registrar un nuevo tipo producto
DELIMITER $
CREATE PROCEDURE RegistrarTipoProducto (
    IN liquido ENUM('Sí', 'No'),
    IN solido ENUM('Sí', 'No'),
    IN comestible ENUM('Sí', 'No'),
    IN organicos ENUM('Sí', 'No')
)
BEGIN
    INSERT INTO Tipo_producto (Liquido, solido, comestible, organicos) VALUES (liquido, solido, comestible, organicos);
END $
DELIMITER ;
CALL RegistrarTipoProducto('Sí','No','Sí','Sí');
SELECT * FROM Tipo_producto;
# procedimiento 6: registrar un nuevo pedido
DELIMITER $
CREATE PROCEDURE RegistrarPedido (
    IN nombre VARCHAR(50),
    IN tipoPedidoId INT,
    IN detallePedidoId INT
)
BEGIN
    INSERT INTO Pedido (nombre, tipo_pedido_fk, detalle_pedido_fk) VALUES (nombre, tipoPedidoId, detallePedidoId);
END $
DELIMITER ;
CALL RegistrarPedido('Pedido de prueba', 1, 1);
SELECT * FROM Pedido;
# procedimiento 7: actualizar el estado de una venta
DELIMITER $
CREATE PROCEDURE ActualizarEstadoVenta (
    IN ventaId INT,
    IN estado ENUM('Completada', 'Cancelada')
)
BEGIN
    UPDATE Venta
    SET nombre = estado
    WHERE id = ventaId;
END $
DELIMITER ;
CALL ActualizarEstadoVenta(1, 'Completada');
SELECT * FROM Venta;
# procedimiento 8 : RegistrarCompra
DELIMITER $
CREATE PROCEDURE RegistrarCompra (
    IN empleadoId INT,
    IN descripcion VARCHAR(255),
    IN productoId INT
)
BEGIN
    INSERT INTO Detalle_compra (descripcion, producto_fk, empleado_fk) VALUES (descripcion, productoId, empleadoId);
END $
DELIMITER ;
CALL RegistrarCompra(1, 'Compra de insumos', 2);
SELECT * FROM Detalle_compra;
# procedimiento 9: obtener venta mas reciente
DELIMITER $
CREATE PROCEDURE ObtenerVentaMasReciente (OUT ventaId INT)
BEGIN
    SELECT id INTO ventaId
    FROM Venta
    ORDER BY id DESC
    LIMIT 1;
END $
DELIMITER ;
CALL ObtenerVentaMasReciente(@ventaId);
SELECT @ventaId AS UltimaVenta;
# procedimiento 10: actualiazar clientes
DELIMITER $
CREATE PROCEDURE ActualizarCliente (
    IN clienteId INT,
    IN nombre VARCHAR(50),
    IN apellido VARCHAR(50),
    IN cedula INT
)
BEGIN
    UPDATE Detalle_cliente
    SET apellido = apellido,
        cedula = cedula
    WHERE id = clienteId;
    
    UPDATE Cliente
    SET nombre = nombre
    WHERE detalle_cliente_fk = clienteId;
END $
DELIMITER ;
CALL ActualizarCliente(1, 'Carlos', 'López', 987654);
SELECT * FROM Detalle_cliente;
SELECT * FROM Cliente;
# procedimiento 11: registrar tipo pedido
DELIMITER $
CREATE PROCEDURE RegistrarTipoPedido (
    IN tipoDePedido ENUM('En tienda', 'A domicilio', 'En línea', 'Especial'),
    IN clasificacion ENUM('Urgente', 'Programado', 'Regular'),
    IN prioridad INT
)
BEGIN
    INSERT INTO Tipo_pedido (Tipo_de_pedido, Clasificacion, prioridad) VALUES (tipoDePedido, clasificacion, prioridad);
END $
DELIMITER ;
CALL RegistrarTipoPedido('En línea', 'Urgente', 1);
SELECT * FROM Tipo_pedido;
# procedimiento 12: ActualizarProveedor
DELIMITER $
CREATE PROCEDURE ActualizarProveedor (
    IN proveedorId INT,
    IN telefono VARCHAR(50),
    IN email VARCHAR(50)
)
BEGIN
    UPDATE Detalle_proveedor
    SET Telefono = telefono, Email = email
    WHERE id = proveedorId;
END $
DELIMITER ;
CALL ActualizarProveedor(1, '555-9876', 'nuevoemail@ejemplo.com');
SELECT * FROM Detalle_proveedor;
# procedimiento 13: ContarProductosEnInventario 
DELIMITER $
CREATE PROCEDURE ContarProductosEnInventario (OUT totalProductos INT)
BEGIN
    SELECT SUM(stock_actual) INTO totalProductos FROM Detalle_Inventario;
END $
DELIMITER ;
CALL ContarProductosEnInventario(@totalProductos); 
SELECT @totalProductos AS TotalEnInventario; 
# procedimiento 14: ActualizarPrecioProducto
DELIMITER $
CREATE PROCEDURE ActualizarPrecioProducto (
    IN productoId INT,
    IN nuevoValor DECIMAL(10, 2)
)
BEGIN
    UPDATE Detalle_producto
    SET valor = nuevoValor
    WHERE id = productoId;
END $
DELIMITER ;
CALL ActualizarPrecioProducto(1, 150.00); 
SELECT * FROM Detalle_producto;
# procedimiento 15: 
DELIMITER $
CREATE PROCEDURE RegistrarCliente (
    IN nombre VARCHAR(50),
    IN apellido VARCHAR(50),
    IN cedula INT
)
BEGIN
    INSERT INTO Detalle_cliente (apellido, cedula) VALUES (apellido, cedula);
    SET @detalle_cliente_id = LAST_INSERT_ID();
    INSERT INTO Cliente (nombre, detalle_cliente_fk) VALUES (nombre, @detalle_cliente_id);
END $
DELIMITER ;
CALL RegistrarCliente('Ana', 'Martínez', 123456); 
SELECT * FROM Detalle_cliente;
SELECT * FROM Cliente;
# procedimiento 16
DELIMITER $
CREATE PROCEDURE RegistrarMantenimiento (
    IN maquinariaId INT,
    IN descripcion VARCHAR(255),
    IN fechaMantenimiento DATETIME
)
BEGIN
    INSERT INTO Mantenimiento (maquinaria_fk, descripcion, fecha)
    VALUES (maquinariaId, descripcion, fechaMantenimiento);
END $
DELIMITER ;
CALL RegistrarMantenimiento(1, 'Cambio de aceites y filtros', NOW());
# procedimiento 17:
DELIMITER $
CREATE PROCEDURE ObtenerProductosPorProveedor (
    IN proveedorId INT
)
BEGIN
    SELECT p.nombre
    FROM Producto p
    WHERE p.detalle_producto_fk IN (
        SELECT dp.id
        FROM Detalle_producto dp
        WHERE dp.Proveedor_fk = proveedorId
    );
END $
DELIMITER ;
CALL ObtenerProductosPorProveedor(2); -
# procedimiento 18:
DELIMITER $
CREATE PROCEDURE EliminarProducto (
    IN productoId INT
)
BEGIN
    DELETE FROM Detalle_Inventario
    WHERE producto_fk = productoId;
    
    DELETE FROM Producto
    WHERE id = productoId;
END $
DELIMITER ;
CALL EliminarProducto(3); -- 3 es el ID del producto que deseas eliminar.
# procedimiento 19:
DELIMITER $
CREATE PROCEDURE ActualizarCargoEmpleado (
    IN empleadoId INT,
    IN nuevoCargoId INT
)
BEGIN
    UPDATE Empleado
    SET cargo_empleado_fk = nuevoCargoId
    WHERE id = empleadoId;
END $
DELIMITER ;
CALL ActualizarCargoEmpleado(1, 2); -- 1 es el ID del empleado y 2 es el nuevo ID de cargo.
#procedimieno 20:
DELIMITER $
CREATE PROCEDURE EliminarCliente (
    IN clienteId INT
)
BEGIN
    DELETE FROM Cliente
    WHERE detalle_cliente_fk = clienteId;

    DELETE FROM Detalle_cliente
    WHERE id = clienteId;
END $
DELIMITER ;
CALL EliminarCliente(1); -- 1 es el ID del cliente a eliminar.
```




-- triguer 1
DELIMITER $$
CREATE TRIGGER actualizar_inventario_al_insertar_venta
AFTER INSERT ON Detalle_venta
FOR EACH ROW
BEGIN
    UPDATE Detalle_Inventario
    SET stock_actual = stock_actual¿
    WHERE producto_fk = NEW.producto_fk;
END $$
DELIMITER ;
-- triger 2
DELIMITER $$
CREATE TRIGGER registrar_cambio_salario
AFTER UPDATE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO Historial_salario(empleado_id, salario_anterior, salario_nuevo, fecha_cambio)
    VALUES (NEW.id, NOW());
END $$
DELIMITER ;
-- triger 3
DELIMITER $$
CREATE TRIGGER verificar_disponibilidad_producto
BEFORE INSERT ON Detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE cantidad_disponible INT;
    SELECT stock_actual INTO cantidad_disponible
    FROM Detalle_Inventario
    WHERE producto_fk = NEW.producto_fk;

    IF cantidad_disponible < NEW.valor THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para el producto';
    END IF;
END $$
DELIMITER ;
-- triger 4
DELIMITER $$
CREATE TRIGGER registrar_historial_compra
AFTER INSERT ON Compra
FOR EACH ROW
BEGIN
    INSERT INTO Historial_compras(cliente_fk, detalle_compra_fk, fecha_compra)
    VALUES (NEW.cliente_fk, NEW.Detalle_compra_fk, NOW());
END $$
DELIMITER ;

-- triger 5

DELIMITER $$
CREATE TRIGGER ajustar_stock_al_eliminar_venta
AFTER DELETE ON Detalle_venta
FOR EACH ROW
BEGIN
    UPDATE Detalle_Inventario
    SET stock_actual = stock_actual + 1  
    WHERE producto_fk = OLD.producto_fk;
END $$
DELIMITER ;
-- triger 6

DELIMITER $$
CREATE TRIGGER marcar_proveedor_inactivo
BEFORE DELETE ON Proveedor
FOR EACH ROW
BEGIN
    UPDATE Proveedor
    SET activo = 'No' 
    WHERE id = OLD.id;
END $$
DELIMITER ;

-- triger 7
DELIMITER $$
CREATE TRIGGER actualizar_total_pedido
AFTER INSERT ON Detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE Pedido
    SET total = total + NEW.valor
    WHERE id = NEW.venta_fk; 
END $$
DELIMITER ;

-- triger 8

DELIMITER $$
CREATE TRIGGER actualizar_fecha_ultima_venta
AFTER INSERT ON Detalle_venta
FOR EACH ROW
BEGIN
    UPDATE Producto
    SET fecha_ultima_venta = NOW()
    WHERE id = NEW.producto_fk;
END $$
DELIMITER ;

-- triger 9

DELIMITER $$
CREATE TRIGGER controlar_cambio_ubicacion
BEFORE UPDATE ON ubicacion
FOR EACH ROW
BEGIN
    IF NEW.direccion IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La dirección no puede ser NULL.';
    END IF;
END $$
DELIMITER ;


-- triger 10

DELIMITER $$
CREATE TRIGGER inicializar_stock_producto
AFTER INSERT ON Producto
FOR EACH ROW
BEGIN
    INSERT INTO Detalle_Inventario(producto_fk, stock_actual)
    VALUES (NEW.id, 0);
END $$
DELIMITER ;

-- triger 11

DELIMITER $$
CREATE TRIGGER eliminar_detalles_producto_al_eliminar_compra
AFTER DELETE ON Compra
FOR EACH ROW
BEGIN
    DELETE FROM Detalle_compra
    WHERE Detalle_compra_fk = OLD.id;
END $$
DELIMITER ;

-- triger 12

DELIMITER $$
CREATE TRIGGER registrar_cambio_cliente
AFTER UPDATE ON Detalle_cliente
FOR EACH ROW
BEGIN
    INSERT INTO Historial_cliente(cliente_id, campo_cambiado, valor_anterior, valor_nuevo, fecha)
    VALUES (OLD.id, 'detalle', OLD.apellido, NEW.apellido, NOW());
END $$
DELIMITER ;

-- triger 13

DELIMITER $$
CREATE TRIGGER aumentar_stock_al_eliminar_producto
AFTER DELETE ON Producto
FOR EACH ROW
BEGIN
    DELETE FROM Detalle_Inventario
    WHERE producto_fk = OLD.id; 
END $$
DELIMITER ;

-- triger 14
 
DELIMITER $$
CREATE TRIGGER registrar_cambio_tipo_producto
AFTER UPDATE ON Tipo_producto
FOR EACH ROW
BEGIN
    INSERT INTO Historial_tipo_producto(tipo_producto_id, campo_cambiado, valor_anterior, valor_nuevo, fecha)
    VALUES (OLD.id, 'tipo', OLD.Liquido, NEW.Liquido, NOW());
END $$
DELIMITER ;

-- triger 15

DELIMITER $$
CREATE TRIGGER aumentar_precio_producto
AFTER UPDATE ON Tipo_producto
FOR EACH ROW
BEGIN
    UPDATE Detalle_producto
    SET valor = valor * 1.10 
    WHERE tipo_producto_fk = OLD.id;
END $$
DELIMITER ;

-- triger 16

ALTER TABLE Detalle_pedido ADD COLUMN cantidad INT NOT NULL;
DELIMITER $$
CREATE TRIGGER verificar_cantidad_al_crear_orden
BEFORE INSERT ON Detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;

    SELECT stock_actual INTO stock_disponible
    FROM Detalle_Inventario
    WHERE producto_fk = NEW.producto_fk;
    IF NEW.cantidad > stock_disponible THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cantidad solicitada excede el stock disponible';
    END IF;
END $$
DELIMITER ;

-- triger 17

DELIMITER $$
CREATE TRIGGER ajustar_total_pedido
AFTER INSERT ON Detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE Pedido
    SET total = total + NEW.valor
    WHERE id = NEW.venta_fk; 
END $$
DELIMITER ;


-- triger 18

ALTER TABLE Detalle_venta ADD COLUMN cantidad INT NOT NULL;

DELIMITER $$
CREATE TRIGGER comprobar_stock_despues_de_venta
BEFORE INSERT ON Detalle_venta
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    SELECT stock_actual INTO stock_disponible
    FROM Detalle_Inventario
    WHERE producto_fk = NEW.producto_fk;
    IF NEW.cantidad > stock_disponible THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock disponible';
    END IF;
END $$
DELIMITER ;

-- triger 19
DELIMITER $$
CREATE TRIGGER eliminar_detalles_producto_al_eliminar_proveedor
AFTER DELETE ON Proveedor
FOR EACH ROW
BEGIN
    DELETE FROM Detalle_producto
    WHERE Proveedor_fk = OLD.id;  
END $$
DELIMITER ; 

-- triger 20

DELIMITER $$
CREATE TRIGGER aumentar_precio_al_activar_tipo
AFTER UPDATE ON Tipo_producto
FOR EACH ROW
BEGIN
    IF NEW.Liquido = 'Sí' THEN
        UPDATE Detalle_producto
        SET valor = valor * 1.1 
        WHERE tipo_producto_fk = OLD.id;
    END IF;
END $$
DELIMITER ;


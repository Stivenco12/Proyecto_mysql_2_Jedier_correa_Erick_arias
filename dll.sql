CREATE TABLE Pais(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50)
);

CREATE TABLE Region(
	id INT AUTO_INCREMENT PRIMARY KEY,	
	nombre VARCHAR(50),
 	pais_fk INT,
	CONSTRAINT FK_Pais_Region FOREIGN KEY (pais_fk) REFERENCES Pais(id)
);

CREATE TABLE Ciudad(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    region_fk INT,
    CONSTRAINT FK_Region_Ciudad FOREIGN KEY (region_fk) REFERENCES Region(id)
);

CREATE TABLE ubicacion(
	id INT AUTO_INCREMENT PRIMARY KEY,	
    barrio VARCHAR(50),
    direccion VARCHAR(50),
    ciudad_fk INT, 
    CONSTRAINT FK_Ciudad_Ubicacion FOREIGN KEY(ciudad_fk) REFERENCES Ciudad(id)
);

CREATE TABLE Detalle_parcela(
	id INT AUTO_INCREMENT PRIMARY KEY,	
    tamaño VARCHAR(50),
    Tipo_Parcela VARCHAR(50),
    ubicacion_fk INT,
    CONSTRAINT Fk_Ubicacion_Parcela FOREIGN KEY(ubicacion_fk) REFERENCES ubicacion(id)
);

CREATE TABLE Parcela(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    detalle_parcela_fk INT,
    empleado_parcela_fk INT,
    CONSTRAINT FK_Detalle_Parcela FOREIGN KEY(detalle_parcela_fk) REFERENCES Detalle_parcela(id)
);

CREATE TABLE Detalle_empleado(
	id INT AUTO_INCREMENT PRIMARY KEY,
    apellido VARCHAR(50),
    cedula VARCHAR(50) UNIQUE,
    Correo VARCHAR(50) UNIQUE
);

CREATE TABLE Cargo_empleado(
	id INT AUTO_INCREMENT PRIMARY KEY,
    Cargo_Nombre VARCHAR(50),
    Horas_Trabajo INT(50),
    sueldo INT(100)
);
 CREATE TABLE Empleado(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    detalle_empleado_fk INT,
    CONSTRAINT Fk_Detalle_empleado FOREIGN KEY (detalle_empleado_fk) REFERENCES Detalle_empleado(id),
    cargo_empleado_fk INT,
    CONSTRAINT Fk_Cargo_empleado FOREIGN KEY (cargo_empleado_fk) REFERENCES Cargo_empleado(id)
);
CREATE TABLE Detalle_proveedor(
	id INT AUTO_INCREMENT PRIMARY KEY,
    cedula INT(50) UNIQUE,
    Telefono VARCHAR(50) UNIQUE,
    Email VARCHAR(50) UNIQUE,
    ubicacion_fk INT,
    CONSTRAINT Fk_Ubicacion_Provedor FOREIGN KEY (ubicacion_fk) REFERENCES ubicacion(id)
);

CREATE TABLE Proveedor(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    detalle_proveedor_fk INT,
    CONSTRAINT Fk_Detalle_Proveedor FOREIGN KEY(detalle_proveedor_fk) REFERENCES Detalle_proveedor(id)
);
CREATE TABLE Detalle_producto(
	id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2),
    tamaño VARCHAR(50),
    Kilogramos VARCHAR(50),
    litros VARCHAR(50),
    Proveedor_fk INT,
    CONSTRAINT Fk_Proveedor_detalle FOREIGN KEY(Proveedor_fk) REFERENCES Proveedor(id)
);

CREATE TABLE Tipo_producto(
	id INT AUTO_INCREMENT PRIMARY KEY,
	Liquido ENUM('Sí', 'No'),
    solido ENUM('Sí', 'No'),
    comestible ENUM('Sí', 'No'),
    organicos ENUM('Sí', 'No')
);

CREATE TABLE Producto(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo_producto_fk INT,
    CONSTRAINT Fk_Tipo_producoto FOREIGN KEY(tipo_producto_fk) REFERENCES Tipo_producto(id),
    detalle_producto_fk INT,
    CONSTRAINT Fk_Detalle_producto FOREIGN KEY(detalle_producto_fk) REFERENCES Detalle_producto(id)	
);

CREATE TABLE Detalle_cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    apellido VARCHAR(50),
    cedula INT(50) UNIQUE
);
CREATE TABLE Cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    detalle_cliente_fk INT,
    CONSTRAINT Fk_Detalle_Cliente FOREIGN KEY(detalle_cliente_fk) REFERENCES Detalle_cliente(id)
);
CREATE TABLE Detalle_venta(
	id INT AUTO_INCREMENT PRIMARY KEY,
    precio DECIMAL(10,2),
    ubicacion_fk INT,
    CONSTRAINT Fk_Ubicacion_venta FOREIGN KEY(ubicacion_fk) REFERENCES ubicacion(id),
    cliente_fk INT,
    CONSTRAINT Fk_Cliente_venta FOREIGN KEY(cliente_fk)REFERENCES Cliente(id),
    producto_fk INT,
    CONSTRAINT Fk_Producto_venta FOREIGN KEY(producto_fk) REFERENCES Producto(id)
);
CREATE TABLE Venta(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    detalle_venta_fk INT,
    CONSTRAINT Detalle_venta FOREIGN KEY(detalle_venta_fk) REFERENCES Detalle_venta(id)
);
CREATE TABLE Detalle_pedido(
	id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    valor DECIMAL(10,2),
    producto_fk INT,
    CONSTRAINT Fk_Producto_pedido FOREIGN KEY(producto_fk) REFERENCES Producto(id),
    venta_fk INT,
    CONSTRAINT Fk_Ventas_pedido FOREIGN KEY(venta_fk) REFERENCES Venta(id),
    cliente_fk INT,
    CONSTRAINT Fk_Clientes_pedido FOREIGN KEY(Cliente_fk) REFERENCES Cliente(id)
);	
CREATE TABLE Tipo_pedido(
	id INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_de_pedido ENUM('En tienda', 'A domicilio', 'En línea', 'Especial'),
    Clasificacion ENUM('Urgente', 'Programado', 'Regular'),
    prioridad INT(50)
);
CREATE TABLE Pedido(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    tipo_pedido_fk INT,
    CONSTRAINT FK_Tipo_pedido FOREIGN KEY (tipo_pedido_fk) REFERENCES Tipo_pedido(id),
    detalle_pedido_fk INT,
    CONSTRAINT FK_Detalle_pedido FOREIGN KEY (detalle_pedido_fk) REFERENCES Detalle_pedido(id)
);
CREATE TABLE Detalle_compra(
	id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    valor DECIMAL(10,2),
    fecha_Compra TIMESTAMP,
    producto_fk INT,
    CONSTRAINT FK_Producto_Compra FOREIGN KEY (producto_fk) REFERENCES Producto(id),
    empleado_fk INT,
    CONSTRAINT FK_Empleado_Compra FOREIGN KEY (empleado_fk) REFERENCES Empleado(id)
);
CREATE TABLE Tipo_Compra(
	id INT AUTO_INCREMENT PRIMARY KEY,
    Pedido_fk INT,
    CONSTRAINT FK_Pedido_compra FOREIGN KEY(Pedido_fk) REFERENCES Pedido(id)
);
CREATE TABLE Compra(
	id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_fk INT,
    CONSTRAINT FK_Cliente_compra FOREIGN KEY (cliente_fk) REFERENCES Cliente(id),
    Detalle_compra_fk INT,
    CONSTRAINT FK_Detalle_compras FOREIGN KEY (Detalle_compra_fk) REFERENCES Detalle_compra(id),
    Tipo_Compra_fk INT,
    CONSTRAINT Fk_Tipo_Compra FOREIGN KEY (Tipo_Compra_fk) REFERENCES Tipo_Compra(id)
);
CREATE TABLE Detalle_almacen(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    Can_Productos_max INT(100),
    ubicacion_fk INT,
    CONSTRAINT Fk_Ubicacion_Almacen FOREIGN KEY(ubicacion_fk) REFERENCES ubicacion(id)
);
CREATE TABLE Almacen(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    Descrision VARCHAR(250),
    Detalle_almacen_FK INT,
    CONSTRAINT Fk_Detalle_Alamancen FOREIGN KEY (Detalle_almacen_FK) REFERENCES Detalle_almacen(id)
);
CREATE TABLE Detalle_Inventario (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    producto_fk INT,
    CONSTRAINT FK_Producto_Inventario FOREIGN KEY (producto_fk) REFERENCES Producto(id),
    fecha DATE ,
    stock_actual INT,
    Almacen_fk INT,
    CONSTRAINT Fk_Almacen_Inventario FOREIGN KEY (Almacen_fk) REFERENCES Almacen(id)
);
CREATE TABLE Inventario(
	id INT AUTO_INCREMENT PRIMARY KEY,
    Descrision VARCHAR(255),
    Detalle_Inventario_fk INT,
    CONSTRAINT Fk_Detalle_Inventario FOREIGN KEY(Detalle_Inventario_fk) REFERENCES Detalle_Inventario(id)
);


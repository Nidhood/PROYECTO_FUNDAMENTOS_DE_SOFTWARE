--- ############################################################################################################################################################################################

--- 1. Transaccion para actualizar precio de cada combo con base a la suma de los precios de cada producto denro del mismo combo mas el valor agregado del mismo.

-- Iniciar la transacción
BEGIN;

-- Obtener el ID del combo actual
UPDATE Combos
SET Precio = COALESCE(
  (SELECT SUM(Productos.PrecioDinero * ProductosCombos.CantidadProductos) + 10
   FROM Productos
   INNER JOIN ProductosCombos ON Productos.ID = ProductosCombos.ProductoID
   WHERE ProductosCombos.ComboID = Combos.ID
  ), 0)
WHERE Combos.ID IS NOT NULL;

-- Confirmar la transacción
COMMIT;

--- Prueba:

-- Insertar 5 valores de prueba para la tabla fotos
INSERT INTO fotos (nombre, descripcion, path) VALUES
('Foto1', 'Descripción de la Foto 1', '/path/foto1.jpg'),
('Foto2', 'Descripción de la Foto 2', '/path/foto2.jpg'),
('Foto3', 'Descripción de la Foto 3', '/path/foto3.jpg'),
('Foto4', 'Descripción de la Foto 4', '/path/foto4.jpg'),
('Foto5', 'Descripción de la Foto 5', '/path/foto5.jpg');

-- Insertar algunos productos de prueba
INSERT INTO productos (fotoid, nombreproducto, preciodinero, preciopuntos, descripcion, disponibilidad, promocion, disponibleconpuntos)
VALUES
(1, 'Producto A', 10.99, 5.0, 'Descripción del Producto A', 'Disponible', NULL, 'Disponible con puntos'),
(2, 'Producto B', 15.99, 8.0, 'Descripción del Producto B', 'No disponible', 5.0, 'No disponible con puntos'),
(3, 'Producto C', 25.99, 12.0, 'Descripción del Producto C', 'Disponible', NULL, 'Disponible con puntos');

-- Insertar más nombres de combos
INSERT INTO combos (nombre, precio) VALUES
('Combo A', 0),
('Combo B', 0),
('Combo C', 0),
('Combo D', 0),
('Combo E', 0);

-- Asociar productos al Combo A
INSERT INTO productoscombos (productoid, comboid, cantidadproductos) VALUES (1, 1, 3), (2, 1, 2);

-- Asociar productos al Combo B
INSERT INTO productoscombos (productoid, comboid, cantidadproductos) VALUES (2, 2, 1), (3, 2, 2);

-- Asociar productos al Combo C
INSERT INTO productoscombos (productoid, comboid, cantidadproductos) VALUES (1, 3, 2), (3, 3, 3);

-- Asociar productos al Combo D
INSERT INTO productoscombos (productoid, comboid, cantidadproductos) VALUES (1, 4, 1), (2, 4, 1), (3, 4, 1);

-- Asociar productos al Combo E
INSERT INTO productoscombos (productoid, comboid, cantidadproductos) VALUES (1, 5, 1), (2, 5, 2), (3, 5, 2);


--- ############################################################################################################################################################################################

--- 2. Transaccion del calculo del subtotal del pedidos con base a los productos o combos y reducir cantidad de productos:

-- Iniciar la transacción
BEGIN;

-- Actualizar el valor total para productos individuales en el pedido
UPDATE pedidos
SET valortotal = COALESCE(
  (SELECT SUM(productos.preciodinero)
   FROM productospedidos
   INNER JOIN productos ON productospedidos.productoid = productos.id
   WHERE productospedidos.pedidoid = pedidos.id
  ), 0)
WHERE pedidos.id IS NOT NULL;

-- Restar la cantidad disponible en productos individuales
UPDATE Productos
SET CantidadDisponible = CantidadDisponible - COALESCE(
  (SELECT SUM(ProductosPedidos.Cantidad) 
   FROM ProductosPedidos
   WHERE ProductosPedidos.PedidoID = Pedidos.ID AND Pedidos.ID IS NOT NULL
  ), 0)
WHERE Productos.ID IN (
  SELECT ProductoID
  FROM ProductosPedidos
  WHERE ProductosPedidos.PedidoID = Pedidos.ID AND Pedidos.ID IS NOT NULL
);

-- Actualizar el valor total para combos en el pedido
UPDATE pedidos
SET valortotal = valortotal + COALESCE(
  (SELECT SUM(combos.precio)
   FROM combospedidos
   INNER JOIN combos ON combospedidos.comboid = combos.id
   WHERE combospedidos.pedidoid = pedidos.id
  ), 0)
WHERE pedidos.id IS NOT NULL;

-- Restar la cantidad disponible en combos
UPDATE Combos
SET CantidadDisponible = CantidadDisponible - COALESCE(
  (SELECT SUM(CombosPedidos.Cantidad) 
   FROM CombosPedidos
   WHERE CombosPedidos.PedidoID = Pedidos.ID AND Pedidos.ID IS NOT NULL
  ), 0)
WHERE Combos.ID IN (
  SELECT ComboID
  FROM CombosPedidos
  WHERE CombosPedidos.PedidoID = Pedidos.ID AND Pedidos.ID IS NOT NULL
);

-- Confirmar la transacción
COMMIT;

--- Prueba:

-- Insertar direcciones de prueba
INSERT INTO direcciones (calle, numerocalle, ciudad) VALUES
('Calle 1', '123', 'Bogotá'),
('Calle 2', '456', 'Bogotá'),
('Calle 3', '789', 'Bogotá');

-- Insertar ubicaciones de prueba
INSERT INTO ubicaciones (direccionid, edificio, piso, descripcion) VALUES
(1, 'Edificio A', 5, 'Apartamento 501'),
(2, 'Edificio B', 3, 'Local 302'),
(3, 'Edificio C', 10, 'Oficina 1001');

-- Insertar estados de pedido de prueba
INSERT INTO estadospedidos (estadopago, estadoenvio, estadopedido) VALUES
('Pagado', 'Enviado', 'Aceptado'),
('Pagado', 'Enviado', 'No aceptado'),
('Pagado', 'No enviado', 'Aceptado'),
('Pagado', 'No enviado', 'No aceptado'),
('No pagado', 'Enviado', 'Aceptado'),
('No pagado', 'Enviado', 'No aceptado'),
('No pagado', 'No enviado', 'Aceptado'),
('No pagado', 'No enviado', 'No aceptado');

-- Insertar usuarios de prueba
INSERT INTO usuarios (fotoid, tipousuario, nombreusuario, contrasena, idjaveriana, correoinstitucional, nombre, apellido, edad, telefono, correo, puntos, calificacion, estadosesion, disponibilidad)
VALUES
(1, 'Comprador', 'comprador1', 'contrasena1', 'ID1', 'correo1@javeriana.edu.co', 'Juan', 'Perez', 25, '123456789', 'juan@gmail.com', 50, 4.5, 'Conectada', 'Disponible'),
(2, 'Repartidor', 'repartidor1', 'contrasena2', 'ID2', 'correo2@javeriana.edu.co', 'Pedro', 'Gomez', 30, '987654321', 'pedro@gmail.com', 30, 4.2, 'Conectada', 'Disponible'),
(3, 'Personal de tienda', 'tienda1', 'contrasena3', 'ID3', 'correo3@javeriana.edu.co', 'Maria', 'Lopez', 28, '456789012', 'maria@gmail.com', 40, 4.0, 'Conectada', 'Disponible');

-- Insertar 5 valores de prueba para la tabla tiendas
INSERT INTO tiendas (personaltiendaid, ubicacionid, estadotienda, nombretienda)
VALUES
(1, 2, 'Abierta', 'Tienda A'),
(1, 2, 'Cerrada', 'Tienda B'),
(1, 2, 'Abierta', 'Tienda C'),
(1, 2, 'Cerrada', 'Tienda D'),
(1, 2, 'Abierta', 'Tienda E');

-- Insertar pedidos de prueba
INSERT INTO pedidos (compradorid, repartidorid, personaltiendaid, estadopedidoid, ubicacionid, tiendaid, tipopedido, valortotal)
VALUES
(1, 2, 3, 1, 1, 1, 'Domicilio', 0),  -- Pedido con productos individuales
(1, 2, 3, 2, 2, 1, 'Reservar', 0);    -- Pedido con combos

-- Asociar productos al primer pedido
INSERT INTO productospedidos (pedidoid, productoid) VALUES
(1, 1), (1, 2), (1, 3);

-- Asociar combos al segundo pedido
INSERT INTO combospedidos (pedidoid, comboid) VALUES
(2, 3), (2, 3), (2, 3);
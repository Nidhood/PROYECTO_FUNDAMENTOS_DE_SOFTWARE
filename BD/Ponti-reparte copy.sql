-- Creacion de tablas:

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS direcciones_sec START 1;

CREATE TABLE IF NOT EXISTS direcciones 
    (
        id INT PRIMARY KEY DEFAULT nextval('direcciones_sec'),
        calle STRING(20) NOT NULL,
        numerocalle STRING(20) NOT NULL,
        ciudad STRING(20) NOT NULL
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS estadospedidos_sec START 1;

CREATE TABLE IF NOT EXISTS estadospedidos
    (
        id INT PRIMARY KEY DEFAULT nextval('estadospedidos_sec'),
        estadopago STRING(20) NOT NULL,
        estadoenvio STRING(20) NOT NULL,
        estadopedido STRING(20) NOT NULL, 
        UNIQUE (estadopago, estadoenvio, estadopedido),
        CONSTRAINT ok_pay_state CHECK (estadopago IN ('Pagado', 'No pagado')),
        CONSTRAINT ok_send_state CHECK (estadoenvio IN ('Enviado', 'No enviado')),
        CONSTRAINT ok_order_state CHECK (estadopedido IN ('Aceptado', 'No aceptado'))
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS fotos_sec START 1;

CREATE TABLE IF NOT EXISTS fotos
    (
        id INT PRIMARY KEY DEFAULT nextval('fotos_sec'),
        nombre STRING(20) NOT NULL, 
        descripcion STRING(320),
        path STRING(320) NOT NULL,
        UNIQUE (nombre)
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS combos_sec START 1;

CREATE TABLE IF NOT EXISTS combos
    (
        id INT PRIMARY KEY DEFAULT nextval('combos_sec'),
        nombre STRING(20) NOT NULL, 
        precio DECIMAL(10, 4) NOT NULL,
        UNIQUE (nombre)
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS ubicaciones_sec START 1;

CREATE TABLE IF NOT EXISTS ubicaciones
    (
        id INT PRIMARY KEY DEFAULT nextval('ubicaciones_sec'),
        direccionid INT NOT NULL, 
        edificio STRING(20) NOT NULL,
        piso SMALLINT,
        descripcion STRING(320),
        CONSTRAINT fk_location_direction FOREIGN KEY (direccionid) REFERENCES direcciones (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS usuarios_sec START 1;

CREATE TABLE IF NOT EXISTS usuarios
    (
        id INT PRIMARY KEY DEFAULT nextval('usuarios_sec'),
        fotoid INT NOT NULL, 
        tipousuario STRING(20) NOT NULL,
        nombreusuario STRING(320) NOT NULL,
        contrasena STRING(320) NOT NULL,
        idjaveriana STRING(20) NOT NULL,
        correoinstitucional STRING(320) NOT NULL,
        nombre STRING(20) NOT NULL,
        apellido STRING(20) NOT NULL,
        edad SMALLINT NOT NULL,
        telefono STRING(20) NOT NULL,
        correo STRING(320) NOT NULL,
        puntos INT,
        calificacion DECIMAL(10,4),
        estadosesion STRING(20) NOT NULL,
        disponibilidad STRING(20) NOT NULL,
        UNIQUE (nombreusuario),
        CONSTRAINT ok_user_type CHECK (tipousuario IN ('Comprador', 'Repartidor', 'Personal de tienda')),
        CONSTRAINT ok_session_state CHECK (estadosesion IN ('Conectada', 'Desconectada')),
        CONSTRAINT ok_availability CHECK (disponibilidad IN ('Disponible', 'No disponible')),
        CONSTRAINT fk_user_photo FOREIGN KEY (fotoid) REFERENCES fotos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS tiendas_sec START 1;

CREATE TABLE IF NOT EXISTS tiendas
    (
        id INT PRIMARY KEY DEFAULT nextval('tiendas_sec'),
        personaltiendaid INT NOT NULL,
        ubicacionid INT NOT NULL,
        estadotienda STRING(20) NOT NULL,
        nombretienda STRING(20) NOT NULL,
        UNIQUE (nombretienda),
        CONSTRAINT ok_pay_state CHECK (estadotienda IN ('Abierta', 'Cerrada')),
        CONSTRAINT fk_store_staff  FOREIGN KEY (personaltiendaid) REFERENCES usuarios (id) ON DELETE CASCADE,
        CONSTRAINT fk_store_address FOREIGN KEY (ubicacionid) REFERENCES ubicaciones (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS productos_sec START 1;

CREATE TABLE IF NOT EXISTS productos
    (
        id INT PRIMARY KEY DEFAULT nextval('productos_sec'),
        fotoid INT NOT NULL,
        nombreproducto STRING(20) NOT NULL,
        preciodinero DECIMAL(10,4) NOT NULL,
        preciopuntos DECIMAL(10,4) NOT NULL,
        descripcion STRING(320),
        disponibilidad STRING(20) NOT NULL,
        promocion DECIMAL(10,4),
        disponibleconpuntos STRING(40) NOT NULL,
        cantidaddisponible INT NOT NULL,
        UNIQUE (nombreproducto),
        CONSTRAINT fk_product_photo FOREIGN KEY (fotoid) REFERENCES fotos (id) ON DELETE CASCADE,
        CONSTRAINT ok_availability CHECK (disponibilidad IN ('Disponible', 'No disponible')),
        CONSTRAINT ok_disponibleconpuntos CHECK (disponibleconpuntos IN ('Disponible con puntos', 'No disponible con puntos'))
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS tiendasproductos_sec START 1;

CREATE TABLE IF NOT EXISTS tiendasproductos
    (
        id INT PRIMARY KEY DEFAULT nextval('tiendasproductos_sec'),
        tiendaid INT NOT NULL,
        productoid INT NOT NULL,
        UNIQUE (tiendaid, productoid),
        CONSTRAINT fk_storeproducts_store  FOREIGN KEY (tiendaid) REFERENCES tiendas (id) ON DELETE CASCADE,
        CONSTRAINT fk_storeproducts_product FOREIGN KEY (productoid) REFERENCES productos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS ingredientes_sec START 1;

CREATE TABLE IF NOT EXISTS ingredientes
    (
        id INT PRIMARY KEY DEFAULT nextval('ingredientes_sec'),
        nombreingrediente STRING(20) NOT NULL,
        UNIQUE (nombreingrediente)
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS ingredientesproductos_sec START 1;

CREATE TABLE IF NOT EXISTS ingredientesproductos
    (
        id INT PRIMARY KEY DEFAULT nextval('ingredientesproductos_sec'),
        ingredienteid INT NOT NULL,
        productoid INT NOT NULL,
        cantidad INT NOT NULL,
        UNIQUE (ingredienteid, productoid),
        CONSTRAINT fk_ingredientsproduct_ingredient  FOREIGN KEY (ingredienteid) REFERENCES ingredientes (id) ON DELETE CASCADE,
        CONSTRAINT fk_ingredientsproduct_producs  FOREIGN KEY (productoid) REFERENCES productos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS pedidos_sec START 1;

CREATE TABLE IF NOT EXISTS pedidos
    (
        id INT PRIMARY KEY DEFAULT nextval('pedidos_sec'),
        compradorid INT NOT NULL,
        repartidorid INT NOT NULL,
        personaltiendaid INT NOT NULL,
        estadopedidoid INT NOT NULL,
        ubicacionid INT NOT NULL,
        tipopedido STRING(20) NOT NULL,
        valortotal DECIMAL(10,4) NOT NULL,
        CONSTRAINT ok_order_state CHECK (tipopedido IN ('Domicilio', 'Reservar')),
        CONSTRAINT fk_order_shopper  FOREIGN KEY (compradorid) REFERENCES usuarios (id) ON DELETE CASCADE,
        CONSTRAINT fk_order_dealer FOREIGN KEY (repartidorid) REFERENCES usuarios (id) ON DELETE CASCADE,
        CONSTRAINT fk_order_staff FOREIGN KEY (personaltiendaid) REFERENCES usuarios (id) ON DELETE CASCADE,
        CONSTRAINT fk_order_state FOREIGN KEY (estadopedidoid) REFERENCES estadospedidos (id) ON DELETE CASCADE,
        CONSTRAINT fk_order_locations FOREIGN KEY (ubicacionid) REFERENCES ubicaciones (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS productospedidos_sec START 1;

CREATE TABLE IF NOT EXISTS productospedidos
    (
        id INT PRIMARY KEY DEFAULT nextval('productospedidos_sec'),
        pedidoid INT NOT NULL,
        productoid INT NOT NULL,
        CONSTRAINT fk_productsorders_order  FOREIGN KEY (pedidoid) REFERENCES pedidos (id) ON DELETE CASCADE,
        CONSTRAINT fk_productsorders_product  FOREIGN KEY (productoid) REFERENCES productos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS productoscombos_sec START 1;

CREATE TABLE IF NOT EXISTS productoscombos
    (
        id INT PRIMARY KEY DEFAULT nextval('productoscombos_sec'),
        productoid INT NOT NULL,
        comboid INT NOT NULL,
        cantidadproductos INT NOT NULL DEFAULT 0,
        UNIQUE (productoid, comboid),
        CONSTRAINT fk_comboproducts_product  FOREIGN KEY (productoid) REFERENCES productos (id) ON DELETE CASCADE,
        CONSTRAINT fk_comboproducts_combo  FOREIGN KEY (comboid) REFERENCES combos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS combospedidos_sec START 1;

CREATE TABLE IF NOT EXISTS combospedidos
    (
        id INT PRIMARY KEY DEFAULT nextval('combospedidos_sec'),
        pedidoid INT NOT NULL,
        comboid INT NOT NULL,
        CONSTRAINT fk_comboorders_order  FOREIGN KEY (pedidoid) REFERENCES pedidos (id) ON DELETE CASCADE,
        CONSTRAINT fk_comboorders_combo  FOREIGN KEY (comboid) REFERENCES combos (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS informaciontarjetas_sec START 1;

CREATE TABLE IF NOT EXISTS informaciontarjetas
    (
        id INT PRIMARY KEY DEFAULT nextval('informaciontarjetas_sec'),
        tipotarjeta STRING(20) NOT NULL,
        fechavencimiento DATE NOT NULL,
        nombretitular STRING(20) NOT NULL,
        pin SMALLINT NOT NULL,
        credito DECIMAL(10,4) NOT NULL,
        UNIQUE(nombretitular, pin),
        CONSTRAINT ok_card_type CHECK (tipotarjeta IN ('Debito', 'Credito'))
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS informacionpagos_sec START 1;

CREATE TABLE IF NOT EXISTS informacionpagos
    (
        id INT PRIMARY KEY DEFAULT nextval('informacionpagos_sec'),
        informaciontarjetaid INT,
        tipodepago STRING(20) NOT NULL,
        CONSTRAINT ok_paymenttype CHECK (tipodepago IN ('Efectivo', 'Tarjeta', 'PonitPuntos')),
        CONSTRAINT fk_paymentinformation_cardinformation  FOREIGN KEY (informaciontarjetaid) REFERENCES informaciontarjetas (id) ON DELETE CASCADE
    )
;

--------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE IF NOT EXISTS pedidosinformacionpagos_sec START 1;

CREATE TABLE IF NOT EXISTS pedidosinformacionpagos
    (
        id INT PRIMARY KEY DEFAULT nextval('pedidosinformacionpagos_sec'),
        pedidoid INT NOT NULL,
        informacionpagosid INT NOT NULL,
        tipodepago STRING(20) NOT NULL,
        aclaraciones STRING(320),
        propina DECIMAL(10,4),
        CONSTRAINT fk_comboorders_order  FOREIGN KEY (pedidoid) REFERENCES pedidos (id) ON DELETE CASCADE,
        CONSTRAINT fk_comboorders_combo  FOREIGN KEY (informacionpagosid) REFERENCES informacionpagos (id) ON DELETE CASCADE
    )
;
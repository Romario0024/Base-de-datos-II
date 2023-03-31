-- Crear las tablas y 2 registros para cada tabla para el siguiente modelo ER.
CREATE OR REPLACE DATABASE POLLOS_COPA;
 USE POLLOS_COPA;

CREATE TABLE cliente
(
    id_cliente INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    fullname VARCHAR(25),
    lastname VARCHAR(25),
    edad INT,
    domicilio VARCHAR(50)
)
;

CREATE TABLE pedido
(
    id_pedido INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    articulo VARCHAR(25),
    costo INT,
    fecha DATE
)
;
CREATE TABLE detalle_pedido
(
    id_detalle_pedido INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_pedido INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
)
;

INSERT INTO cliente(fullname, lastname, edad, domicilio)
VALUES ('Rodrigo','Torrez',34,'Zona Villa Adela'),
       ( 'Juan','Quiroga',23,'Av. Siempre Viva');

INSERT INTO pedido(articulo, costo, fecha)
VALUES ('Pollo Dorado',64,'7-12-12'),
       ( 'Pollo Spiedo',44,'7-06-18');

INSERT INTO detalle_pedido(id_cliente, id_pedido)
VALUES (1,2),
       ( 2,1);

-- Crear una consulta SQL en base al ejercicio anterior.
-- Ejercicio 12ª: Hacer una consulta que muestre el nombre, apellido, domicilio y el articulo del cliente Quiroga

SELECT
   cl.fullname, cl.lastname, cl.domicilio, ped.articulo
FROM cliente AS cl
INNER JOIN detalle_pedido AS depe ON cl.id_cliente = depe.id_cliente
INNER JOIN pedido AS ped ON depe.id_pedido = ped.id_pedido
WHERE cl.lastname = 'Quiroga';


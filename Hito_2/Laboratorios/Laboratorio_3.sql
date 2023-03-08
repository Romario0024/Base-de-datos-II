
CREATE DATABASE hito_2_v2;
USE hito_2_v2;
    CREATE TABLE usuarios
    (
    id_usuario INTEGER AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL ,
    apellidos VARCHAR(50) NOT NULL ,
    edad INTEGER NOT NULL ,
    email VARCHAR(100) NOT NULL
    );

INSERT INTO usuarios( nombres, apellidos, edad, email) VALUES
    ('Alberto','Torres',21, 'AlbertoGmail.com'),
    ('Juan','Espinoza',18, 'JuanGmail.com'),
    ('Beto','Tore',31, 'BetoGmail.com');

SELECT * FROM usuarios;

#Mostrar los usuarios mayores a 30 años
CREATE VIEW mayores_a_30 AS
SELECT *
FROM usuarios
WHERE edad > 30;

SELECT *
FROM mayores_a_30;

ALTER VIEW mayores_a_30 AS
SELECT us.nombres,
       us.apellidos,
       us.edad,
       us.email
FROM usuarios AS us
WHERE us.edad > 30;


SELECT m30.*
FROM mayores_a_30 AS m30;
#Modificar la anterios vista para que muestre los siguiente

ALTER VIEW mayores_a_30 AS
SELECT
        CONCAT (us.nombres ,' ',  us.apellidos) as FULLLNAME,
       us.edad as EDAD_USUARIO,
       us.email as EMAIL_USUARIO
FROM usuarios AS us ;


SELECT m30.*
FROM mayores_a_30 AS m30;
 #a LA VISTA CREADA ANTERIOR MENTE MOSTRAR LOS USUARIOS QUE EN SU APELLIDO TENIAN EL NUMERO 3


SELECT us.*
FROM mayores_a_30 AS us
WHERE us.FULLLNAME LIKE '%A%';

#CREATE OR REPLACE en caso de no querer uysar el alter


# Eliminacion de vistas
DROP VIEW mayores_a_30;


# lABORATORIO DE BASE DE DATOS 08/03/2023

CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(50),
  fecha_nacimiento DATE
);

CREATE TABLE usuario (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE,
  direccion VARCHAR(100)
);

CREATE TABLE libro (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  isbn VARCHAR(20),
  fecha_publicacion DATE,
  autor_id INTEGER,
  FOREIGN KEY (autor_id) REFERENCES autor(id)
);

CREATE TABLE prestamo (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  usuario_id INTEGER REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE libro_categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  categoria_id INTEGER REFERENCES categoria(id) ON DELETE CASCADE
);


INSERT INTO autor (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel Garcia Marquez', 'Colombiano', '1927-03-06'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28'),
('Pablo Neruda', 'Chileno', '1904-07-12'),
('Octavio Paz', 'Mexicano', '1914-03-31'),
('Jorge Luis Borges', 'Argentino', '1899-08-24');


INSERT INTO libro (titulo, isbn, fecha_publicacion, autor_id) VALUES
('Cien años de soledad', '978-0307474728', '1967-05-30', 1),
('La ciudad y los perros', '978-8466333867', '1962-10-10', 2),
('Veinte poemas de amor y una canción desesperada', '978-0307477927', '1924-08-14', 3),
('El laberinto de la soledad', '978-9681603011', '1950-01-01', 4),
('El Aleph', '978-0307950901', '1949-06-30', 5);


INSERT INTO usuario (nombre, email, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@gmail.com', '1985-06-20', 'Calle Falsa 123'),
('Maria Rodriguez', 'maria.rodriguez@hotmail.com', '1990-03-15', 'Av. Siempreviva 456'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', '1982-12-10', 'Calle 7ma 789'),
('Laura Sanchez', 'laura.sanchez@gmail.com', '1995-07-22', 'Av. Primavera 234'),
('Jorge Fernandez', 'jorge.fernandez@gmail.com', '1988-04-18', 'Calle Real 567');


INSERT INTO prestamo (fecha_inicio, fecha_fin, libro_id, usuario_id) VALUES
('2022-01-01', '2022-01-15', 1, 1),
('2022-01-03', '2022-01-18', 2, 2),
('2022-01-05', '2022-01-20', 3, 3),
('2022-01-07', '2022-01-22', 4, 4),
('2022-01-09', '2022-01-24', 5, 5);


INSERT INTO categoria (nombre) VALUES
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Historia');


INSERT INTO libro_categoria (libro_id, categoria_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);

ALTER TABLE libro
    ADD COLUMN paginas INTEGER DEFAULT 20;

ALTER TABLE libro
    ADD COLUMN editorial VARCHAR(70) DEFAULT 'Don Bosco';







SHOW DATABASES;

CREATE DATABASE Universidad;

USE Universidad;

CREATE TABLE Estudiante
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(50) NOT NULL
);

DESCRIBE Estudiante;

INSERT INTO Estudiante(nombres, apellidos, edad, fono, email)
    VALUES ('Nombre 1','Apellido 1',10,1111,'user1@gmail.com'),
           ('Nombre 2','Apellido 2',10,1111,'user2@gmail.com'),
           ('Nombre 3','Apellido 2',10,1111,'user3@gmail.com');

SELECT * FROM estudiante;

select last_insert_id();

ALTER TABLE Estudiante
DROP COLUMN direccion;


ALTER TABLE Estudiante
ADD COLUMN direccion VARCHAR(100) DEFAULT ('EL ALTO');


DESCRIBE estudiante;

ALTER TABLE Estudiante
ADD COLUMN fax VARCHAR(10),
ADD COLUMN genero varchar(10);

SELECT * FROM Estudiante;
SELECT * FROM Estudiante WHERE estudiante.nombres= 'Nombre 3';

SELECT nombres, apellidos as apellidos_de_persona, edad FROM Estudiante WHERE estudiante.edad >= 18;

SELECT * FROM Estudiante WHERE estudiante.id_est%2=0;
SELECT * FROM Estudiante WHERE estudiante.id_est%2!=0;


SELECT * FROM Estudiante WHERE estudiante.id_est%2=0;


DROP table estudiante;

CREATE TABLE estudiantes
(
    id_est integer auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    edad integer not null,
    fono integer not null ,
    email varchar(100) not null
);

CREATE TABLE materias(
    id_mat integer auto_increment primary key not null,
    nombre_mat varchar(100)not null,
    cod_mat varchar(100)not null
);

CREATE TABLE inscripcion(
    id_ins integer auto_increment primary key not null,
    id_est integer not null,
    id_mat integer not null,
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);
use Universidad;


-- creacion de base de d
create database Library;
use Library;


create table categories(
    category_id integer auto_increment primary key not null,
    name varchar(100) not null
);
create table publishers (
    publisher_id integer auto_increment primary key not null,
    name varchar(100) not null
);
create table books(
    book_id integer auto_increment primary key not null,
    title varchar(100)not null,
    isbn varchar(100)not null,
    published_date date,
    description varchar(100) not null,
    category_id integer not null,
    publisher_id integer not null ,

    FOREIGN KEY (category_id) REFERENCES categories(category_id) ,
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
);




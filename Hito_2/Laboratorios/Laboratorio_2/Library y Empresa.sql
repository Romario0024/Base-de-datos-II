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

Create database EMPRESA;
use EMPRESA;



create table Empresa(
    empre_id integer auto_increment primary key not null,
    nombre varchar(100) not null,
    Ubicacion varchar(100) not null
);

create table Area(
    area_id  integer auto_increment primary key not null,
    tipo varchar(100) not null,
    codigoArea int
);
create table Empleado(
    emp_id integer auto_increment primary key not null,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    edad varchar(100) not null,
    fono varchar(100) not null,
    email VARCHAR(50) NOT NULL,
           empre_id integer not null,
             area_id integer not null ,

             FOREIGN KEY (empre_id) REFERENCES Empresa(empre_id) ,
             FOREIGN KEY (area_id) REFERENCES Area (area_id)

);

INSERT INTO Empleado(nombre,apellido,edad,fono,email)
    VALUES ('Juan','Torrez','345','435','user1@gmail.com'),
           ('Arnoldo','prez','345','435','user2@gmail.com'),
           ('Pepe','Jon ','345','435','user3@gmail.com');

INSERT INTO Empresa(nombre, Ubicacion)
    VALUES ('Unifranz','La paz'),
           ('Google','Beni'),
           ('Microsoft','Tarija');

INSERT INTO Area(tipo, codigoArea)
    VALUES ('Direccion', 435434),
           ('Docencia',43534),
           ('Seguridad',43543);

select * from area;
select * from Empleado;
SHOW DATABASES ;

Create database hito_2;

create database ejemplos;

drop database ejemplos;

use hito_2;

create table estudiante (
 id int primary key not null,
nombre varchar(23) not null,
apellido varchar(23)not null );

insert into estudiante (id,nombre , apellido)
values (2, "Juan","Perez");
insert into estudiante (id,nombre , apellido)
values (3, "Alejandro","Sosa");

 select*from estudiante;

drop database if exists hito_2;

drop table if exists  estudiante;

# imsert delete update = dml
#
#
create database universidad;

use universidad;
create table estudiantes
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombres VARCHAR(100) NOT NULL ,
    apellidos VARCHAR(100) NOT NULL ,
    edad INTEGER NOT NULL ,
    fono INTEGER NOT NULL ,
    email VARCHAR(50) NOT NULL
);
DESCRIBE  estudiantes;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email)
VALUES ('pedro','Torrez',12,543,'user1gmail.com'),
('Carlos','escobar',13,548,'user2gmail.com'),
('zombie','cardobal',12,5463,'user2gmail.com');

alter table estudiantes
    add column direccion varchar(200) default 'El Alto';

alter table estudiantes
drop column direccion;


select * from estudiantes;
/*PRESENTACION DEL PROCESUAL DE LA MATERIA DE BASE DE DATOS:*/
-- ----------------------------------------------------------------------------------------------------------------------
-- 9. Crear una  Base de datos y sus registros.
-- ----------------------------------------------------------------------------------------------------------------------

CREATE DATABASE procesual_hito4;
USE procesual_hito4;

CREATE  TABLE  proyecto
(
    id_proy INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre_proy VARCHAR(50),
    tipo_proy VARCHAR(50)
);

CREATE  TABLE  departamento
(
    id_dep INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50)
);
CREATE  TABLE  provincia
(
    id_prov INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50),
    id_dep INT,
    FOREIGN KEY (id_dep) REFERENCES  departamento (id_dep)
);
CREATE  TABLE persona
(
    id_per INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nac DATE,
    edad INT,
    email VARCHAR(50),
    direccion VARCHAR(100),
    id_dep INT,
    id_prov INT,
    FOREIGN KEY (id_dep) REFERENCES  departamento (id_dep),
    FOREIGN KEY (id_prov) REFERENCES  provincia (id_prov)
);
CREATE  TABLE  detalle_proyecto
(
    id_dp INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    id_per INT,
    id_proy INT,
    FOREIGN KEY (id_per) REFERENCES  persona (id_per),
    FOREIGN KEY (id_proy) REFERENCES  proyecto (id_proy)
);

INSERT INTO proyecto (nombre_proy, tipo_proy)
VALUES ('ChatBot','desarrollo de software'),
       ('Sistemas de facturacion','diseño');

INSERT INTO departamento (nombre)
VALUES ('La paz'),
       ('Cochabamba');

INSERT INTO provincia (nombre, id_dep)
VALUES ('Pedro domingo murillo',1),('Cercado',2);

INSERT INTO persona ( nombre, apellidos, fecha_nac, edad, email, direccion, id_dep, id_prov)
VALUES ('Alberto','Gutierres','2001-06-21',23,'Alb@gmail.com','Av. Siempre Viva',1,1),('Juan','Mamani','2002-08-12',20,'juan@gmail.com','Calle Juan',2,2);

INSERT INTO detalle_proyecto ( id_per, id_proy)
VALUES (1,1),(2,2);





-- ----------------------------------------------------------------------------------------------------------------------
-- 10.Crear una función que sume los valores de la serie Fibonacci.
-- ----------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE  FUNCTION  fibonacci_serie(limite int)
RETURNS TEXT
BEGIN
    declare i int default 0;

    DECLARE cadena text default '';
    declare num int default 0;
    declare nuevoNumero int default 1;
    declare acum int;

    while(i< limite) do
        set cadena = concat(cadena, num,',');
        set acum = num;
        set num = nuevoNumero;
        set nuevoNumero = acum + nuevoNumero;

        set i = i+1;
    end while;
    return cadena;
end;

select fibonacci_serie(8);

CREATE OR REPLACE FUNCTION suma_serie_fibonacci (cadena_fibonacci text)
returns int
begin
    declare ubicacion_coma int;
    declare nuevo_numero int;
    declare resultado int default  0;

    while(cadena_fibonacci != '') do
        set ubicacion_coma = locate(',', cadena_fibonacci);
        set nuevo_numero = substr(cadena_fibonacci,1,ubicacion_coma-1);
        set resultado = nuevo_numero  + resultado;
        set cadena_fibonacci = substr(cadena_fibonacci, ubicacion_coma+1);
    end while;
    return resultado;
end;

select suma_serie_fibonacci(fibonacci_serie(30));



-- ----------------------------------------------------------------------------------------------------------------------
-- 11.Manejo de vistas.
-- ----------------------------------------------------------------------------------------------------------------------
alter table persona
add sexo char;

create or replace view manejo_de_consulta as
select concat(per.nombre,' ', per.apellidos) as nombre_concatenado, per.edad as edad, per.fecha_nac as fecha_nacimiento, p.nombre_proy as nombre_proy
from persona as per
inner join detalle_proyecto dp on per.id_per = dp.id_per
inner join proyecto p on dp.id_proy = p.id_proy
inner join departamento d on per.id_dep = d.id_dep
where per.sexo = 'f' and d.nombre = 'El alto' and per.fecha_nac = '2000-10-10';





INSERT INTO departamento
        ( nombre)
VALUES
    ('El Alto');

INSERT INTO provincia (nombre, id_dep)
VALUES ('Pedro domingo ',3);

insert into persona ( nombre, apellidos, fecha_nac,edad, email, direccion, id_dep, id_prov, sexo)
values ('Maria','Torres','2000-10-10',23,'albe34@gmail.com','Av. Siempre Viva',3,3,'F');

INSERT INTO detalle_proyecto (id_per, id_proy)
VALUES (3,1);

INSERT INTO provincia (nombre, id_dep) VALUES ('Murillo',3);





-- ----------------------------------------------------------------------------------------------------------------------
-- 12.Manejo de TRIGGERS I.
-- ----------------------------------------------------------------------------------------------------------------------
alter table proyecto
add estado varchar(20);


CREATE  OR REPLACE TRIGGER tr_proyecto
    before insert
    on proyecto
    for each row
    begin
        if (new.tipo_proy = 'educacion' or new.tipo_proy = 'forestacion' or new.tipo_proy = 'cultura' ) then
            set new.estado = 'ACTIVO';
        ELSE
            SET new.estado = 'INACTIVO';
        END IF;
    end;
CREATE  OR REPLACE TRIGGER tr2_proyecto
    before UPDATE
    on proyecto
    for each row
    begin
        if (new.tipo_proy = 'educacion' or new.tipo_proy = 'forestacion' or new.tipo_proy = 'cultura' ) then
            set new.estado = 'ACTIVO';
        ELSE
            SET new.estado = 'INACTIVO';
        END IF;
    end;

INSERT INTO  proyecto
( nombre_proy, tipo_proy) VALUES
                              ('nombreProyecto1','cultura'),
('nombreProyecto2','investigacion');

select * from proyecto;




-- ----------------------------------------------------------------------------------------------------------------------
-- 13.Manejo de Triggers II.
-- ----------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER tr_calculaeddad
    before insert on persona
    for each row
    begin
        set new.edad = timestampdiff(year, new.fecha_nac, curdate());
    end;

insert into persona ( nombre, apellidos, fecha_nac,  email, direccion, id_dep, id_prov,sexo)
values ('Mijail','choque',  '2004-09-16','mija@gmail.com','Av.PAseo tablado',1,1,'M');
insert into persona ( nombre, apellidos, fecha_nac,  email, direccion, id_dep, id_prov,sexo)
values ('Mijail','choque',  '2004-02-16','mija@gmail.com','Av.PAseo tablado',1,1,'M');
select * from persona;




-- ----------------------------------------------------------------------------------------------------------------------
-- 14.Manejo de TRIGGERS III.
-- ----------------------------------------------------------------------------------------------------------------------

CREATE or replace TABLE audit_persona
(
    id_per INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nac DATE,
    edad INT,
    email VARCHAR(50),
    direccion VARCHAR(100),
    id_dep INT,
    id_prov INT,
    sexo char

);

create or replace trigger tr_audit_persona
    before insert
    on persona
    for each row
    begin
        insert into audit_persona (nombre, apellidos, fecha_nac, edad, email, direccion, id_dep, id_prov, sexo)
            values (new.nombre,new.apellidos, new.fecha_nac, new.edad, new.email, new.direccion, new.id_dep, new.id_prov, new.sexo);
    end;

insert into persona ( nombre, apellidos, fecha_nac,  email, direccion, id_dep, id_prov,sexo)
values ('ALberto','choque',  '2004-09-16','alb@gmail.com','Av.PAseo doblado',1,1,'M');

select * from persona;
select * from audit_persona;




-- ----------------------------------------------------------------------------------------------------------------------
-- 15.Crear una consulta SQL que haga uso de todas las tablas.
-- ----------------------------------------------------------------------------------------------------------------------
# EJercicio planteado: Obten el nombre de la persona, su email, el nombre del proyecto que esta trabajando, y toda la informacion
# de que este relacionada a su ubicacion o direccion. Solo de las personas que esten rabajndo en el proyecto chatbot

SELECT per.nombre, per.email, proy.nombre_proy , d.nombre, p2.nombre, per.direccion
from persona as per
inner join detalle_proyecto dp on per.id_per = dp.id_per
inner join proyecto proy on dp.id_proy = proy.id_proy
inner join provincia p2 on per.id_prov = p2.id_prov
inner join departamento d on per.id_dep = d.id_dep
where proy.nombre_proy = 'chatbot';

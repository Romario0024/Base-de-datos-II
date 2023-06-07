CREATE DATABASE defensa_hito4_2023;
use defensa_hito4_2023;
CREATE TABLE proyecto
(
    id_proy int primary key,
    nombreProy varchar(100),
    tipoProy varchar(30)
);

 CREATE TABLE departamento
(
    id_dep int primary key,
    nombre varchar(100)

);



 CREATE TABLE provincia
(
    id_prov int primary key,
    nombre varchar(50),
    id_dep int,
    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep)

);
 CREATE TABLE persona
(
    id_per int primary key,
    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edaed int,
    email varchar(50),
    sexo char,
    id_dep int,
    id_prov int,
     FOREIGN KEY (id_dep) REFERENCES departamento(id_dep),
     FOREIGN KEY (id_prov) REFERENCES provincia(id_prov)

);
 CREATE TABLE detalle_proyecto
(
    id_dp int primary key,
    id_per int,
    id_proy int,
    FOREIGN KEY (id_per) REFERENCES persona(id_per),
    FOREIGN KEY (id_proy) REFERENCES proyecto(id_proy)
);



CREATE or replace TABLE audit_proyectos
(
    id_aud_proy int auto_increment primary key ,
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userId varchar(30),
    hostname varchar(30),
    fecha varchar(30)
);

INSERT INTO persona (id_per, nombre, apellidos, fecha_nac, edaed, email, sexo, id_dep, id_prov)
VALUES  ('1','ALFREDO','TORREZ','2000-10-10',23,'AL@GMIALK.COM','m',1,1),
     ('2','juanioto','TORREZ','2000-10-10',53,'AL@GMIALK.COM','m',2,2);

INSERT INTO proyecto (id_proy, nombreProy, tipoProy)
VALUES (1,'chatbot2','investigacion2'),
(2,'chatbot2','investigacion');

insert into departamento (id_dep, nombre)
values (1,'cochabamba'),(2,'La paz');

insert into detalle_proyecto(id_dp, id_per, id_proy)
values (1, 1,2), (2, 2,1)
;

insert into provincia (id_prov, nombre, id_dep)
values (1,'Murrillo',1) ,(2,'Seque',2);

CREATE OR REPLACE TRIGGER tr_audit_proys_insert
    before insert
    ON proyecto
    FOR EACH ROW
    BEGIN
        INSERT INTO audit_proyectos ( nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId,hostname, fecha)
        VALUES ('NO existe valor PREVIO' , NEW.nombreProy,' NO EXISTE VALOR Previo', NEW.tipoProy, 'insert',user(),@@hostname ,now());
    END;

CREATE OR REPLACE TRIGGER tr_audit_proys_update
    after update
    ON proyecto
    FOR EACH ROW
    BEGIN
        INSERT INTO audit_proyectos ( nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId,hostname, fecha)
        VALUES (old.nombreProy , NEW.nombreProy,old.tipoProy, NEW.tipoProy, 'update',user(),@@hostname ,now());
    END;

CREATE OR REPLACE TRIGGER tr_audit_proys_delete
    after delete
    ON proyecto
    FOR EACH ROW
    BEGIN
        INSERT INTO audit_proyectos ( nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId,hostname, fecha)
        VALUES (old.nombreProy , ' NO EXISTE VALOR POSTERIOR',OLD.nombreProy,  ' NO EXISTE VALOR POSTERIOR', 'delete',user(),@@hostname ,now());
    END;

insert into proyecto (id_proy, nombreProy, tipoProy)
values (1,'chatbot', 'investigacipon');

UPDATE proyecto AS proy
SET proy.nombreProy = 'doce' where proy.nombreProy = 'proyectoAlfa';

delete from proyecto where nombreProy = 'doce' ;

select * from audit_proyectos;
select * from proyecto;

truncate proyecto;
/*
CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    AFTER DELETE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE id_usuario TEXT;
        DECLARE nombres TEXT;
        DECLARE usr_password TEXT;

        SET id_usuario = OLD.id_usr;
        SET nombres = OLD.nombre_completo;
        SET usr_password = OLD.password;

        INSERT INTO audit_usuarios_rrhh(
                fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, password) SELECT
             now(), user(), @@HOSTNAME, 'DELETE', id_usuario, nombres, usr_password;
    END;

select
 */

 create or replace function cambiaNombre (nombre text)
    returns text
    begin
        declare nuevoNombre text;

        CASE nombre
        WHEN 'La paz' THEN SET nuevoNombre = 'LPZ';
        WHEN 'Cochabamba' THEN SET nuevoNombre = 'CBBA';
        WHEN 'Pando' THEN SET nuevoNombre = 'PND';
        WHEN 'Beni' THEN SET nuevoNombre = 'BNI';
        WHEN 'Santa Cruz' THEN SET nuevoNombre = 'SCR';
        WHEN 'Chuquisaca' THEN SET nuevoNombre = 'CQS';
        WHEN 'Tarija' THEN SET nuevoNombre = 'TRJ';
        WHEN 'El Alto' THEN SET nuevoNombre = 'EATO';
        WHEN 'Oruro' THEN SET nuevoNombre = 'ORO';
        WHEN 'Potosi' THEN SET nuevoNombre = 'PTS';
        end case;
        RETURN nuevoNombre;
    end;



create or replace view muestra_datos_persona as
select concat(per.nombre , ' ', per.apellidos)as fullname, concat(p.nombreProy, ':',p.tipoProy) as desc_proy, d.nombre as departamento , cambiaNombre(D.nombre)
from persona as per
inner join detalle_proyecto dp on per.id_per = dp.id_per
inner join proyecto p on dp.id_proy = p.id_proy
INNER JOIN departamento d on per.id_dep = d.id_dep;


-- -----------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tr_validacioon_propyecto
    BEFORE INSERT
    ON proyecto
    FOR EACH ROW
    BEGIN
        DECLARE dia_de_la_semana TEXT DEFAULT '';
        DECLARE mes TEXT DEFAULT '';
        SET dia_de_la_semana = DAYNAME(CURRENT_DATE);
        SET mes = monthname(current_date);

        IF (dia_de_la_semana = 'Wednesday' and mes = 'June' and new.tipoProy = 'forestacion' ) THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'no se admite inserciones del tipo FORESTACION';
        end if;
    END;

INSERT INTO proyecto (id_proy, nombreProy, tipoProy)
VALUES (4,'chatbot2','investigacion2');

INSERT INTO proyecto (id_proy, nombreProy, tipoProy)
VALUES (5,'chatbot2','forestacion');

select * from proyecto;


select dayname(current_date);
select monthname(current_date);

/*CREATE OR REPLACE TRIGGER tr_validacioon_propyecto
    BEFORE INSERT
    ON proyecto
    FOR EACH ROW
    BEGIN
        DECLARE dia_de_la_semana TEXT DEFAULT '';
        DECLARE mes TEXT DEFAULT '';
        SET dia_de_la_semana = DAYNAME(CURRENT_DATE);
        SET mes = monthname(current_date);

        IF (dia_de_la_semana = 'Wednesday' and mes = 'June' and new.tipoProy = 'forestacion' ) THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'no se admite inserciones del tipo FORESTACION';
        end if;

    END;*/

create or replace function diccionario_diccionario_dias_semana(dia_semana text)
returns text
begin
     declare dia_traducido text;
    case (dia_semana)
          WHEN 'monday' THEN SET dia_traducido = 'lunes' ;
          WHEN 'tuesday' THEN SET dia_traducido = 'martes';
          WHEN 'wednesday' THEN SET dia_traducido = 'miercoles';
          WHEN 'thursday' THEN SET dia_traducido = 'jueves';
          WHEN 'friday' THEN SET dia_traducido = 'viernes';
          WHEN 'saturday' THEN SET dia_traducido = 'sabado';
          WHEN 'sunday' THEN SET dia_traducido = 'domingo';
    end case;
     return dia_traducido;
end;

select diccionario_diccionario_dias_semana('monday');
select diccionario_diccionario_dias_semana('tuesday');
select diccionario_diccionario_dias_semana(dayname(current_date));
select diccionario_diccionario_dias_semana('thursday');
select diccionario_diccionario_dias_semana('friday');
select diccionario_diccionario_dias_semana('saturday');
select diccionario_diccionario_dias_semana('sunday');
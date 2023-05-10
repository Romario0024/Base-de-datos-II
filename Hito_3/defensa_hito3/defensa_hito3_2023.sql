CREATE DATABASE defensa_hito3_2023;
USE defensa_hito3_2023;
-- ejecicio 2-. CREAR UNA BASE DE DATOS LLAMADA CLIENTE Y CREAR DOS FUNCIONES: UNA QUE OBTENGA LA EDAD MAX Y UNA SECUENCIA LOOP
CREATE OR REPLACE TABLE CLIENTES
(
    id_client INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    fullname VARCHAR(20),
    last_name VARCHAR(20),
    age INT,
    genero CHAR(1)
);
INSERT INTO CLIENTES
        (fullname, last_name, age, genero)
VALUES ('Miguel','Gonzales Veliz',20,'m'),
        ('laura','torrez Perez',15,'f'),
        ('Esteban','Serafin Quispe',26,'m');



CREATE OR REPLACE  FUNCTION  edad_maxima()
RETURNS TEXT
BEGIN
    DECLARE edad_max INT;
    SELECT MAX(age)
    INTO edad_max
    FROM CLIENTES;
    RETURN edad_max;
END;

CREATE OR REPLACE FUNCTION pares_impares()
RETURNS TEXT
BEGIN
    DECLARE respuesta TEXT  DEFAULT  '';
    DECLARE num INT DEFAULT 0;
    DECLARE edad INT DEFAULT (SELECT edad_maxima());

   IF(edad % 2 = 0) THEN
     BUCLE_PAR: LOOP
        if num  >= edad +2 THEN
            LEAVE BUCLE_PAR;
        END IF;

        SET respuesta = concat(respuesta,num,',');
        SET num = num +2;
        ITERATE BUCLE_PAR;
    END LOOP;

    ELSE
     BUCLE_IMPAR: LOOP
       if edad <= num    THEN
            LEAVE BUCLE_IMPAR;
        END IF;

        SET respuesta = concat(respuesta,edad,',');
        SET edad = edad -2;
        ITERATE BUCLE_IMPAR;
    END LOOP;
    END IF;

    RETURN respuesta;
END;
SELECT pares_impares();

-- ejercicio n.1 -. crea una funcionque devuelva una cadena sin nada que no seqa vocales
CREATE OR REPLACE FUNCTION elimina_consonantes_y_numeros(cadena text)
returns text
begin
                -- variables del puntero:
            DECLARE cuenta_cadena INT DEFAULT 0;
            DECLARE puntero TEXT DEFAULT '';
            -- variables
            DECLARE respuesta TEXT DEFAULT '';


            WHILE (cuenta_cadena <= CHAR_LENGTH(cadena)) DO
                SET puntero =  substr(cadena,cuenta_cadena,1);
                CASE puntero
                    WHEN 'a' THEN set cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    WHEN 'e' THEN SET cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    WHEN 'i' THEN SET cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    WHEN 'o' THEN SET cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    WHEN 'u' THEN SET cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    WHEN ' ' THEN SET cuenta_cadena = cuenta_cadena+1; SET respuesta = concat(respuesta, puntero);
                    ELSE SET cuenta_cadena = cuenta_cadena+1;
                END CASE ;
             END WHILE;
             RETURN  respuesta;
end;
select elimina_consonantes_y_numeros('BASE DE DATOS II 2023');
select elimina_consonantes_y_numeros('tytyttytyt');
select elimina_consonantes_y_numeros('aiououiuoui');


-- ejercicio 3-. CREAR SERIE FIBONACCI
 CREATE OR REPLACE FUNCTION fibonacci_serie(number INT)
    RETURNS TEXT
    BEGIN
        DECLARE i INT DEFAULT 0;

        DECLARE cadena TEXT DEFAULT '';
        DECLARE num INT DEFAULT 0;
        DECLARE nuevoNumero INT DEFAULT 1;
        DECLARE acum INT;


            WHILE (i < number) DO
                 SET cadena = concat(cadena,num,',');
                 SET acum = num;
                 SET num = nuevoNumero;
                 SET nuevoNumero = acum + nuevoNumero;

             SET i =i+1;
             END WHILE;

    RETURN cadena;
END;
SELECT fibonacci_serie(10);

-- ejercicio 4-. CREAR SERIE FIBONACCI
CREATE OR REPLACE FUNCTION remplasa_palabras (cadena text, cadenaUniversidad text, cadenaUniversidad2 text)
RETURNS text
BEGIN
             DECLARE RESP TEXT DEFAULT '';

             declare locacion int default locate(cadenaUniversidad,cadena);
        declare cadenaaux1 text default  substr(cadena,0,locacion);

            declare locacion2 int default locate(cadenaUniversidad,cadena,locacion+char_length(cadenaUniversidad));

        declare cadenaaux2 text default substr(cadena, 0,locacion2);

            declare locacion3 int default locate(cadenaUniversidad,cadena,locacion2+char_length(cadenaUniversidad));
        declare cadenaaux3 text default substr(cadena, 0,locacion3);

-- 'Bienvenidos a UNIFRANZ, UNIFRANZ tiene 10 carerras




        SET RESP = concat(cadenaaux1,cadenaUniversidad2,cadenaaux2,cadenaUniversidad2,cadenaaux3);
         RETURN  cadenaaux1;
end;
SELECT remplasa_palabras ('Bienvenidos a UNIFRANZ, UNIFRANZ tiene 10 carerras', 'UNIFRANZ','UNIVALLE');


CREATE OR REPLACE FUNCTION alrevez(cadena TEXT)
RETURNS text
BEGIN
        DECLARE acumulador INT DEFAULT 1;

        DECLARE puntero TEXT DEFAULT '';
    declare resp text default '';

        WHILE (puntero != '') DO
            SET puntero =  substr(cadena,-acumulador);
            set acumulador = acumulador-1;
            set resp = concat(resp,puntero);
         END WHILE;

    RETURN  resp;
END;
select alrevez ('cadena');
-- Inicio de Hito 3
-- Tema: Lenguaje Procedural
-- Laboratorio 1

CREATE DATABASE hito3_2023;
USE hito3_2023;

-- Las variables se crean de la siguiente manera:
SET @usuario = 'GUEST';
SET @location = 'EL ALTO';

SELECT @usuario;
SELECT @location;

CREATE OR REPLACE FUNCTION variable()
    RETURNS TEXT
    BEGIN

       RETURN @usuario;
    END;

SET @HITO_3 ='ADMIN';

CREATE OR REPLACE FUNCTION pregunta()
    RETURNS VARCHAR(50)
    BEGIN

        DECLARE resultado VARCHAR(50);

        IF @HITO_3 = 'ADMIN' THEN
        SET resultado = 'usuario ADMIN';
         END IF;
        IF @HITO_3 != 'ADMIN' THEN
        SET resultado = 'usuario INVITADO';
        END IF;

    RETURN resultado;
    END;

CREATE OR REPLACE FUNCTION pregunta2()
    RETURNS VARCHAR(50)
    BEGIN

        DECLARE resultado VARCHAR(50);
        CASE @HITO_3
            WHEN 'ADMIN'
            THEN SET resultado = 'usuario ADMIN';
        ELSE SET resultado= 'usuario INVITADO';
        END CASE;
        RETURN resultado;

    END;

 #crear una secuancia 1,2,3,4,5,6 ...
CREATE OR REPLACE FUNCTION generar_numeros_naturales(limite int)
    RETURNS TEXT
    BEGIN

        DECLARE cont INT default 1;
        DECLARE resp TEXT default '';

        WHILE (cont <= limite) DO
            SET resp = CONCAT(resp, cont, ',' );
            SET cont = cont + 1;
        END WHILE;
        RETURN resp;
    END;

SELECT generar_numeros_naturales(10);


#crear la siguiente secuencia 2,1,4,3,6,5,8,7
CREATE OR REPLACE FUNCTION numeros_naturales(limite int)
    RETURNS TEXT
    BEGIN

        DECLARE cont INT default 2;
        DECLARE resp TEXT default '';
         DECLARE cont2 INT default 1;

        WHILE (cont <= limite) DO

                SET resp = CONCAT(resp, cont,',', cont2,',' );
                 SET cont = cont + 2;
                set cont2 = cont2 + 2;
        END WHILE;

        RETURN resp;
    END;


SELECT numeros_naturales(10);

#Ejercicio anterior pero resuelta por el inegeniro
CREATE OR REPLACE FUNCTION pares_impares(limite int)
    RETURNS TEXT
    BEGIN
        DECLARE pares INT DEFAULT 2;
        DECLARE impares INT DEFAULT 1;
        DECLARE cont INT DEFAULT 1;
        DECLARE respuesta TEXT DEFAULT '';

        WHILE cont <= limite DO
          IF cont % 2 = 1 THEN
              SET respuesta = CONCAT(respuesta, pares, ', ');
              SET pares = pares +2;
          ELSE;
             SET respuesta = CONCAT(respuesta, impares, ', ');
              SET impares = impares +2;
         END IF;

          SET cont = cont +1;
        END WHILE;
        RETURN respuesta;
    END;

-- uso del repeat
# Retorna la siguiente secuencia  10 -AA- 9 -BB- 8 -AA- 7 -BB- 6 -AA- 5 -BB- 4 -AA- 3 -BB- 2 -AA- 1 -BB-
CREATE OR REPLACE FUNCTION uso_de_repeat(x INT)
RETURNS TEXT
BEGIN

    DECLARE str TEXT DEFAULT ' ';
    REPEAT
        IF(x%2=0)THEN
               SET str = CONCAT(str,x,' -AA- ');

        end if;
         IF X%2!=0 THEN
          SET str = CONCAT(str,x,' -BB- ');
        end if;


        SET x = x -1;
    UNTIL  x <= 0 END REPEAT;
    RETURN str;
END;
SELECT uso_de_repeat(10);

-- EL BUCLE WHILE SE REPITE MIENTRAS LA CONDICION SEA VERDADERA Y REPEAT SE REPITE MIENTRAS LA CONDICION SEA FALSA


CREATE OR REPLACE FUNCTION manejo_de_loop(x INT)
RETURNS TEXT
BEGIN
    DECLARE str TEXT DEFAULT '';
    DBAII: LOOP
        IF x >0 THEN
            LEAVE DBAII;
        END IF;

        SET str = CONCAT(str,x,',');
        SET x = x+1;
        ITERATE DBAII;
    END LOOP;
    RETURN str;
END;

SELECT manejo_de_loop(-10);


CREATE OR REPLACE FUNCTION manejo_de_loop_v2(x INT)
RETURNS TEXT
BEGIN
    DECLARE str TEXT DEFAULT '';
    DBAII: LOOP
        IF x < 1 THEN
            LEAVE DBAII;
        END IF;

        IF(x%2=0)THEN
               SET str = CONCAT(str,x,' -AA- ');

        end if;
         IF X%2!=0 THEN
          SET str = CONCAT(str,x,' -BB- ');
        end if;
        SET x = x -1;
        ITERATE DBAII;
    END LOOP;
    RETURN str;
END;

SELECT manejo_de_loop_v2(10);

-- Laboratorio ----------------


CREATE OR REPLACE FUNCTION LABORATORIO(credit_number INT)
RETURNS TEXT
BEGIN
    DECLARE respuesta TEXT DEFAULT '';

        if (credit_number > 50000)then
            set respuesta = 'PLATINIUM';
        end if;
            if (credit_number >= 10000 && credit_number <= 50000 )then
            set respuesta = 'GOLD';
        end if;
            if (credit_number < 10000)then
            set respuesta = 'SILVER';
        end if;
    RETURN respuesta;
END;

SELECT LABORATORIO(10000);

# uso del charlength
# El charlength nos permite determinar cuantos caracteres tiene una palabra
# DBAII = 5
# SELECT char_length('DBAII') => 5

SELECT char_length('DBAII 2023') ;
SELECT char_length(' DBAII 2023 ');

CREATE OR REPLACE FUNCTION valida_length_7(password TEXT)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';
    IF char_length(password)>7 THEN
        SET resp = 'PASSED';
        ELSE
        SET resp = 'FAILED';
    END IF;
    RETURN resp;
END;

SELECT valida_length_7('passwrd');

# Comparacion de cadenas
# El objetivo es saber si dos cadenas son iguales
# DBAII = DBAII  ? true
# DBAII = DBAII 2023 ? false

SELECT strcmp ('dbaii','dbaii 20');
-- en MySql/MariaDb la funcion me retorna 0 si son iguales
-- Si son distintos la fucnion me retorna -1 o 1

SELECT strcmp ('dbaii','DBAII');
-- no hay distincio entre mayusculas y minusculas

select strcmp();

CREATE OR REPLACE FUNCTION uso_de_strcmp(cad1 TEXT, cad2 text)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';
    IF strcmp(cad1,cad2) = 0 THEN
        SET resp = 'IGUALES';
        ELSE
        SET resp = 'DISTINTAS';
    END IF;
    RETURN resp;
END;

SELECT uso_de_strcmp('DBA','DBA');

# En base a las dos funciones anteriores determinar lo siguiente
# Rescibir 2 cadenas en la funcion
# Recibir 2 cadenas en la funcion
# Si las dos cadenas son iguales y ademas el length es mayor a 15
# Retornar  el mensaje VALIDO
# Caso contrario retorna NO VALIDO

CREATE OR REPLACE FUNCTION uso_de_strcmp(cad1 TEXT, cad2 text)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';
    DECLARE cadena_total TEXT DEFAULT '';
    SET cadena_total = concat(cad1,cad2);

    IF char_length(cadena_total) > 15 && strcmp(cad1,cad2) = 0 THEN
        SET resp = 'VALIDO';
        ELSE
        SET resp = 'NO VALIDO';
    END IF;
    RETURN resp;
END;

SELECT uso_de_strcmp('12345678','12345678');
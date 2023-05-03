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

    IF char_length(cadena_total) > 15 AND strcmp(cad1,cad2) = 0 THEN
        SET resp = 'VALIDO';
        ELSE
        SET resp = 'NO VALIDO';
    END IF;
    RETURN resp;
END;

SELECT uso_de_strcmp('12345678','12345678');


#DBAII 2023 unifranz
#2023

-- manejo de SUBSTRING
-- contando desde la izquierda
SELECT substr('DBAII 2023 unifranz',7); -- muestra los caracteres empezando desde el septimo valor contando el cero

SELECT substr('hola',3); -- soolo muestra los caracteres la "la"

SELECT substr('DBAII 2023 unifranz',7, 4); -- muestra los lo caracteres "2023" el tercer campo nos muetra cuantos valores va a guardar para mostrar

SELECT substr('DBAII 2023 unifranz' FROM 7 FOR 4); -- usando for y from
-- contando desde la derecha
SELECT substr('DBAII 2023 unifranz',-8);

SELECT substr('DBAII 2023 unifranz',-13 , 4);

SELECT substr('DBAII 2023 unifranz',-19 ,1 ); -- obtener solo la letra D

-- manejo de LOCATE
-- Base de Datos II, gestion 2023 Unifranz     27,4

-- el primer paramtro es para indicar que valor deseamos que busque, y el segundo es parqa indicar de donde queremos que busque()es decir la dcadena total
SELECT LOCATE('2023','Base de Datos II, gestion 2023 Unifranz ');

SELECT LOCATE('2023','Base de Datos II, gestion 2023 Unifranz 2023',30); -- el tercer parametro nos ayuda a identificar desde que valor deseamos buscar


-- ejercicio : manejo de substring y locate



CREATE OR REPLACE FUNCTION uso_de_locate(cad1 TEXT, cad2 text)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';
    DECLARE busca_cadena TEXT DEFAULT  LOCATE(cad2,cad1);

    IF busca_cadena != 0 THEN
        SET resp = concat('Si existe',' : ', busca_cadena);
    ELSE
        SET resp = 'No existe';
    END IF;

    RETURN resp;
END;

SELECT uso_de_locate('6993499LP','LP');

-- ejercicio de repaso de uso de while para generar numeros pares :

CREATE OR REPLACE FUNCTION generar_numeros_naturales_2 (limite int)
    RETURNS TEXT
    BEGIN

        DECLARE cont INT default 0;
        DECLARE resp TEXT default '';

        WHILE (cont <= limite) DO
            SET resp = CONCAT(resp, cont, ', ' );
            SET cont = cont + 2;
        END WHILE;
        RETURN resp;
    END;

SELECT generar_numeros_naturales_2(9);



-- Ejercicio con repeat: concatena una cadena n veces
CREATE OR REPLACE FUNCTION concatena_n_veces(cadena TEXT,numero INT)
RETURNS TEXT
BEGIN

    DECLARE resp TEXT DEFAULT ' ';

    REPEAT

         SET resp = CONCAT(resp,cadena);
          SET numero = numero -1;
    UNTIL  numero <= 0 END REPEAT;

    RETURN resp;
END;

SELECT concatena_n_veces('DBAII - ',5);


-- Ejercicio: contando vocales:
CREATE OR REPLACE FUNCTION busca_vocales2(cadena TEXT)
RETURNS int
BEGIN
        DECLARE acumulador INT DEFAULT 0;
         DECLARE cont INT DEFAULT 0;
        DECLARE puntero TEXT DEFAULT 'R';

        WHILE (puntero != '') DO
            SET puntero =  substr(cadena,acumulador,1);
            CASE puntero
                WHEN 'a' THEN SET cont = cont +1 AND acumulador = acumulador+1;
                WHEN 'e' THEN SET cont = cont +1 AND  acumulador = acumulador+1;
                WHEN 'i' THEN SET cont = cont +1 AND acumulador = acumulador+1;
                WHEN 'o' THEN SET cont = cont +1 AND acumulador = acumulador+1;
                WHEN 'u' THEN SET cont = cont +1 AND  acumulador = acumulador+1;
                ELSE SET acumulador = acumulador+1;
            END CASE ;
         END WHILE;

    RETURN  cont;
END;

SELECT busca_vocales2 ('jana');


-- Ejercicio: crea una funcion que cunete una letra determinada como poramttro
CREATE OR REPLACE FUNCTION busca_letra(cadena TEXT, letra_buscada TEXT)
RETURNS int
BEGIN
        DECLARE acumulador INT DEFAULT 0;
         DECLARE cont INT DEFAULT 0;
        DECLARE puntero TEXT DEFAULT 'R';

        IF LOCATE (letra_buscada, cadena)>0 THEN

            WHILE (acumulador <= CHAR_LENGTH(cadena)) DO
            SET puntero =  substr(cadena,acumulador,1);
            IF (letra_buscada = puntero) THEN
                SET cont = cont +1 ;
                SET acumulador = acumulador+1;

            ELSEIF letra_buscada != puntero THEN
                 SET acumulador = acumulador+1;
                  end if;
         END WHILE;

        END IF;

    RETURN  cont;
END;


SELECT busca_letra ('HOLA MUNDO', 'O');

-- ejercicio anteriorhecho por el ing
CREATE OR REPLACE FUNCTION cuenta_caracter(cadena VARCHAR(50), letra CHAR)
RETURNS TEXT
BEGIN
        DECLARE respuesta TEXT DEFAULT 'lA LETRA NO HAY EN LA CADENA';
        DECLARE cont INT DEFAULT 1;
        DECLARE nVeces INT DEFAULT 0;
        DECLARE  puntero CHAR;
        IF locate(letra, cadena)> 0 THEN
            WHILE cont <= char_length(cadena) DO
                SET puntero = substr(cadena, cont ,1);
                IF puntero = letra THEN
                    SET nVeces = nVeces +1;
                end if;
                SET cont = cont +1;
            END WHILE;
            SET respuesta = CONCAT('La letra',letra,' se repite: ',nVeces);
        END IF;
        return respuesta;
 END;
select cuenta_caracter('hola mundo', 'o');

CREATE OR REPLACE FUNCTION busca_vocales(cadena TEXT)
RETURNS TEXT
BEGIN
        DECLARE acumulador INT DEFAULT 0;
         DECLARE cont INT DEFAULT 0;
        DECLARE puntero TEXT DEFAULT 'R';
        DECLARE RESP TEXT DEFAULT 'NO HAY VOCALES EN LA CADENA';

        WHILE (acumulador <= CHAR_LENGTH(cadena)) DO
            SET puntero =  substr(cadena,acumulador,1);
            CASE puntero
                WHEN 'a' THEN SET cont = cont +1; set acumulador = acumulador+1;
                WHEN 'e' THEN SET cont = cont +1; set  acumulador = acumulador+1;
                WHEN 'i' THEN SET cont = cont +1; set acumulador = acumulador+1;
                WHEN 'o' THEN SET cont = cont +1; set acumulador = acumulador+1;
                WHEN 'u' THEN SET cont = cont +1; set  acumulador = acumulador+1;
                ELSE SET acumulador = acumulador+1;
            END CASE ;
         END WHILE;
        SET RESP = CONCAT('la cadena tiene la cantidad de ',cont,' vocales ');
         RETURN  RESP;
END;

SELECT busca_vocales('algun texto');

-- ejercicio anterior pero hecho por el ingeniero
CREATE OR REPLACE FUNCTION cuenta_cantidad_de_vocales(cadena TEXT)
RETURNS TEXT
BEGIN
        DECLARE puntero CHAR;
        DECLARE x INT DEFAULT 0;
         DECLARE cont INT DEFAULT 0;

        WHILE (x <= char_length(cadena))DO
            SET puntero = SUBSTR(cadena,x,1);
            IF puntero = 'a' OR puntero = 'e' OR puntero = 'i' OR puntero = 'o' OR puntero = 'u' then
                SET cont = cont +1;
            end if;
            SET x = x+1;
            end while;
        RETURN concat ('Cantidad de vocales: ', cont);
END;
select cuenta_cantidad_de_vocales('dba II 2023');

-- ejercicio anterior pero hecho por el ingeniero con un LIKE
CREATE OR REPLACE FUNCTION cuenta_cantidad_de_vocales_V2(cadena TEXT)
RETURNS TEXT
BEGIN
        DECLARE x INT DEFAULT 0;
         DECLARE cont INT DEFAULT 0;

        WHILE (x <= char_length(cadena))DO

            IF (SUBSTR(cadena,x,1)  like '%aeiou%') then
                SET cont = cont +1;
            end if;
            SET x = x+1;
            end while;
        RETURN concat ('Cantidad de vocales: ', cont);
END;
select cuenta_cantidad_de_vocales('dba II 2023');

# base de datos II 2023

-- ejercicio cuenta las palabras en una cadena..... ejercicio incompleto...:::
CREATE OR REPLACE FUNCTION cuenta_palabra(cadena TEXT)
RETURNS TEXT
BEGIN
        DECLARE x INT DEFAULT 0;
         DECLARE cont INT DEFAULT 1;
        declare desde int;

        while(desde = 0) do
       declare desde int default locate (' ', cadena);
        declare resp text default substr(cadena, desde);
        cont = cont +1;
        end while;

        RETURN concat ('Cantidad de palabras: ', cont);
END;
select cuenta_cantidad_de_vocales('dba I yh');


-- Ejercicio : muestra el los apellidos sin el nombre
CREATE OR REPLACE FUNCTION apellidos(cadena TEXT)
RETURNS TEXT
BEGIN

        declare desde int default locate (' ', cadena);
        declare resp text default substr(cadena, desde+1);
        return resp;
END;
select apellidos('Romario tola Quispe');










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
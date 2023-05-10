# 11. Crear la siguiente Base de datos y sus registros.

CREATE DATABASE Universidad;
USE Universidad;
-- ----------
CREATE OR REPLACE TABLE estudiantes
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    edad INT,
    fono INT,
    email VARCHAR(100),
    direccion VARCHAR(100),
    sexo VARCHAR(10)
)
;
CREATE OR REPLACE TABLE materias
(
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat VARCHAR(50),
    cod_mat VARCHAR(50)
);
CREATE OR REPLACE TABLE inscripcion
(
    id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    semestre VARCHAR(20),
    gestion INT,
    id_est INTEGER NOT NULL,
    id_mat INTEGER NOT NULL,
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO estudiantes
        (nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel','Gonzales Veliz',20,2832115,'miguel@gmail.com','Av. 6 de agosto','masculino'),
        ('Sandra','Mavir Uria',25,2832116,'sandra@gmail.com','Av. 6 de agosto','femenino'),
         ('Joel','Adubiri Mondar',30,2832117,'joel@gmail.com','Av. 6 de agosto','masculino'),
         ('Andrea','Arias Ballesteros',21,2832118,'andrea@gmail.com','Av. 6 de agosto','femenino'),
         ('Santos','Montes Valenzuela',24,2832119,'santos@gmail.com','Av. 6 de agosto','masculino');
INSERT INTO materias
    (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura','ARQ-101'),
         ('Urbanismo y diseño','ARQ-102'),
         ('Dibujo y Pintura Arquitectonica','ARQ-103'),
         ('Matematica discreta','ARQ-104'),
         ('Fisica Basica','ARQ-105');
INSERT INTO inscripcion
    (semestre, gestion, id_est, id_mat)
VALUES ('1er Semestre',2018,1,1),
         ('2er Semestre',2018,1,2),
         ('1er Semestre',2019,2,4),
         ('2er Semestre',2019,2,3),
         ('2er Semestre',2020,3,3),
         ('3er Semestre',2020,3,1),
         ('4er Semestre',2021,4,4),
         ('5er Semestre',2021,5,5);
# 12.Crear una función que genere la serie Fibonacci.
CREATE OR REPLACE FUNCTION fibonacci_serie(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE i INT DEFAULT 0;

        DECLARE cadena TEXT DEFAULT '';
        DECLARE num INT DEFAULT 0;
        DECLARE nuevoNumero INT DEFAULT 1;
        DECLARE acum INT;


            WHILE (i < limite) DO
                 SET cadena = concat(cadena,num,',');
                 SET acum = num;
                 SET num = nuevoNumero;
                 SET nuevoNumero = acum + nuevoNumero;

             SET i =i+1;
             END WHILE;

    RETURN cadena;
END;
SELECT fibonacci_serie(8);

# 13.Crear una variable global a nivel BASE DE DATOS.
set @limit = 9;
CREATE OR REPLACE FUNCTION fibonacci_serie_v2()
    RETURNS TEXT
    BEGIN
        DECLARE cadena TEXT DEFAULT '';

        DECLARE i INT DEFAULT 0;

        DECLARE num INT DEFAULT 0;
        DECLARE nuevoNumero INT DEFAULT 1;
        DECLARE acum INT;


            WHILE (i < @limit) DO
                 SET cadena = concat(cadena,num,',');
                 SET acum = num;
                 SET num = nuevoNumero;
                 SET nuevoNumero = acum + nuevoNumero;

             SET i =i+1;
             END WHILE;

    RETURN cadena;
END;
SELECT fibonacci_serie_v2();



# 14.Crear una función no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
SELECT MIN(edad)
FROM estudiantes;

CREATE OR REPLACE  FUNCTION  edad_minima()
RETURNS TEXT
BEGIN
    DECLARE edad_min INT;
    SELECT MIN(edad)
    INTO edad_min
    FROM estudiantes;
    RETURN edad_min;
END;

CREATE OR REPLACE FUNCTION pares_impares()
RETURNS TEXT
BEGIN
    DECLARE respuesta TEXT  DEFAULT  '';
    DECLARE num INT DEFAULT 0;
    DECLARE edad INT DEFAULT (SELECT edad_minima());

   IF(edad % 2 = 0) THEN
        WHILE (num <= edad)DO
        SET respuesta = concat(respuesta,num,',');
        SET num = num +2;
        END WHILE ;

    ELSE
        WHILE (edad >= num )DO
        SET respuesta = concat(respuesta,edad,',');
        SET edad = edad - 2;
        END WHILE ;
    END IF;

    RETURN respuesta;
END;
SELECT pares_impares();

# 15.Crear una función que determina cuantas veces se repite las vocales.
CREATE OR REPLACE FUNCTION busca_vocales(cadena TEXT)
RETURNS TEXT
BEGIN

         DECLARE cuenta_cadena INT DEFAULT 0;

         DECLARE contA INT DEFAULT 0;
         DECLARE contE INT DEFAULT 0;
         DECLARE contI INT DEFAULT 0;
         DECLARE contO INT DEFAULT 0;
         DECLARE contU INT DEFAULT 0;

        DECLARE puntero TEXT DEFAULT '';

        DECLARE RESP TEXT DEFAULT '';

        WHILE (cuenta_cadena <= CHAR_LENGTH(cadena)) DO
            SET puntero =  substr(cadena,cuenta_cadena,1);
            CASE puntero
                WHEN 'a' THEN SET contA = contA +1; set cuenta_cadena = cuenta_cadena+1;
                WHEN 'e' THEN SET contE = contE +1; set  cuenta_cadena = cuenta_cadena+1;
                WHEN 'i' THEN SET contI = contI +1; set cuenta_cadena = cuenta_cadena+1;
                WHEN 'o' THEN SET contO = contO +1; set cuenta_cadena = cuenta_cadena+1;
                WHEN 'u' THEN SET contU = contU +1; set  cuenta_cadena = cuenta_cadena+1;
                ELSE SET cuenta_cadena = cuenta_cadena+1;
            END CASE ;
         END WHILE;
        SET RESP = CONCAT('a: ',contA,', e: ',contE,' , i: ',contI,' , o: ',contO,' , u: ',contU);
         RETURN  RESP;
END;

SELECT busca_vocales('taller de base de datos');


# 16.Crear una función que recibe un parámetro INTEGER.
CREATE OR REPLACE FUNCTION numero_de_credito(credit_number INT)
RETURNS text
BEGIN
    DECLARE respuesta TEXT DEFAULT '';

    CASE
    WHEN (credit_number > 50000) THEN set respuesta = 'PLATINIUM';
    WHEN (credit_number >= 10000) AND credit_number <= 50000 THEN set respuesta = 'GOLD';
    WHEN (credit_number < 10000) THEN set respuesta = 'SILVER';
    END CASE;
    return respuesta;
end;
SELECT numero_de_credito(49999);


# 17. Crear una función que recibe 2 parámetros VARCHAR(20), VARCHAR(20).
    CREATE OR REPLACE  FUNCTION  concatena_sin_vocal(cadena1 VARCHAR(20), cadena2 VARCHAR(20))
        RETURNS TEXT
        BEGIN
            -- variables del puntero:
            DECLARE cuenta_cadena INT DEFAULT 0;
            DECLARE puntero TEXT DEFAULT '';
            -- variables
            DECLARE respuesta TEXT DEFAULT '';
            declare cadena_total text default concat(cadena1,'-',cadena2);

            WHILE (cuenta_cadena <= CHAR_LENGTH(cadena_total)) DO
                SET puntero =  substr(cadena_total,cuenta_cadena,1);
                CASE puntero
                    WHEN 'a' THEN set cuenta_cadena = cuenta_cadena+1;
                    WHEN 'e' THEN SET cuenta_cadena = cuenta_cadena+1;
                    WHEN 'i' THEN SET cuenta_cadena = cuenta_cadena+1;
                    WHEN 'o' THEN SET cuenta_cadena = cuenta_cadena+1;
                    WHEN 'u' THEN SET cuenta_cadena = cuenta_cadena+1;
                    ELSE SET respuesta = concat(respuesta, puntero);SET cuenta_cadena = cuenta_cadena+1;
                END CASE ;
             END WHILE;
             RETURN  respuesta;
        END;

SELECT concatena_sin_vocal('TALLER DBA II', 'GESTION 2023');

# 18.Crear una función que reciba un parámetro TEXT
CREATE OR REPLACE FUNCTION reduce_cadena(cadena TEXT)
RETURNS TEXT
BEGIN
    DECLARE respuesta TEXT DEFAULT cadena;
    DECLARE cadena_cortada text default substr(cadena,2);
    declare contador int default 3;

    REPEAT
        SET respuesta = concat(respuesta,', ',cadena_cortada);
        set cadena_cortada = substr(cadena,contador);
        set contador = contador +1;

    UNTIL  cadena_cortada = '' END REPEAT;
    return respuesta;
END;
SELECT reduce_cadena('dbaii');

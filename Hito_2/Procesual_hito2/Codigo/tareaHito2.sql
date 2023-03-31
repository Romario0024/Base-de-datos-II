-- Crear un función que compare dos códigos de materia.------------------------
CREATE DATABASE tareaHito2;
USE tareaHito2;


CREATE TABLE estudiantes
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    edad INT,
    gestion INT,
    fono INT,
    email VARCHAR(100),
    direccion VARCHAR(100),
    sexo VARCHAR(10)
);
CREATE TABLE materias
(
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat VARCHAR(100),
    cod_mat VARCHAR(100)
);
CREATE TABLE inscripcion
(
    id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    semestre VARCHAR(20),
    gestion INT,
    id_est INT NOT NULL,
    id_mat INT NOT NULL,
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email,
direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115,'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
        ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
        ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
        ('Andrea', 'Arias Ballesteros', 21, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
        ('Santos', 'Montes Valenzuela', 24, 2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
        ('Urbanismo y Diseno', 'ARQ-102'),
        ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
        ('Matematica discreta', 'ARQ-104'),
        ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
        (1, 2, '2do Semestre', 2018),
        (2, 4, '1er Semestre', 2019),
        (2, 3, '2do Semestre', 2019),
        (3, 3, '2do Semestre', 2020),
        (3, 1, '3er Semestre', 2020),
        (4, 4, '4to Semestre', 2021),
        (5, 5, '5to Semestre', 2021);


CREATE OR REPLACE FUNCTION comparaMaterias(materiaAComparar VARCHAR(50), materiaComparada VARCHAR(50))
RETURNS BOOL
BEGIN
        DECLARE comparador bool DEFAULT false;

        IF (materiaAComparar = materiaComparada) THEN
          SET  comparador = true;
        END IF;

    RETURN comparador;
END;

SELECT
     est.id_est , est.nombres  ,est.apellidos,mat.nombre_mat, mat.cod_mat
FROM estudiantes AS est
INNER JOIN inscripcion AS ins ON est.id_est = ins.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
WHERE comparaMaterias(mat.cod_mat, 'ARQ-105') ;



-- Crear una función que permita obtener el promedio de las edades del género
-- masculino o femenino de los estudiantes inscritos en la asignatura ARQ-104.-----------------------------------

CREATE OR REPLACE FUNCTION promedio_edades (genero VARCHAR(25), materia VARCHAR(50))
RETURNS  VARCHAR(100)
BEGIN
    DECLARE respuesta VARCHAR(100) ;

  SELECT AVG (est.edad) AS promedio_edad
  INTO respuesta
    FROM estudiantes AS est
    INNER JOIN inscripcion ins on est.id_est = ins.id_est
    INNER JOIN materias mat on ins.id_mat = mat.id_mat
    WHERE mat.cod_mat = materia AND est.sexo = genero;
    RETURN respuesta;
END;

SELECT promedio_edades('masculino','ARQ-104');



-- Crear una función que permita concatenar 3 cadenas.---------------------------------------------

CREATE OR REPLACE FUNCTION concatena_Cadenas (nombre VARCHAR(50), apellido VARCHAR(50), edad int)
RETURNS VARCHAR (250)
BEGIN
        DECLARE respuesta VARCHAR(150);
        SET respuesta = Concat(nombre , ' ',apellido ,' ',  edad);
    RETURN respuesta;
END;


SELECT (concatena_Cadenas(nombres, apellidos,edad))as FULLNAME_AND_AGE
FROM estudiantes ;


-- Crear la siguiente VISTA:---------------------------------------------------------------------------

CREATE OR REPLACE VIEW ARQUITECTURA_DIA_LIBRE AS
SELECT
CONCAT (est.nombres,est.apellidos) as FULLNAME,
est.edad AS EDAD,
ins.gestion AS GESTION,
if (ins.gestion = '2021', 'LIBRE','NO LIBRE')as DIA_LIBRE
FROM estudiantes AS est
INNER JOIN inscripcion AS ins ON est.id_est = ins.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
GROUP BY FULLNAME
;


-- Crear la siguiente VISTA:-----------------------------------------------------------------------------------
USE tareaHito2;

CREATE TABLE sedeUniversidad
(
  id_sede INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombre_sede VARCHAR(100),
  ubicacion VARCHAR(100),
  id_est INT,
  FOREIGN KEY (id_est) REFERENCES estudiantes(id_est)
);
INSERT INTO sedeUniversidad (nombre_sede, ubicacion, id_est)
VALUES ( 'Unifranz EL Alto','Av. del Aeropuerto Internacional El Alto, N° 1015',1),
       ('Unifranz La Paz','C. Héroes del Acre, esq N° 1855',2),
       ('Unifranz Santa Cruz','Av. Busch N° 1113',3),
       ('Unifranz Cochabamba','Av. Villarroel, esq N° 359',4),
       ('Unifranz EL Alto','Av. del Aeropuerto Internacional El Alto, N° 1015',5);
 -- EJercicio Planteado: Mostrar el nombre completo, la sede a la cual pertenece, y la materia que esta cursando los estudiantes de 2do semestre

CREATE OR REPLACE VIEW PARALELO_DBA_I AS
SELECT
    concat(est.nombres,' ',est.apellidos) as Nombre_completo,
    seUni.nombre_sede as Sede,
    mat.nombre_mat as materia
FROM estudiantes AS est
INNER JOIN sedeUniversidad seUni on est.id_est = seUni.id_est
INNER JOIN inscripcion AS ins ON est.id_est= ins.id_est
INNER JOIN materias mat on ins.id_mat = mat.id_mat
WHERE ins.semestre = '2do Semestre';

SELECT * FROM PARALELO_DBA_I;





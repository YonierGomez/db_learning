DROP DATABASE IF EXISTS libreria_cf;

CREATE DATABASE IF NOT EXISTS  libreria_cf;

USE libreria_cf;

CREATE TABLE IF NOT EXISTS autores (

    autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
    nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
    apellido VARCHAR(50) NOT NULL,
    seudonimo VARCHAR(17) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
    genero ENUM('M', 'F') NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
    fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
    pais_origen VARCHAR(40) NOT NULL,
    fecha_creacion DATETIME DEFAULT current_timestamp

);

CREATE TABLE IF NOT EXISTS libros (

    libro_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
    autor_id INT UNSIGNED NOT NULL, -- LLAVE FORANEA, INT ALMACENA NÚMEROS ENTEROS
    titulo VARCHAR(50) NOT NULL, 
    descripcion VARCHAR(250) NOT NULL,
    paginas INT UNSIGNED, 
    fecha_publicacion DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
    fecha_creacion DATETIME DEFAULT current_timestamp,
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
);

-- NOT NULL OBLIGA A NODEJAR CAMPOS EN BLANCO
-- UNIQUE VALOR ÚNICO
-- DEFAULT: AÑADE UN VALOR POR DEFECTO
-- UNSIGNED: NO PERMITE NUMEROS NEGATIVOS
-- ENUM: Con enum podemos restringir para que el registro sea un valor especifico de la columna, ej: en género especificaremos que será M o F.
-- PRIMARY KEY: ESTABLECE QUIÉN SERÁ LA LLAVE PRIMARIA Y UTILIZAMOS AUTO_INCREMENT: PORQUE ES UN NÚMERO QUE SE REGISTRARÁ AUTOMATICAMENTE POR CADA REGISTRO

DESC autores; -- DESCRIBIR TABLA AUTORES
DESC libros; -- DESCRIBIR TABLA LIBROS

-- INSERTAR AUTORES
INSERT INTO autores (nombre, apellido, seudonimo, genero, fecha_nacimiento, pais_origen) 
VALUES ("Yonier", "Asprilla", "nano", "M", "1991-11-17", "COL"),
       ("Manuel", "Gomez", "ney", "M", "1992-12-19", "USA"),
       ("Iris", "Sanchez", "mita", "F", "1973-02-09", "COL"),
       ("Lin", "Venecia", "neytor", "F", "1993-04-20", "USA");

INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion) 
VALUES (1, 'Harry Potter y la piedra filosofal', 'El primer libro de la serie de Harry Potter', 223, '1997-06-26'),
       (1, 'Harry Potter y la cámara secreta', 'El segundo libro de la serie de Harry Potter', 251, '1998-07-02'),
       (1, 'Harry Potter y el prisionero de Azkaban', 'El tercer libro de la serie de Harry Potter', 317, '1999-07-08'),
       (1, 'Harry Potter y el cáliz de fuego', 'El cuarto libro de la serie de Harry Potter', 636, '2000-07-08'),
       (1, 'Harry Potter y la orden del fénix', 'El quinto libro de la serie de Harry Potter', 766, '2003-06-21'),
       (1, 'Harry Potter y el misterio del príncipe', 'El sexto libro de la serie de Harry Potter', 607, '2005-07-16'),
       (1, 'Harry Potter y las reliquias de la muerte', 'El séptimo y último libro de la serie de Harry Potter', 607, '2007-07-21'),
       (2, 'El señor de los anillos: La comunidad del anillo', 'El primer libro de la trilogía de El señor de los anillos', 423, '1954-07-29'),
       (2, 'El señor de los anillos: Las dos torres', 'El segundo libro de la trilogía de El señor de los anillos', 352, '1954-11-11'),
       (2, 'El señor de los anillos: El retorno del rey', 'El tercer libro de la trilogía de El señor de los anillos', 416, '1955-10-20');

SELECT * FROM autores;
SELECT * FROM libros;
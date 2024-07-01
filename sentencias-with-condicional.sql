DROP DATABASE IF EXISTS libreria_cf;

CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;

CREATE TABLE IF NOT EXISTS autores (
    autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
    nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
    apellido VARCHAR(50) NOT NULL,
    seudonimo VARCHAR(50) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
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

-- NOT NULL OBLIGA A NO DEJAR CAMPOS EN BLANCO
-- UNIQUE VALOR ÚNICO
-- DEFAULT: AÑADE UN VALOR POR DEFECTO
-- UNSIGNED: NO PERMITE NÚMEROS NEGATIVOS
-- ENUM: Con enum podemos restringir para que el registro sea un valor específico de la columna, ej: en género especificaremos que será M o F.
-- PRIMARY KEY: ESTABLECE QUIÉN SERÁ LA LLAVE PRIMARIA Y UTILIZAMOS AUTO_INCREMENT: PORQUE ES UN NÚMERO QUE SE REGISTRARÁ AUTOMÁTICAMENTE POR CADA REGISTRO

DESC autores; -- DESCRIBIR TABLA AUTORES
DESC libros; -- DESCRIBIR TABLA LIBROS

-- INSERTAR AUTORES
INSERT INTO autores (nombre, apellido, seudonimo, genero, fecha_nacimiento, pais_origen) 
VALUES
    ('J.K.', 'Rowling', 'J.K. Rowling', 'F', '1965-07-31', 'GBR'),
    ('J.R.R.', 'Tolkien', 'J.R.R. Tolkien', 'M', '1892-01-03', 'ZAF'),
    ('Gabriel', 'García Márquez', 'Gabo', 'M', '1927-03-06', 'COL'),
    ('Jane', 'Austen', 'Jane Austen', 'F', '1775-12-16', 'GBR'),
    ('George', 'Orwell', 'George Orwell', 'M', '1903-06-25', 'IND'),
    ('Harper', 'Lee', 'Harper Lee', 'F', '1926-04-28', 'USA'),
    ('F. Scott', 'Fitzgerald', 'F. Scott Fitzgerald', 'M', '1896-09-24', 'USA'),
    ('Fyodor', 'Dostoevsky', 'Fyodor Dostoevsky', 'M', '1821-11-11', 'RUS'),
    ('Miguel', 'de Cervantes', 'Miguel de Cervantes', 'M', '1547-09-29', 'ESP'),
    ('Homero', '', 'Homero', 'M', '0800-01-01', 'GRC'),
    ('James', 'Joyce', 'James Joyce', 'M', '1882-02-02', 'IRL'),
    ('Marcel', 'Proust', 'Marcel Proust', 'M', '1871-07-10', 'FRA'),
    ('Franz', 'Kafka', 'Franz Kafka', 'M', '1883-07-03', 'CZE'),
    ('Albert', 'Camus', 'Albert Camus', 'M', '1913-11-07', 'DZA'),
    ('Jean-Paul', 'Sartre', 'Jean-Paul Sartre', 'M', '1905-06-21', 'FRA'),
    ('Johann Wolfgang von', 'Goethe', 'Goethe', 'M', '1749-08-28', 'DEU'),
    ('Hermann', 'Hesse', 'Hermann Hesse', 'M', '1877-07-02', 'DEU'),
    ('J.D.', 'Salinger', 'J.D. Salinger', 'M', '1919-01-01', 'USA');

-- INSERTAR LIBROS
INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion) 
VALUES 
    (1, 'Harry Potter y la piedra filosofal', 'El primer libro de la serie de Harry Potter', 223, '1997-06-26'),
    (1, 'Harry Potter y la cámara secreta', 'El segundo libro de la serie de Harry Potter', 251, '1998-07-02'),
    (1, 'Harry Potter y el prisionero de Azkaban', 'El tercer libro de la serie de Harry Potter', 317, '1999-07-08'),
    (1, 'Harry Potter y el cáliz de fuego', 'El cuarto libro de la serie de Harry Potter', 636, '2000-07-08'),
    (1, 'Harry Potter y la orden del fénix', 'El quinto libro de la serie de Harry Potter', 766, '2003-06-21'),
    (1, 'Harry Potter y el misterio del príncipe', 'El sexto libro de la serie de Harry Potter', 607, '2005-07-16'),
    (1, 'Harry Potter y las reliquias de la muerte', 'El séptimo y último libro de la serie de Harry Potter', 607, '2007-07-21'),
    (2, 'El señor de los anillos: La comunidad del anillo', 'El primer libro de la trilogía de El señor de los anillos', 423, '1954-07-29'),
    (2, 'El señor de los anillos: Las dos torres', 'El segundo libro de la trilogía de El señor de los anillos', 352, '1954-11-11'),
    (2, 'El señor de los anillos: El retorno del rey', 'El tercer libro de la trilogía de El señor de los anillos', 416, '1955-10-20'),
    (3, 'Cien años de soledad', 'Una de las obras más importantes de la literatura hispanoamericana', 471, '1967-05-30'),
    (3, 'El amor en los tiempos del cólera', 'Una historia de amor que dura más de cincuenta años', 348, '1985-09-05'),
    (4, 'Orgullo y prejuicio', 'Una novela clásica sobre el amor y la sociedad en la Inglaterra del siglo XIX', 279, '1813-01-28'),
    (4, 'Sentido y sensibilidad', 'Un retrato de las costumbres y moralidades de la sociedad británica', 226, '1811-10-30'),
    (5, '1984', 'Una novela distópica sobre una sociedad totalitaria', 328, '1949-06-08'),
    (5, 'Rebelión en la granja', 'Una sátira política sobre la corrupción del poder', 112, '1945-08-17'),
    (6, 'Matar a un ruiseñor', 'Una novela sobre la injusticia racial en el sur de los Estados Unidos', 281, '1960-07-11'),
    (7, 'El gran Gatsby', 'Una crítica a la sociedad estadounidense de los años 20', 180, '1925-04-10'),
    (8, 'Crimen y castigo', 'Una obra sobre la culpa y la redención en la Rusia zarista', 671, '1866-01-01'),
    (8, 'Los hermanos Karamazov', 'Una profunda exploración de la moralidad y la religión', 824, '1880-11-01'),
    (9, 'Don Quijote de la Mancha', 'La historia de un hidalgo que se cree caballero andante', 863, '1605-01-16'),
    (10, 'La Odisea', 'El épico viaje de Ulises de regreso a casa', 541, '0800-01-01'),
    (11, 'Ulises', 'Un relato moderno de un día en la vida de Leopold Bloom', 730, '1922-02-02'),
    (12, 'En busca del tiempo perdido', 'Una serie de novelas sobre la memoria y el tiempo', 4215, '1913-11-14'),
    (13, 'La metamorfosis', 'La historia de un hombre que se transforma en un insecto gigante', 201, '1915-10-01'),
    (14, 'El extranjero', 'Una novela sobre la alienación y la indiferencia', 123, '1942-06-01'),
    (15, 'La náusea', 'Una obra filosófica sobre la existencia y el absurdo', 253, '1938-01-01'),
    (16, 'Fausto', 'La leyenda de un hombre que vende su alma al diablo', 464, '1808-01-01'),
    (17, 'El lobo estepario', 'Una novela sobre la dualidad del ser humano', 237, '1927-01-01'),
    (18, 'El guardián entre el centeno', 'La historia de un adolescente en Nueva York', 277, '1951-07-16');

-- Consultar datos insertados
SELECT * FROM autores;
SELECT * FROM libros;

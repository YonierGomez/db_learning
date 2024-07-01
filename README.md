# Db

## Crear un servidor de base de datos con docker compose

```yaml
services:

  db:
    image: mariadb
    restart: always
    volumes:
      - ./db:/etc/mysql/conf.d
    ports:
      - 3306:3306
    environment:
      MARIADB_ROOT_PASSWORD: neytor


  adminer:
    image: adminer
    restart: always
    ports:
      - 8050:8080
```

### Conectarse a la db

Ejecute el comando `mysql`

```
mysql -u root -h 127.0.0.1 -p
```

> **Observaciones:** Las conexiones con localhost fallan, en su lugar utilice la ip lookback, puede usar localhost en programas como sqlelectrom 

## Variables

Para definir variables (las cuales son de la sesión, es decir que otro usuario no las verá) utilizamos la clausula **set** ejemplo

```mariadb
-- Opcion 1 PREFERIDA
SET @nombre = "Yonier";

-- Opción 2
SET @nombre := "Yonier";

-- Opción 3 multiples variables
SET @nombre = "Yonier", @edad = 13, @juego = "BO4";
```

### Obtener el valor SELECT

Utilizamos la clausula **SELECT**

```mariadb
SELECT @nombre;
```

## SELECT

Esta clausula nos permite obtener datos del servidor.

## Crear db

```mariadb
CREATE DATABASE libreria_cf;
```

### Listar db

Ejecutamos la clausuala `SHOW DATABASES;`

```mariadb
-- COMANDO EJECUTADO
SHOW DATABASES;

+--------------------+
| Database           |
+--------------------+
| information_schema |
| libreria_cf        |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

### Eliminar db

Ejecuta la clausula `DROP DATABASE libreria_cf;`

```mariadb
-- LISTAR DB

SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| libreria_cf        |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

-- ELIMINAR DB

DROP DATABASE libreria_cf;
Query OK, 0 rows affected (0.01 sec)

-- LISTAR DB
SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)
```

## Crear tabla

Antes de crear una tabla es importante definir la **db** con la que se va a trabajar utilizando `USE <DB_NAME>` 

```mariadb
-- CREO DB
CREATE DATABASE libreria_cf;
Query OK, 1 row affected (0.01 sec)

-- USO DB
USE libreria_cf;
Database changed

-- LISTO DB
SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| libreria_cf        |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

### Definir fichero sentencia.sql

#### Creando tabla

```sql
/*
- DEFINIR QUÉ ENTIDADES
- NOMBRE DE LA TABLA: AUTORES
- ¿QUÉ TIPO DE INFORMACIÓN VOY A DEFINIR DE LA ENTIDAD? EJ: NOMBRE, GENERO, FECHA NACIMIENTO, PAÍS DE ORIGEN (ESTAS SON COLUMNAS)

LAS COLUMNAS SE CREAN A PARTIR DE LA INFO A ALMACENAR SEGUIDO DE SU TIPO DE DATO
*/

CREATE TABLE autores (

autor_id INT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50), -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
genero CHAR(1), -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) 

);
```

### Ver en qué tabla estoy trabajando

Ejecuta la función `SELECT DATABASES();`

### Listar y eliminar tablas

#### Listar tabla

```mariadb
SHOW TABLES;
```

#### Eliminar tabla

```mariadb
DROP TABLES autores;
```

### Obtener información de una tabla

Para obtener información de una tabla como sus campos y tipo de datos ejecute `DESC <table-name> o SHOW COLUMNS FROM <table-name>`

```mariadb
-- OPCIÓN 1 PREFERIDA
DESC autores;
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| autor_id         | int(11)     | YES  |     | NULL    |       |
| nombre           | varchar(50) | YES  |     | NULL    |       |
| genero           | char(1)     | YES  |     | NULL    |       |
| fecha_nacimiento | date        | YES  |     | NULL    |       |
| pais_origen      | varchar(40) | YES  |     | NULL    |       |
+------------------+-------------+------+-----+---------+-------+
5 rows in set (0.00 sec)

-- OPCIÓN 2

SHOW COLUMNS FROM autores;
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| autor_id         | int(11)     | YES  |     | NULL    |       |
| nombre           | varchar(50) | YES  |     | NULL    |       |
| genero           | char(1)     | YES  |     | NULL    |       |
| fecha_nacimiento | date        | YES  |     | NULL    |       |
| pais_origen      | varchar(40) | YES  |     | NULL    |       |
+------------------+-------------+------+-----+---------+-------+
5 rows in set (0.00 sec)
```

> **Importante:** DESC es una abreviatura de SHOW COLUMNS por ende es más fácil usar DESC

### Crear tablas a partir de otras

Utilizamos `CREATE TABLE <nueva-tabla> LIKE <tabla-base>;`

```
CREATE TABLE usuarios LIKE autores;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+-----------------------+
| Tables_in_libreria_cf |
+-----------------------+
| autores               |
| usuarios              |
+-----------------------+
2 rows in set (0.00 sec)

mysql> desc usuarios;
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| autor_id         | int(11)     | YES  |     | NULL    |       |
| nombre           | varchar(50) | YES  |     | NULL    |       |
| genero           | char(1)     | YES  |     | NULL    |       |
| fecha_nacimiento | date        | YES  |     | NULL    |       |
| pais_origen      | varchar(40) | YES  |     | NULL    |       |
+------------------+------
```

### Insertar registros en tabla

Utilizaremos la sintaxis `INSERT INTO table-name (columna-donde-registrare, columna2)` el orden es irrelevante

#### Ejemplo de insert no completo

```mariadb
INSERT INTO autores (autor_id, nombre, genero, fecha_nacimiento, pais_origen) 
```

#### Ejemplo de insertar valores

Aquí el orden si es portante

```mariadb
VALUES (1, "Yonier", "Asprilla", "M", "1991-11-17", "COL");
```

#### Ejemplo completo

```mariadb
CREATE TABLE autores (

autor_id INT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50), -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50),
genero CHAR(1), -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) 
);

INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) 
VALUES (1, "Yonier", "Asprilla", "M", "1991-11-17", "COL");
```

### Insertar un segundo registro

No es necesario especificar todas las columnas, solo los valores que deseas registrar, ej:

```mariadb
-- INSERTAR AUTOR 2 CON COLUMNAS ESPECIFICAS
INSERT INTO autores (autor_id, nombre) 
VALUES (2, "Manuel");
```

### Realizar consultas a tabla

Para esto utilizamos la sentencia `SELECT * FROM <table-name>;`

```mariadb
SELECT * FROM autores;
+----------+--------+----------+--------+------------------+-------------+
| autor_id | nombre | apellido | genero | fecha_nacimiento | pais_origen |
+----------+--------+----------+--------+------------------+-------------+
|        1 | Yonier | Asprilla | M      | 1991-11-17       | COL         |
|        2 | Manuel | NULL     | NULL   | NULL             | NULL        |
+----------+--------+----------+--------+------------------+-------------+
2 rows in set (0.00 sec)
```

> **IMPORTANTE:** Esto se lee, selecciona todas las columnas desde la tabla autores

### Insertar múltiples registros

Por cada registro no es necesario hacer un `INSERT INTO` por ej:

```mariadb
CREATE TABLE autores (

autor_id INT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50), -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50),
genero CHAR(1), -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) 

);


-- INSERTAR AUTOR 1
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) 
VALUES (1, "Yonier", "Asprilla", "M", "1991-11-17", "COL"),
       (2, "Manuel", "Gomez", "M", "1992-12-19", "USA"),
       (3, "Iris", "Sanchez", "F", "1973-02-09", "COL");
```

#### Listando registros de la tabla

```mariadb
SELECT * FROM autores;
+----------+--------+----------+--------+------------------+-------------+
| autor_id | nombre | apellido | genero | fecha_nacimiento | pais_origen |
+----------+--------+----------+--------+------------------+-------------+
|        1 | Yonier | Asprilla | M      | 1991-11-17       | COL         |
|        2 | Manuel | Gomez    | M      | 1992-12-19       | USA         |
|        3 | Iris   | Sanchez  | F      | 1973-02-09       | COL         |
+----------+--------+----------+--------+------------------+-------------+
3 rows in set (0.00 sec)
```

## Ejecutar archivo .sql

Cuando tenemos un archivo con esta extensión podemos crear nuestra db, tablas, registros, etc.

```mariadb
/*
- DEFINIR QUÉ ENTIDADES
- NOMBRE DE LA TABLA: AUTORES
- ¿QUÉ TIPO DE INFORMACIÓN VOY A DEFINIR DE LA ENTIDAD? EJ: NOMBRE, GENERO, FECHA NACIMIENTO, PAÍS DE ORIGEN (ESTAS SON COLUMNAS)

LAS COLUMNAS SE CREAN A PARTIR DE LA INFO A ALMACENAR SEGUIDO DE SU TIPO DE DATO
*/
DROP DATABASE libreria_cf;

CREATE DATABASE libreria_cf;

USE libreria_cf;

CREATE TABLE autores (

autor_id INT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50), -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50),
genero CHAR(1), -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) 

);

DESC autores;

-- INSERTAR AUTOR 1
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) 
VALUES (1, "Yonier", "Asprilla", "M", "1991-11-17", "COL"),
       (2, "Manuel", "Gomez", "M", "1992-12-19", "USA"),
       (3, "Iris", "Sanchez", "F", "1973-02-09", "COL");

SELECT * FROM autores;
```

`mysql -u root -h 127.0.0.1 -p < sentencia.sql`

Opción 2 una vez autenticado ejecute

`SOURCE sentencia.sql;`

## Condicionar sentencia

```MARIADB
DROP DATABASE IF EXISTS libreria_cf;

CREATE DATABASE IF NOT EXISTS  libreria_cf;

USE libreria_cf;

CREATE TABLE autores (

autor_id INT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50), -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50),
genero CHAR(1), -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) 

);

DESC autores;

-- INSERTAR AUTOR 1
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) 
VALUES (1, "Yonier", "Asprilla", "M", "1991-11-17", "COL"),
       (2, "Manuel", "Gomez", "M", "1992-12-19", "USA"),
       (3, "Iris", "Sanchez", "F", "1973-02-09", "COL");

SELECT * FROM autores;
```

## Restricciones

### Not null y unique

Especifica que cada campo sea obligatorio

```sql
CREATE TABLE autores (

autor_id INT NOT NULL, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50) NOT NULL,
seudonimo VARCHAR(10) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
genero CHAR(1) NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) NOT NULL

);

-- NOT NULL OBLIGA A NODEJAR CAMPOS EN BLANCO
-- UNIQUE VALOR ÚNICO
```

### Valores por defecto

Se utiliza la sentencia `DEFAULT`

Para este ejemplo crearemos una nueva columna con la fecha de creación y por defecto tomará la fecha actual cuando se cree el registro, `fecha_creacion DATETIME DEFAULT current_timestamp` la fecha la tomaremos con `current_timestamp` 

Ejemplo encontrando la fecha

```sql
-- OPCIÓN 1
SELECT current_timestamp;
+---------------------+
| current_timestamp   |
+---------------------+
| 2024-07-01 16:04:30 |
+---------------------+
1 row in set (0.00 sec)

-- OPCIÓN 2
SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2024-07-01 16:04:37 |
+---------------------+
1 row in set (0.00 sec)
```

Ejemplo completo

```mysql
CREATE TABLE autores (

autor_id INT NOT NULL, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50) NOT NULL,
seudonimo VARCHAR(10) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
genero CHAR(1) NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) NOT NULL,
fecha_creacion DATETIME DEFAULT current_timestamp

);

-- NOT NULL OBLIGA A NODEJAR CAMPOS EN BLANCO
-- UNIQUE VALOR ÚNICO
-- DEFAULT: AÑADE UN VALOR POR DEFECTO
```

### Números negativos

Utilizamos la sentencia UNSIGNED para que no se creen números negativos, ej: Se añade UNSIGNED en la columna autor_id

```mariadb
CREATE TABLE autores (

autor_id INT UNSIGNED NOT NULL, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50) NOT NULL,
seudonimo VARCHAR(10) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
genero CHAR(1) NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) NOT NULL,
fecha_creacion DATETIME DEFAULT current_timestamp

);
```

### Tipo enum

Con enum podemos restringir para que el registro sea un valor especifico de la columna, ej: en género especificaremos que será M o F.

```MARIADB
CREATE TABLE autores (

autor_id INT UNSIGNED NOT NULL, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50) NOT NULL,
seudonimo VARCHAR(10) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
genero ENUM('M', 'F') NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) NOT NULL,
fecha_creacion DATETIME DEFAULT current_timestamp

);
```

### Llaves primarias

Cada registro debe contar con una columna que lo haga único en la tabla, en este caso `autor_id`

Tiene beneficios al contar con la llave primaria ya que la búsqueda se puede realizar bajo este campo, para lograr esto añadiremos `PRIMARY KEY AUTO_INCREMENT` especificamos que autor_id no necesitará de un registro, a medida que se creen estos se hará de manera automatica, por ende cuando voy a crear el registro he removido el apartado **autor_id**

#### Ejemplo completo

```MARIADB
DROP DATABASE IF EXISTS libreria_cf;

CREATE DATABASE IF NOT EXISTS  libreria_cf;

USE libreria_cf;

CREATE TABLE autores (

autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- LLAVE PRIMARIA, INT ALMACENA NÚMEROS ENTEROS
nombre VARCHAR(50) NOT NULL, -- VARCHAR PERMITE ALMACENAR STRING DE 0 A 65535 CARACTERES, PUEDES LIMITAR LA CANTIDAD AÑADIENDO SU VALOR EN EL PARÁMETRO, EJ 50
apellido VARCHAR(50) NOT NULL,
seudonimo VARCHAR(10) UNIQUE, -- ACEPTA NULOS PERO NO AUTORES CON VALORES REPETIDOS
genero ENUM('M', 'F') NOT NULL, -- IGUAL A VARCHAR, CHAR (CADENA ALFANUMERICA) PERO CON MENOR CANTIDAD DE CARACTERES 0 A 255 CARACTERES, EN EL PARÁMETRO 1, GENERO M O F
fecha_nacimiento DATE NOT NULL, -- DATE ALMACENA FECHA, FORMATO AÑO, MES, DÍA
pais_origen VARCHAR(40) NOT NULL,
fecha_creacion DATETIME DEFAULT current_timestamp

);

-- NOT NULL OBLIGA A NODEJAR CAMPOS EN BLANCO
-- UNIQUE VALOR ÚNICO
-- DEFAULT: AÑADE UN VALOR POR DEFECTO
-- UNSIGNED: NO PERMITE NUMEROS NEGATIVOS
-- ENUM: Con enum podemos restringir para que el registro sea un valor especifico de la columna, ej: en género especificaremos que será M o F.
-- PRIMARY KEY: ESTABLECE QUIÉN SERÁ LA LLAVE PRIMARIA Y UTILIZAMOS AUTO_INCREMENT: PORQUE ES UN NÚMERO QUE SE REGISTRARÁ AUTOMATICAMENTE POR CADA REGISTRO

DESC autores;

-- INSERTAR AUTOR 1
INSERT INTO autores (nombre, apellido, genero, fecha_nacimiento, pais_origen) 
VALUES ("Yonier", "Asprilla", "M", "1991-11-17", "COL"),
       ("Manuel", "Gomez", "M", "1992-12-19", "USA"),
       ("Iris", "Sanchez", "F", "1973-02-09", "COL");

-- INSERTAMOS AUTOR CON SEUDONIMO
INSERT INTO autores (nombre, apellido, seudonimo, genero, fecha_nacimiento, pais_origen) 
VALUES ("Yonier", "Asprilla", "neytor", "M", "1991-11-17", "COL");

SELECT * FROM autores;
```

### Llaves foraneas

Sirven para hacer referencias entre tablas, se utiliza la palabra clave `FOREIGN KEY` 

```mariadb
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
```

## Modificar tablas

Con `ALTER TABLE  table-name ADD ventas INT UNSIGNED NOT NULL;` podemos crear una nueva columna

```mariadb
ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL;
```

Aquí un listado de algunas modificaciones que podemos realizar (Las más comunes).

Renombrar tabla.

> Renombrar la tabla usuarios por users.

```mariadb
ALTER TABLE usuarios RENAME users;
```

Agregar una nueva columna.

> Agregar a la tabla usuarios, la columna email de tipo VARCHAR con máximo de 50 caracteres.

```mariadb
ALTER TABLE usuarios ADD email VARCHAR(50);
```

Agregar una nueva columna con constraints.

> Agregar a la tabla usuarios, la columna email, validando su presencia.

```mariadb
ALTER TABLE usuarios ADD email VARCHAR(50) NOT NULL DEFAULT '';
```

> Agregar a la tabla usuarios, la columna email, validando su valor único.

```mariadb
ALTER TABLE tabla ADD columna VARCHAR(50) UNIQUE;
```

Eliminar una columna

> Eliminar la columna email de la tabla usuarios.

```mariadb
ALTER TABLE usuarios DROP COLUMN email;
```

Modificar el tipo de dato de una columna

> Modificar el tipo de dato de la columna teléfono, (tabla usuarios) de INT a VARCHAR, máximo 50 caracteres.

```mariadb
ALTER TABLE usuarios MODIFY telefono VARCHAR(50);
```

Generar una llave primaria.

> Generar una llave primaria a la tabla usuarios.

```mariadb
ALTER TABLE usuarios ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);
```

Agregar llave foránea.

> Agregar una llave foranea a la tabla usuarios, con referencia a la tabla grupos.

```mariadb
ALTER TABLE usuarios ADD FOREIGN KEY(grupo_id) REFERENCES grupos(grupo_id);
```

Eliminar llaves foráneas

> Eliminar la llave foranea grupo_id de la tabla usuarios.
>
> ```mariadb
> ALTER TABLE usuarios DROP FOREIGN KEY grupo_id;
> ```

## Búsquedas, sentencias SQL

### Código completo

```mariadb
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

```

Con **SELECT** podemos obtener valores del servidor

`SELECT * FROM libros;`

`SELECT * FROM libros\G;`

### Buscar todos los registros

```mariadb
SELECT * FROM libros;
+----------+----------+---------------------------------------------------+--------------------------------------------------------------+---------+-------------------+---------------------+
| libro_id | autor_id | titulo                                            | descripcion                                                  | paginas | fecha_publicacion | fecha_creacion      |
+----------+----------+---------------------------------------------------+--------------------------------------------------------------+---------+-------------------+---------------------+
|        1 |        1 | Harry Potter y la piedra filosofal                | El primer libro de la serie de Harry Potter                  |     223 | 1997-06-26        | 2024-07-01 17:49:36 |
|        2 |        1 | Harry Potter y la cámara secreta                  | El segundo libro de la serie de Harry Potter                 |     251 | 1998-07-02        | 2024-07-01 17:49:36 |
|        3 |        1 | Harry Potter y el prisionero de Azkaban           | El tercer libro de la serie de Harry Potter                  |     317 | 1999-07-08        | 2024-07-01 17:49:36 |
|        4 |        1 | Harry Potter y el cáliz de fuego                  | El cuarto libro de la serie de Harry Potter                  |     636 | 2000-07-08        | 2024-07-01 17:49:36 |
|        5 |        1 | Harry Potter y la orden del fénix                 | El quinto libro de la serie de Harry Potter                  |     766 | 2003-06-21        | 2024-07-01 17:49:36 |
|        6 |        1 | Harry Potter y el misterio del príncipe           | El sexto libro de la serie de Harry Potter                   |     607 | 2005-07-16        | 2024-07-01 17:49:36 |
|        7 |        1 | Harry Potter y las reliquias de la muerte         | El séptimo y último libro de la serie de Harry Potter        |     607 | 2007-07-21        | 2024-07-01 17:49:36 |
|        8 |        2 | El señor de los anillos: La comunidad del anillo  | El primer libro de la trilogía de El señor de los anillos    |     423 | 1954-07-29        | 2024-07-01 17:49:36 |
|        9 |        2 | El señor de los anillos: Las dos torres           | El segundo libro de la trilogía de El señor de los anillos   |     352 | 1954-11-11        | 2024-07-01 17:49:36 |
|       10 |        2 | El señor de los anillos: El retorno del rey       | El tercer libro de la trilogía de El señor de los anillos    |     416 | 1955-10-20        | 2024-07-01 17:49:36 |
+----------+----------+---------------------------------------------------+--------------------------------------------------------------+---------+-------------------+---------------------+
10 rows in set (0.00 sec)

```

### Por columnas

```mariadb
SELECT libro_id,titulo FROM libros;
+----------+---------------------------------------------------+
| libro_id | titulo                                            |
+----------+---------------------------------------------------+
|        1 | Harry Potter y la piedra filosofal                |
|        2 | Harry Potter y la cámara secreta                  |
|        3 | Harry Potter y el prisionero de Azkaban           |
|        4 | Harry Potter y el cáliz de fuego                  |
|        5 | Harry Potter y la orden del fénix                 |
|        6 | Harry Potter y el misterio del príncipe           |
|        7 | Harry Potter y las reliquias de la muerte         |
|        8 | El señor de los anillos: La comunidad del anillo  |
|        9 | El señor de los anillos: Las dos torres           |
|       10 | El señor de los anillos: El retorno del rey       |
+----------+---------------------------------------------------+
10 rows in set (0.00 sec)
```

### Obtener mediante condiciones

Utilizamos la sentencia WHERE la condición se hace directamente sobre una columna

```mariadb
SELECT * FROM libros WHERE libro_id = 10;

+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
| libro_id | autor_id | titulo                                       | descripcion                                                 | paginas | fecha_publicacion | fecha_creacion      |
+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
|       10 |        2 | El señor de los anillos: El retorno del rey  | El tercer libro de la trilogía de El señor de los anillos   |     416 | 1955-10-20        | 2024-07-01 17:49:36 |
+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
1 row in set (0.00 sec)	 	  		
```

### Operadores lógicos

Los operadores lógicos son AND, OR, NOT

```mariadb
SELECT * FROM libros WHERE titulo = "El señor de los anillos: El retorno del rey" AND libro_id = 10;
+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
| libro_id | autor_id | titulo                                       | descripcion                                                 | paginas | fecha_publicacion | fecha_creacion      |
+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
|       10 |        2 | El señor de los anillos: El retorno del rey  | El tercer libro de la trilogía de El señor de los anillos   |     416 | 1955-10-20        | 2024-07-01 17:49:36 |
+----------+----------+----------------------------------------------+-------------------------------------------------------------+---------+-------------------+---------------------+
1 row in set (0.00 sec)

```

### Condicionar nulos

Utilizamos IS NOT NULL

```mariadb
-- OPCIÓN 1
SELECT * FROM autores WHERE seudonimo IS NOT NULL;

-- OPCIÓN 2
SELECT * FROM autores WHERE seudonimo <=>;
```

### Buscar por rangos

Todos los libros con fecha de publicación desde x a y ej; `BETWEEN '1954-11-11' AND '1985-09-05';`

```mariadb
SELECT * FROM libros WHERE fecha_publicacion BETWEEN '1954-11-11' AND '1985-09-05';

+----------+----------+----------------------------------------------+-----------------------------------------------------------------------+---------+-------------------+---------------------+
| libro_id | autor_id | titulo                                       | descripcion                                                           | paginas | fecha_publicacion | fecha_creacion      |
+----------+----------+----------------------------------------------+-----------------------------------------------------------------------+---------+-------------------+---------------------+
|        9 |        2 | El señor de los anillos: Las dos torres      | El segundo libro de la trilogía de El señor de los anillos            |     352 | 1954-11-11        | 2024-07-01 20:00:10 |
|       10 |        2 | El señor de los anillos: El retorno del rey  | El tercer libro de la trilogía de El señor de los anillos             |     416 | 1955-10-20        | 2024-07-01 20:00:10 |
|       11 |        3 | Cien años de soledad                         | Una de las obras más importantes de la literatura hispanoamericana    |     471 | 1967-05-30        | 2024-07-01 20:00:10 |
|       12 |        3 | El amor en los tiempos del cólera            | Una historia de amor que dura más de cincuenta años                   |     348 | 1985-09-05        | 2024-07-01 20:00:10 |
|       17 |        6 | Matar a un ruiseñor                          | Una novela sobre la injusticia racial en el sur de los Estados Unidos |     281 | 1960-07-11        | 2024-07-01 20:00:10 |
+----------+----------+----------------------------------------------+-----------------------------------------------------------------------+---------+-------------------+---------------------+
5 rows in set (0.00 sec)
```

### Buscar a través de una lista

Lista


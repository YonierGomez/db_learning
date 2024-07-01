# Db

## Variables

Para definir variables (las cuales son de la sesión, es decir que otro usuario no las verá) utilizamos la clausula **set** ejemplo

```mariadb
#Opcion 1 PREFERIDA
SET @nombre = "Yonier";

#Opción 2
SET @nombre := "Yonier";

#Opción 3 multiples variables
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
#COMANDO EJECUTADO
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
#LISTAR DB

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

#ELIMINAR DB

DROP DATABASE libreria_cf;
Query OK, 0 rows affected (0.01 sec)

#LISTAR DB
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
#CREO DB
CREATE DATABASE libreria_cf;
Query OK, 1 row affected (0.01 sec)

#USO DB
USE libreria_cf;
Database changed

#LISTO DB
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
#OPCIÓN 1 PREFERIDA
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

#OPCIÓN 2

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


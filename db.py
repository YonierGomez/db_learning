import pymysql


DROP_TABLE_USERS = "DROP TABLE IF EXISTS users" 
USERS_TABLE = """CREATE TABLE IF NOT EXISTS users(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )"""


if __name__ == '__main__':

    
    try:
        connect = pymysql.Connect(host='127.0.0.1', port=3306, user='root', passwd='neytor', db="pythondb")
        
        cursor = connect.cursor()
        cursor.execute(DROP_TABLE_USERS)
        cursor.execute(USERS_TABLE)
        
        print("Conexión realizada exitosamente")
    
    except pymysql.err.OperationalError as e:
        print('No se pudo establecer la conexión', e)
        
    finally:
        cursor.close()
        connect.close()
        
        print('Conexiones finalizadas de forma exitosa')
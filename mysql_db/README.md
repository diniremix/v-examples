
# MySQL

Ejemplos usando [MySQL](https://www.mysql.com/) con [V](https://vlang.io/)


## Gnu/linux

Es necesario instalar el paquete de desarrollo de MySQL(`MySQL development`) y `pkg-config`, según tu distribución.

más info por aquí [db.mysql en modules.vlang.io](https://modules.vlang.io/db.mysql.html)

### 🟦 Opción recomendada: Tener **Nix** instalado

Guía oficial:
[https://nixos.org/download](https://nixos.org/download)

e iniciar el entorno de desarrollo con **Nix**

Solo hace falta:

```sh
cd mysql_db
```

```sh
nix develop
```

Esto abre un entorno que contiene:

* `GCC`
* `libmysqlclient`, `mariadb-connector-c`
* Git
* Herramientas necesarias para compilar y ejecutar el proyecto

**No altera tu sistema**, todo es aislado y reproducible.

una vez dentro de Nix:

### usando raw queries
```sh
$ v run mysql_demo.v
```

### usando orm de V
```sh
# requerda crear el archivo `.env` antes
$ v run mysql_orm.v
```

### pool de conexiones
```sh
# requerda crear el archivo `.env` antes
$ v mysql_orm.v -d fpool -o mysql_orm
$ ./mysql_orm
```


## Windows

Para Windows, descarga e instala **MySQL Installer**.

a continuación, copia las carpetas `include` y `lib` en el directorio de instalación de V.

`V_HOME\thirdparty\mysql`

más info por aquí [db.mysql en modules.vlang.io](https://modules.vlang.io/db.mysql.html)

el ejecutable generado necesita estas librerias, en la misma carpeta
- libmysql.dll
- libssl-3-x64.dll
- libcrypto-3-x64.dll
- vcruntime140.dll

adicionalmente puede requerir [Microsoft Visual C++ 2015 - 2022 Redistributable](https://learn.microsoft.com/en-us/answers/questions/4269238/vcruntime140-dll-and-msvcp140-dll-missing-in-windo)

### usando raw queries
```sh
$ v.exe run mysql_demo.v
```

### usando orm de V
```sh
# requerda crear el archivo `.env` antes
$ v.exe run mysql_orm.v
```

### pool de conexiones
```sh
# requerda crear el archivo `.env` antes
$ v.exe mysql_orm.v -d fpool -o mysql_orm
$ ./mysql_orm.exe
```


## variables de conexion

crea un archivo llamado `.env`, con las siguientes variables

```env
MYSQL_USERNAME=awesome_user
MYSQL_PASS=awesome_pass
MYSQL_CLUSTER=localhost
MYSQL_DB=awesome_db
```

/* 
SCRIPT DE CREACION DE TABLAS
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/
 
CREATE SCHEMA if not exists STARTUP_BICICLETAS;

USE STARTUP_BICICLETAS;

/*Tabla de usuarios encargados de mantener la base de datos*/

CREATE TABLE if not exists USUARIOS (
id_usuario INT NOT NULL auto_increment,
nombre_usuario varchar(15) not null,
dni int not null,
nombre varchar(15) not null,
apellido varchar(15) not null,
nombre_usuario_ins varchar(15) NOT NULL,
fch_ins datetime NOT NULL,
nombre_usuario_upd varchar(15),
fch_upd  datetime,
primary key(id_usuario)
);

/* Tabla de ciclista, son los usuarios del servicio */

CREATE TABLE if not exists CICLISTAS (
id_ciclista INT NOT NULL auto_increment,
DNI INT not null,
nombre varchar(15) not null,
apellido varchar(15) not null,
Correo varchar(50) not null,
telefono varchar(50) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_ciclista)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

/* Tabla de tipos de bicicletas, son los tipos de bicicletas que pueden ser alquiladas */

CREATE TABLE if not exists TIPO_BICICLETAS (
id_tipo_bicicli INT NOT NULL auto_increment,
modelo varchar(12) not null,
descrip varchar(30) not null,
mult_tarifa decimal(3,2) not null, -- valor por el cual se multiplica el tiempo de uso.
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_tipo_bicicli)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

/*Tabla estado, indica el estado en el que se encuentra el uso del servicio
Ejemplo, "iniciado" o "Concluido". */

CREATE TABLE if not exists ESTADO (
id_estado INT NOT NULL auto_increment,
estado varchar(15) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_estado)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

/* Tabla tarifa, es la tabla que se toma de referencia para indicar el valor del alquiler.
	en la cual se toma como referencia el tiempo desde que se inicio el uso del servicio hasta que concluyo. */

CREATE TABLE if not exists TARIFA (
id_tarifa INT NOT NULL auto_increment,
descrip varchar(30) not null,
valor_x_tiempo int,   -- valor por cual se multiplica el tiempo para calcular el valor del servicio 
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_tarifa)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

/*Tabla estaciones, se encuentra listadas las estaciones donde se pueden dejar o 
dejar las bicicletas*/

CREATE TABLE if not exists ESTACIONES (
id_estacion INT NOT NULL auto_increment,
nombre_estacion varchar(30) not null,
direccion_estacion varchar(50) not null,
lat_estacion decimal(9,6) not null,
long_estacion decimal(9,6) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_estacion)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);


/* Tabla Usos bicicletas, es la tabla donde se lleva el registro de todos los usos por
parte de los ciclistas.
Los registros se insertan de manera automática una ves que el usuarios retira la bicicleta de la estación de origen.
Y se actualizan una vez que la bicicleta es dejada en la estación de destino. */

CREATE TABLE if not exists Usos_bicicletas (
id_uso INT NOT NULL auto_increment,
fecha_origen datetime not null,
id_estacion_origen INT not null,
fecha_destino datetime not null,
id_estacion_destino INT not null,
id_ciclista INT not null,
id_tarifa INT,
id_estado INT not null,
id_tipo_bicicli INT not null,
primary key(id_uso),
foreign key(id_estacion_origen) references ESTACIONES(id_estacion),
foreign key(id_estacion_destino) references ESTACIONES(id_estacion),
foreign key(id_ciclista) references CICLISTAS(id_ciclista),
foreign key(id_tarifa) references TARIFA(id_tarifa),
foreign key(id_estado) references ESTADO(id_estado),
foreign key(id_tipo_bicicli) references TIPO_BICICLETAS(id_tipo_bicicli)
);

-- drop schema STARTUP_BICICLETAS;   


/* 
SCRIPT DE CREACION DE TABLAS
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/
 
CREATE SCHEMA if not exists STARTUP_BICICLETAS;

USE STARTUP_BICICLETAS;

/* Tabla de ciclista, son los usuarios del servicio */

CREATE TABLE if not exists CICLISTAS (
id_ciclista INT NOT NULL auto_increment,
DNI INT not null,
nombre varchar(15) not null,
apellido varchar(15) not null,
Correo varchar(50) not null,
telefono varchar(50) not null,
usuario_ins VARCHAR(100) NOT NULL,
fch_ins datetime NOT NULL,
usuario_upd VARCHAR(100),
fch_upd  datetime,
primary key(id_ciclista)
);

/* Tabla de tipos de bicicletas, son los tipos de bicicletas que pueden ser alquiladas */

CREATE TABLE if not exists TIPO_BICICLETAS (
id_tipo_bicicli INT NOT NULL auto_increment,
modelo varchar(12) not null,
descrip varchar(30) not null,
mult_tarifa decimal(3,2) not null, -- valor por el cual se multiplica el tiempo de uso.
usuario_ins VARCHAR(100) NOT NULL,
fch_ins datetime NOT NULL,
usuario_upd VARCHAR(100),
fch_upd  datetime,
primary key(id_tipo_bicicli)
);

/*Tabla estado, indica el estado en el que se encuentra el uso del servicio
Ejemplo, "iniciado" o "Concluido". */

CREATE TABLE if not exists ESTADO (
id_estado INT NOT NULL auto_increment,
estado varchar(15) not null,
usuario_ins VARCHAR(100) NOT NULL,
fch_ins datetime NOT NULL,
usuario_upd VARCHAR(100),
fch_upd  datetime,
primary key(id_estado)
);

/* Tabla tarifa, es la tabla que se toma de referencia para indicar el valor del alquiler.
	en la cual se toma como referencia el tiempo desde que se inicio el uso del servicio hasta que concluyo. */

CREATE TABLE if not exists TARIFA (
id_tarifa INT NOT NULL auto_increment,
descrip varchar(30) not null,
mins_min int, -- Cantidad de minutos min para la categoria.
mins_max int, -- Cantidad de minutos max para la categoria.
valor_x_tiempo decimal(3,2) not null,   -- valor por cual se multiplica el tiempo para calcular el valor del servicio 
usuario_ins VARCHAR(100) NOT NULL,
fch_ins datetime NOT NULL,
usuario_upd VARCHAR(100),
fch_upd  datetime,
primary key(id_tarifa)
);

/*Tabla estaciones, se encuentra listadas las estaciones donde se pueden tomar o 
dejar las bicicletas*/

CREATE TABLE if not exists ESTACIONES (
id_estacion INT NOT NULL auto_increment,
nombre_estacion varchar(30) not null,
direccion_estacion varchar(50) not null,
lat_estacion decimal(9,6) not null,
long_estacion decimal(9,6) not null,
usuario_ins VARCHAR(100) NOT NULL,
fch_ins datetime NOT NULL,
usuario_upd VARCHAR(100),
fch_upd  datetime,
primary key(id_estacion)
);


/* Tabla Usos bicicletas, es la tabla donde se lleva el registro de todos los usos por
parte de los ciclistas.
Los registros se insertan de manera automática una vez que el usuarios retira la bicicleta de la estación de origen.
Y se actualizan una vez que la bicicleta es dejada en la estación de destino. */

CREATE TABLE if not exists Usos_bicicletas (
id_uso INT NOT NULL auto_increment,
fecha_origen datetime not null,
id_estacion_origen INT not null,
fecha_destino datetime,
id_estacion_destino INT ,
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


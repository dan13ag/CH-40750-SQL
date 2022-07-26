-- PRIMERA ENTREGA DEL PROYECTO FINAL
-- Comisión: 40750
-- Alumno: Daniel Angulo
-- Tema: EMPRESA DE TRANSPORTE PRIVADO.
 
CREATE SCHEMA if not exists TRANSPORTE_PRIVADO;

USE TRANSPORTE_PRIVADO;

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

CREATE TABLE if not exists CHOFERES (
id_chofer INT NOT NULL auto_increment,
nro_licencia varchar(12) not null,
fch_vigencia date not null,
nombre varchar(15) not null,
apellido varchar(15) not null,
fch_nacimiento date not null,
fch_ingreso date not null,
fch_egreso date,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_chofer)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

CREATE TABLE if not exists CATEGORIA (
id_categoria INT NOT NULL auto_increment,
descrip varchar(12) not null,
mult_tarifa float(3,2) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_categoria)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

CREATE TABLE if not exists VEHICULOS (
id_vehiculo INT NOT NULL auto_increment,
patente varchar(15) not null,
id_categoria INT not null,
marca varchar(15) not null,
año INT not null,
fch_compra date not null,
fch_venta date,
kilometraje_inicial INT not null,
kilometraje_actual INT not null,
condicion_actual varchar(15),
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_vehiculo),
foreign key(id_categoria) references CATEGORIA(id_categoria)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);


CREATE TABLE if not exists DOCUMENTACION (
id_documentacion INT not null auto_increment,
id_vehiculo INT not null,
id_chofer INT not null,
tipo varchar(15) not null,
numero varchar(15) not null,
fch_vigencia date not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_documentacion),
foreign key(id_vehiculo) references VEHICULOS(id_vehiculo),
foreign key(id_chofer) references CHOFERES(id_chofer)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

/*
CREATE TABLE if not exists MANTENIMIENTO(
id_mantenimiento INT NOT NULL auto_increment,
id_vehiculo INT NOT NULL,
tipo varchar(12) not null,
fch date not null,
condicion_inicial varchar(15) not null,
condicion_final varchar(15) not null,
observacion varchar(15),
primary key(id_mantenimiento),
foreign key(id_vehiculo) references VEHICULOS(id_vehiculo)
);
*/

CREATE TABLE if not exists EMPRESAS(
id_empresa INT NOT NULL auto_increment,
cuit INT NOT NULL,
razon_social varchar(30) not null,
fch_alta date not null,
email varchar(30) not null,
direccion varchar(50) not null,
telefono varchar(30) not null,
contacto varchar(30) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_empresa)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

CREATE TABLE if not exists CLIENTES(
id_cliente INT NOT NULL auto_increment,
dni INT NOT NULL,
id_empresa INT NOT NULL,
fch_alta date not null,
nombre varchar(15) not null,
apellido varchar(15) not null,
direccion varchar(50) not null,
telefono varchar(15) not null,
email varchar(30) not null,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_cliente),
foreign key(id_empresa) references EMPRESAS(id_empresa)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

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

CREATE TABLE if not exists TARIFA (
id_tarifa INT NOT NULL auto_increment,
descrip varchar(15) not null,
valor_x_km int,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_tarifa)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

CREATE TABLE if not exists VIAJES (
id_viaje INT NOT NULL auto_increment,
id_cliente INT not null,
id_chofer INT not null,
id_vehiculo INT not null,
id_tarifa INT not null,
id_estado INT not null,
fch_solicitud date not null,
origen varchar(15) not null,
Codigo_postal_org varchar(15) not null,
destino varchar(15) not null,
Codigo_postal_dest varchar(15) not null,
fch_hr_inicio datetime not null,
fch_hr_inicio_real datetime,
fch_hr_fin datetime,
distancia_recorrida INT,
id_usuario_ins INT NOT NULL,
fch_ins datetime NOT NULL,
id_usuario_upd INT,
fch_upd  datetime,
primary key(id_viaje),
foreign key(id_cliente) references CLIENTES(id_cliente),
foreign key(id_chofer) references CHOFERES(id_chofer),
foreign key(id_vehiculo) references VEHICULOS(id_vehiculo),
foreign key(id_tarifa) references TARIFA(id_tarifa),
foreign key(id_estado) references ESTADO(id_estado)
-- foreign key(id_usuario_ins) references USUARIOS(id_usuario),
-- foreign key(id_usuario_upd) references USUARIOS(id_usuario)
);

-- drop schema TRANSPORTE_PRIVADO;   







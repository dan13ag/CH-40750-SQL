/* 
SCRIPT DE CREACION DE TRIGGERS
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/
 
USE startup_bicicletas;

drop table if exists LOG_USOS ;

CREATE TABLE IF NOT EXISTS LOG_USOS
(
ID_LOG INT AUTO_INCREMENT ,-- pk de la tabla 
NOMBRE_DE_ACCION VARCHAR(10) ,-- indica si es insert , update ,delete
-- NOMBRE_TABLA VARCHAR(50) ,-- provincia , class , departamento , etc..
USUARIO VARCHAR(100) , -- quien ejecuta la sentencia DML
FECHA_UPD_INS_DEL datetime ,
id_uso int, -- momento exacto en el que se genera DML
id_ciclista int , 
id_estacion int , -- estacion
PRIMARY KEY (ID_LOG)
)
;

DROP TRIGGER if exists TRG_LOG_USOS_INSERT ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_USOS_INSERT AFTER INSERT ON startup_bicicletas.usos_bicicletas
FOR EACH ROW 
BEGIN

INSERT INTO LOG_USOS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL ,id_uso, id_ciclista ,id_estacion)
VALUES ('INSERT' ,CURRENT_USER(), NOW(),NEW.id_uso,NEW.id_ciclista,NEW.id_estacion_origen);
       
END//
DELIMITER ;

DROP TRIGGER if exists TRG_LOG_USOS_UPDATE ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_USOS_UPDATE BEFORE UPDATE ON startup_bicicletas.usos_bicicletas
FOR EACH ROW 
BEGIN

INSERT INTO LOG_USOS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL ,id_uso, id_ciclista ,id_estacion)
VALUES ('UPDATE' ,CURRENT_USER(), NOW(),OLD.id_uso,OLD.id_ciclista,NEW.id_estacion_destino);
       
END//
DELIMITER ;

DROP TRIGGER if exists TRG_LOG_USOS_DELETE ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_USOS_DELETE BEFORE DELETE ON startup_bicicletas.usos_bicicletas
FOR EACH ROW 
BEGIN

INSERT INTO LOG_USOS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL ,id_uso, id_ciclista ,id_estacion)
VALUES ('DELETE' ,CURRENT_USER(), NOW(),OLD.id_uso,OLD.id_ciclista,OLD.id_estacion_destino);
       
END//
DELIMITER ;


drop table if  exists LOG_CICLISTAS;

CREATE TABLE IF NOT EXISTS LOG_CICLISTAS 
(
ID_LOG INT AUTO_INCREMENT ,-- pk de la tabla 
NOMBRE_DE_ACCION VARCHAR(10) not null,-- indica si es insert , update ,delete
-- NOMBRE_TABLA VARCHAR(50) ,-- provincia , class , departamento , etc..
USUARIO VARCHAR(100) not null, -- quien ejecuta la sentencia DML
FECHA_UPD_INS_DEL DATE not null, -- momento exacto en el que se genera DML
ID_CICLISTA int not null, 
CAMBIO VARCHAR(500),
PRIMARY KEY (ID_LOG)
)
;

DROP TRIGGER if exists TRG_LOG_CICLISTAS_INSERT ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_CICLISTAS_INSERT AFTER INSERT ON startup_bicicletas.ciclistas
FOR EACH ROW 
BEGIN

INSERT INTO LOG_CICLISTAS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL, ID_CICLISTA)
VALUES ('INSERT' ,CURRENT_USER(), NOW(), NEW.id_ciclista);
       
END//
DELIMITER ;

DROP TRIGGER if exists TRG_LOG_CICLISTAS_UPDATE ;

DELIMITER //
CREATE TRIGGER  TRG_LOG_CICLISTAS_UPDATE BEFORE UPDATE ON startup_bicicletas.ciclistas
FOR EACH ROW 
BEGIN

IF NEW.Correo <> OLD.Correo AND NEW.telefono <> OLD.telefono  then
INSERT INTO LOG_CICLISTAS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL, ID_CICLISTA, CAMBIO)
VALUES ('UPDATE' ,CURRENT_USER(), NOW(),OLD.id_ciclista,CONCAT("Anterior - Correo : ",OLD.Correo,"| telefono: ",  OLD.telefono))
;

ELSEIF NEW.Correo <> OLD.Correo THEN
	INSERT INTO LOG_CICLISTAS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL, ID_CICLISTA, CAMBIO)
	VALUES ('UPDATE' ,CURRENT_USER(), NOW(),OLD.id_ciclista,CONCAT("Anterior - Correo : ",OLD.Correo))
    ;

ELSE 

INSERT INTO LOG_CICLISTAS (NOMBRE_DE_ACCION , USUARIO, FECHA_UPD_INS_DEL, ID_CICLISTA, CAMBIO)
VALUES ('UPDATE' ,CURRENT_USER(), NOW(),OLD.id_ciclista,CONCAT( "Anterior - telefono : ",  OLD.telefono))
;

END IF;
	
END//
DELIMITER ;




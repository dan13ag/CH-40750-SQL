/* 
SCRIPT DE CREACION DE FUNCIONES
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/
 
USE startup_bicicletas;

drop function if exists FN_CALCULO_TARIFA ;

/* FN_CALCULO_TARIFA: Permite obtener el id_tarifa a insertar en la tabla usos_bicicletas
  en función del tiempo de uso del servicio. */ 
DELIMITER // 
CREATE FUNCTION FN_CALCULO_TARIFA( DATA1 datetime , DATE2 datetime) 
RETURNS int
DETERMINISTIC
BEGIN 
SET @RES_DIFF=0;
SET @RES_SELECT = 0; 		

SELECT TIMESTAMPDIFF( MINUTE ,DATA1,DATE2) INTO @RES_DIFF; -- tiempo de usos en minutos

SELECT id_tarifa into @RES_SELECT
FROM tarifa
WHERE (mins_min <= @RES_DIFF and mins_max > @RES_DIFF) OR ( mins_min <= @RES_DIFF and mins_max is null) ;

RETURN @RES_SELECT ;
END 
// DELIMITER ;

drop function if exists FN_CANT_USOS_CICL_ESTACION ; 

/*FN_CANT_USOS_CICL_ESTACION: Permite calcular la cantidad de veces que un ciclista, utilizo una estación.
Se suma la cantidad de veces que uso la estación como origen o destino.  */

DELIMITER // 
CREATE FUNCTION FN_CANT_USOS_CICL_ESTACION( CICLISTA INT , ESTACION INT) 
RETURNS int
DETERMINISTIC
BEGIN 
SET @RES_ORIG=0;
SET @RES_DEST=0;
SET @RES_SELECT = 0; 		

SELECT count(*) into @RES_ORIG   -- cantidad usos como estacion de origen
FROM usos_bicicletas
WHERE id_ciclista = CICLISTA and id_estacion_origen = ESTACION;

SELECT count(*) into @RES_DEST -- cantidad usos como estacion de destino
FROM usos_bicicletas
WHERE id_ciclista = CICLISTA and id_estacion_destino = ESTACION;

SELECT  @RES_ORIG + @RES_DEST  INTO @RES_SELECT; -- total de usos

RETURN @RES_SELECT ;
END 
// DELIMITER 





/* 
SCRIPT DE CREACION DE PROCEDIMIENTOS (SP)
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/
 
USE startup_bicicletas;

drop PROCEDURE if exists sp_orden_tabla_uso ;

/* sp_orden_tabla_uso: permite ordenar la tabla usos_bicicletas en función del número índice de la columna ingresada
 y el tipo de ordenamiento deseado.
Valores permitidos:
- ind_column [1..9]
- orden ['ASC', 'DESC']*/

DELIMITER $$
CREATE PROCEDURE sp_orden_tabla_uso(
    IN  ind_column INT, 
    IN orden  VARCHAR(10))
BEGIN
   
SET @columna = ind_column;
SET @orden = orden;
if (ind_column >= 1 AND  ind_column <= 9) AND (  UPPER(orden) = 'ASC' OR UPPER(orden) = 'DESC')THEN
			
            SET @F1 := concat('select * from startup_bicicletas.usos_bicicletas order by ',@columna,' ',@orden);
ELSE
	
    SET @F1 = concat('select "Ingresar un parámetro correcto" as Mensaje');
END IF;

PREPARE runSQL FROM @F1;
EXECUTE runSQL;
DEALLOCATE PREPARE runSQL;
END$$
DELIMITER ;

drop PROCEDURE if exists sp_insert_uso_bicicleta ;


/* sp_insert_uso_bicicleta: permite ingresar un nuevo registro a la tabla usos_bicicletas, 
para dejar registro del inicio del servicio */

DELIMITER //
Create PROCEDURE sp_insert_uso_bicicleta(IN INS_id_estacion_origen int, IN INS_id_ciclista int,IN INS_id_tipo_bicicli int)
BEGIN
   insert into usos_bicicletas(fecha_origen, id_estacion_origen, id_ciclista, id_estado,id_tipo_bicicli) 
		values (now(), INS_id_estacion_origen,INS_id_ciclista, 1, INS_id_tipo_bicicli);
END //

DELIMITER ;

drop PROCEDURE if exists sp_update_uso_bicicleta ;

/* sp_update_uso_bicicleta: permite actualizar registro en la tabla usos_bicicletas para dar cierre al uno del servicio.
Para esto se ingresar el id_uso el registro que se desea actualizar y el id_estacion_destino */
DELIMITER //
Create PROCEDURE sp_update_uso_bicicleta(IN UP_id_uso int, IN UP_id_estacion_destino int)
BEGIN
  set @FECHAOR = 0;
  set @id_uso_UP = UP_id_uso;
  set @id_estacion_destino_UP = UP_id_estacion_destino;
  select fecha_origen into @FECHAOR 
  from usos_bicicletas
  where id_uso = @id_uso_UP;
  set @idtari = 0;
  select FN_CALCULO_TARIFA( @FECHAOR ,now()) into @idtari;
  
  SET @query = '
    UPDATE usos_bicicletas
    SET fecha_destino = now(),
        id_estacion_destino = ?,
        id_tarifa = ?,
        id_estado = 2
    WHERE id_uso = ?';
  PREPARE stmt FROM @query;
  EXECUTE stmt USING  @id_estacion_destino_UP, @idtari, @id_uso_UP;
  DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

/* 
SCRIPT DE SENTENCIAS DEL SUBLENGUAJE TCL
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/

USE startup_bicicletas;
-- SELECT @@autocommit;
SET @@autocommit = 0;

/*
1ra PARTE:
1. En la primera tabla, si tiene registros, deberás eliminar algunos de ellos iniciando previamente una transacción. Si no tiene registros la tabla, reemplaza eliminación por inserción.
2. Deja en una línea siguiente, comentado la sentencia Rollback, y en una línea posterior, la sentencia Commit.
3. Si eliminas registros importantes, deja comenzado las sentencias para re-insertarlos.
*/

START TRANSACTION ;

-- Verifico los registros:

-- SELECT * FROM startup_bicicletas.usos_bicicletas 
-- WHERE id_ciclista = 66 AND id_estacion_destino = 7 AND fecha_origen between '2021-11-26 00:00:00' AND  '2021-11-27 00:00:00';

DELETE  FROM startup_bicicletas.usos_bicicletas
WHERE id_ciclista = 66 AND id_estacion_destino = 7 AND fecha_origen between '2021-11-26 00:00:00' AND  '2021-11-27 00:00:00';

-- ROLLBACK;
COMMIT; 

/*
2da PARTE:
1. En la segunda tabla, inserta ocho nuevos registros iniciando también una transacción. 
2. Agrega un savepoint a posteriori de la inserción del registro #4 y otro savepoint a posteriori del registro #8
3. Agrega en una línea comentada la sentencia de eliminación del savepoint de los primeros 4 registros insertados
*/

START TRANSACTION;

INSERT INTO `usuarios` VALUES (null,'CBloom',27531998,'Christine','Bloom',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'ATaylors',94885857,'Ardiths','Taylor',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'OAllatts',95168915,'OttoS','Allatts',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'DGoggey',45829234,'DierdrEe','Goggey',CURRENT_USER(),now(),NULL,NULL);
SAVEPOINT sp1;

INSERT INTO `usuarios` VALUES (null,'MLarne',45573112,'Marillin','Larne',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'JDies',52397458,'Jewel','Dies',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'ALemm',49255472,'Aileen','Lemm',CURRENT_USER(),now(),NULL,NULL);
INSERT INTO `usuarios` VALUES (null,'NLowrance',45753112,'Nelson','Lowrance',CURRENT_USER(),now(),NULL,NULL);
SAVEPOINT sp2;

-- ROLLBACK TO sp1;
-- ROLLBACK;

COMMIT; 

/* 
SCRIPT DE CREACION DE VISTAS
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/

USE STARTUP_BICICLETAS;

/* top 15 de ciclistas que más usaron el servicio */
CREATE OR REPLACE VIEW top_15_UsosXciclistas AS(
SELECT  
c.id_ciclista,
c.nombre,
c.apellido,
count(u.id_uso) as cant_usos
FROM usos_bicicletas u
inner join startup_bicicletas.ciclistas c on u.id_ciclista = c.id_ciclista  
group by id_ciclista
order by count(u.id_uso) desc
limit 15
)
;

/* top 5 de estaciones más usadas como origen */
CREATE OR REPLACE VIEW top_5_Usosxestacion_origen AS (
SELECT  
e.id_estacion,
e.nombre_estacion as 'Nombre Estacion Origen',
count(u.id_uso) as cant_usos
FROM usos_bicicletas u
inner join estaciones e on u.id_estacion_origen = e.id_estacion  
group by u.id_estacion_origen
order by count(u.id_uso) desc
limit 5
);

/* top 5 de estaciones más usadas como destino */
CREATE OR REPLACE VIEW top_5_Usosxestacion_destino AS (
SELECT  
e.id_estacion,
e.nombre_estacion as 'Nombre Estacion Destino',
count(u.id_uso) as cant_usos
FROM usos_bicicletas u
inner join estaciones e on u.id_estacion_destino = e.id_estacion  
group by u.id_estacion_destino
order by count(u.id_uso) desc
limit 5
);

/* top 5 de estaciones más usadas */
CREATE OR REPLACE VIEW top_5_Usosxestacion AS (
SELECT  
e.id_estacion,
e.nombre_estacion,
count(u.id_uso) + ed.cant_usos as total_usos,
count(u.id_uso) as cant_usos_origen,
ed.cant_usos as cant_usos_destino
FROM usos_bicicletas u
inner join estaciones e on u.id_estacion_origen = e.id_estacion  
inner join (SELECT  
				u.id_estacion_destino,
				count(u.id_uso) as cant_usos
				FROM usos_bicicletas u  
				group by u.id_estacion_destino
				) ed on u.id_estacion_origen = ed.id_estacion_destino 
group by u.id_estacion_origen
order by total_usos desc
limit 5
)
;

/* top 10 de ciclistas que más tiempo han usado el servicio */
CREATE OR REPLACE VIEW top_10_Ciclistas_por_tiempo AS(
SELECT u.id_ciclista,c.nombre,c.apellido, sum(TIMESTAMPDIFF(minute,fecha_origen,fecha_destino)) as tiempo_min
 FROM startup_bicicletas.usos_bicicletas as u
 inner join ciclistas as c on u.id_ciclista = c.id_ciclista
 group by id_ciclista
 order by tiempo_min desc
 limit 10);



/* Ciclista que más a usada cada estación */
CREATE OR REPLACE VIEW top_1_Ciclistas_por_estacion_de_org AS(

with top1_ciclista_por_estacion as(
SELECT  
u.id_estacion_origen,
(select ct.id_ciclista from
	(select 
	uc.id_ciclista, uc.id_estacion_origen, count(uc.id_uso) as cant_usos
	FROM usos_bicicletas uc
	where u.id_estacion_origen = uc.id_estacion_origen 
    group by id_estacion_origen,id_ciclista
    order by count(uc.id_uso) desc
    limit 1) ct ) as 'id_ciclista',
   
(select ct.cant_usos from
	(select 
	uc.id_ciclista, uc.id_estacion_origen, count(uc.id_uso) as cant_usos
	FROM usos_bicicletas uc
	inner join ciclistas ci on uc.id_ciclista = ci.id_ciclista  
    where u.id_estacion_origen = uc.id_estacion_origen
    group by id_estacion_origen,id_ciclista
    order by count(uc.id_uso) desc
    limit 1) ct ) as 'cant_usos'
from usos_bicicletas u
group by u.id_estacion_origen)

select 
	ce.id_estacion_origen, e.nombre_estacion ,ce.id_ciclista, c.nombre,c.apellido, ce.cant_usos
	from top1_ciclista_por_estacion ce 
    inner join estaciones e on ce.id_estacion_origen = e.id_estacion
    inner join ciclistas c on ce.id_ciclista = c.id_ciclista
	order by  id_estacion_origen
 )   ;

/* Usos por mes y tipo de biciletas */
CREATE OR REPLACE VIEW usos_por_mes_y_tipo AS(

SELECT year(V.fecha_origen)*100+month(V.fecha_origen)as perido,
count( if ( v.id_tipo_bicicli = 1,1,null)) as Usos_ICONIC,
count( if ( v.id_tipo_bicicli = 2,1,null)) as Usos_FIT,
count(v.id_uso) as total_usos
FROM usos_bicicletas as V
group by year(V.fecha_origen)*100+month(V.fecha_origen)
order by perido);
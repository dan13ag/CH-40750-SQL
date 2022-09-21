/* 
SCRIPT DE IMPLEMENTACIÓN DE SENTENCIAS
Comisión: 40750
Alumno: Daniel Angulo
Tema: STARTUP DE ALQUILER DE BICICLETAS.
*/

USE mysql;

/* Creación del usuario de "SB_analista1", solo tendrá permiso a consultar las tablas.
sentencia para crear usuario y se le asigna la contraseña. */

create user if not exists 'SB_analista1'@'localhost' IDENTIFIED BY 'acb123.';

-- drop user 'SB_analista1'@'localhost';
-- show grants for 'analista1'@'localhost';

/* se le otorgan los permisos de lectura solo de las tablas. */
grant select on startup_bicicletas.ciclistas to 'SB_analista1'@'localhost'; 
grant select on startup_bicicletas.estaciones to 'SB_analista1'@'localhost';
grant select on startup_bicicletas.estado to 'SB_analista1'@'localhost';
grant select on startup_bicicletas.tarifa to 'SB_analista1'@'localhost';
grant select on startup_bicicletas.tipo_bicicletas to 'SB_analista1'@'localhost';
grant select on startup_bicicletas.usos_bicicletas to 'SB_analista1'@'localhost';

-- show grants for 'analista1'@'localhost';

/* Creación del usuario de "SB_admin1", el cual tendrá permisos de leer, insertar y modificar registros.
 sentencia para crear usuario y se le asigna la contraseña. */
create user if not exists 'SB_admin1'@'localhost' IDENTIFIED BY 'acb123.';

-- drop user 'SB_admin1'@'localhost';

/* Se le otorgan los permisos de lectura, inserción y modificación solo de las tablas. */
grant select, INSERT, UPDATE on startup_bicicletas.ciclistas to 'SB_admin1'@'localhost'; 
grant select, INSERT, UPDATE on startup_bicicletas.estaciones to 'SB_admin1'@'localhost';
grant select, INSERT, UPDATE on startup_bicicletas.estado to 'SB_admin1'@'localhost';
grant select, INSERT, UPDATE on startup_bicicletas.tarifa to 'SB_admin1'@'localhost';
grant select, INSERT, UPDATE on startup_bicicletas.tipo_bicicletas to 'SB_admin1'@'localhost';
grant select, INSERT, UPDATE on startup_bicicletas.usos_bicicletas to 'SB_admin1'@'localhost';

-- show grants for 'SB_admin1'@'localhost';





use base_consorcio;

--NOTA: Es mejor probar en querys diferentes para evitar algun problema
/*

Testeo el funciomiento del role de analista
*/

EXECUTE AS USER = 'UsuarioAnalista';
SELECT * FROM conserje;

/*
Ejemplo de lo que no puede hacer
CREATE TABLE tablaEjemplo1 (ID INT, Nombre VARCHAR(50));
*/

REVERT;



/*
Testeo el funcionamiento del role de diseñador
*/
EXECUTE AS USER = 'UsuarioDisenador';
CREATE TABLE tablaEjemplo (ID INT, Nombre VARCHAR(50));
ALTER TABLE tablaEjemplo ADD Descripcion VARCHAR(100);
/*
Ejemplo de lo que no puede hacer
SELECT * FROM conserje;
*/


REVERT;


/*
Testeo el funcionamiento de usuario solo vista
*/
EXECUTE AS USER = 'usuarioVista';
-- Consultar la vista individual
SELECT * FROM ViewSchema.GastoView;
REVERT;

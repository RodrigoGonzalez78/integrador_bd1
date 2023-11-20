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


/*Prueba del rol de Analista*/
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'UsuarioAnalista';
    SELECT * FROM conserje;
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;


/*Prueba del rol de Diseñador*/
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'UsuarioDisenador';
    CREATE TABLE tablaEjemplo (ID INT, Nombre VARCHAR(50));
    ALTER TABLE tablaEjemplo ADD Descripcion VARCHAR(100);
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;

/*Prueba con error de Diseñador*/
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'UsuarioDisenador';
    CREATE TABLE tablaEjemplo (ID INT, Nombre VARCHAR(50));
    ALTER TABLE tablaEjemplo ADD Descripcion VARCHAR(100);
   /*Intento de SELECT en conserje (debería fallar)*/
    SELECT * FROM conserje;
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;

/* Prueba del usuario solo vista
*/
BEGIN TRANSACTION;
BEGIN TRY
    EXECUTE AS USER = 'usuarioVista';
    SELECT * FROM ViewSchema.GastoView;
    REVERT;
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error en la transacción. Deshaciendo cambios.';
END CATCH;

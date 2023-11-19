use base_consorcio;


-- Pruebas de los procedimientos creados

-- Ejecución del procedimiento para obtener la cantidad de consorcios por provincia
EXEC ObtenerCantidadConsorciosPorProvincia;
--DROP PROCEDURE ObtenerCantidadConsorciosPorProvincia; -- Este DROP podría ser para borrar el procedimiento después de las pruebas

-- Ejecución del procedimiento para obtener el gasto total por tipo de gasto
EXEC ObtenerGastoTotalPorTipo;
--DROP PROCEDURE ObtenerGastoTotalPorTipo; -- Este DROP podría ser para borrar el procedimiento después de las pruebas

-- Ejecución del procedimiento para obtener la cantidad de consorcios por zona
EXEC ObtenerCantidadConsorciosPorZona;
--DROP PROCEDURE ObtenerCantidadConsorciosPorZona; -- Este DROP podría ser para borrar el procedimiento después de las pruebas


-- Lote de Pruebas para Administrador --

-- Obtener datos de la tabla Administrador y calcular la edad de cada administrador
SELECT *, dbo.CalcularEdadAdministardor(idadmin) AS Edad FROM administrador;
--DROP PROCEDURE CalcularEdadAdministardor; -- Este DROP podría ser para borrar el procedimiento después de las pruebas

-- Vaciar la tabla Administrador:
--DELETE FROM administrador;

-- Insertar datos utilizando el procedimiento almacenado correspondiente:
EXEC InsertarAdministrador 'Julian Cruz', 'S', '3795024422', 'M', '17-02-1997';

-- Modificar datos de un administrador utilizando el procedimiento almacenado correspondiente:
EXEC ModificarAdministrador 1, 'Julian Luis Cruz', 'N', '112443434', 'M', '17-02-1997';

-- Eliminación de datos de un administrador utilizando el procedimiento almacenado correspondiente:
EXEC BorrarAdministrador 1;

-- Ejemplos de pruebas para los procedimientos relacionados con Consorcios (Agregar, Modificar, Eliminar)

-- Prueba para el procedimiento de AgregarConsorcio
EXECUTE AgregarConsorcio @Provincia = 5, @Localidad = 6, @Consorcio = 50, @Nombre = 'Nicolás', @Direccion = 'General Viamonte 1658', @Zona = 3, @Conserje = '2', @Admin = 1;
SELECT * FROM consorcio WHERE idConsorcio = 50;

-- Prueba para el procedimiento de ModificarConsorcio
EXECUTE ModificarConsorcio @Provincia = 6, @Localidad = 5, @Consorcio = 50, @Nombre = 'Anibal', @Direccion = 'Juan Jose Castelli 1217', @Zona = 4, @Conserje = '1', @Admin = 2;
SELECT * FROM consorcio WHERE idConsorcio = 50;
DELETE FROM consorcio WHERE idconsorcio = 50; -- Borrar el consorcio creado para la prueba

-- Prueba para el procedimiento de EliminarConsorcio
EXECUTE EliminarConsorcio @Consorcio = 50;
SELECT * FROM consorcio WHERE idconsorcio = 50;

-- Ejemplos de inserción de datos en la tabla 'gasto' utilizando INSERT
INSERT INTO gasto (idprovincia, idlocalidad, idconsorcio, periodo, fechapago, idtipogasto, importe)
VALUES
    (24, 17, 6, 8, CONVERT(DATETIME, '20231029'), 4, 100.50),
    (24, 17, 6, 3, CONVERT(DATETIME, '20231030'), 4, 150.75),
    (24, 17, 6, 4, CONVERT(DATETIME, '20231101'), 5, 75.25);

-- Prueba para el procedimiento de InsertarGasto
EXEC InsertarGasto 24, 17, 6, 8, '20231102', 4, 80.00;
EXEC InsertarGasto 24, 17, 6, 3, '20231103', 5, 60.25;

-- Ejemplo de actualización de un registro utilizando el procedimiento almacenado
EXEC ModificarGasto @idgasto = 1, @idprovincia = 24, @idlocalidad = 17, @idconsorcio = 6, @periodo = 8, @fechapago = '20240115', @idtipogasto = 4, @importe = 120.00;

-- Ejemplo de eliminación de un registro utilizando el procedimiento almacenado
EXEC BorrarGasto @idgasto = 2;
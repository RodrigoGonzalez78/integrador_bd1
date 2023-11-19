use base_consorcio;

-- Procedimientos almacenados para obtener información

-- Procedimiento para obtener la cantidad de consorcios por provincia
CREATE PROCEDURE ObtenerCantidadConsorciosPorProvincia
AS
BEGIN
    -- Cuerpo del procedimiento almacenado: consulta para obtener la cantidad de consorcios por provincia
    SELECT c.idprovincia AS [ID Provincia], p.descripcion as 'Nombre de provincia', COUNT(*) AS [Cantidad de Consorcios]  
    FROM consorcio AS c
    INNER JOIN provincia p ON c.idprovincia = p.idprovincia
    GROUP BY c.idprovincia, p.descripcion;
END;

-- Procedimiento para obtener el gasto total por tipo de gasto
CREATE PROCEDURE ObtenerGastoTotalPorTipo
AS
BEGIN
    -- Cuerpo del procedimiento almacenado: consulta para obtener el gasto total por tipo de gasto
    SELECT g.idtipogasto AS 'ID Tipo de gasto', t.descripcion AS 'Tipo de Gasto', SUM(g.importe) AS 'Gasto total'
    FROM gasto AS g
    INNER JOIN tipogasto t ON t.idtipogasto = g.idtipogasto
    GROUP BY g.idtipogasto, t.descripcion
	ORDER BY g.idtipogasto;
END;

-- Procedimiento para obtener la cantidad de consorcios por zona
CREATE PROCEDURE ObtenerCantidadConsorciosPorZona
AS
BEGIN
    -- Cuerpo del procedimiento almacenado: consulta para obtener la cantidad de consorcios por zona
    SELECT c.idzona AS 'Id Zona', z.descripcion AS 'Zona', COUNT(*) AS 'Cantidad de Consorcios'
    FROM consorcio AS c
    INNER JOIN zona z ON z.idzona = c.idzona
    GROUP BY c.idzona, z.descripcion;
END;

-- Procedimientos para el administrador

-- Función para calcular la edad del administrador
CREATE FUNCTION CalcularEdadAdministardor(@ID INT)
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @Edad VARCHAR(200)
    SELECT @Edad = DATEDIFF(YEAR, fechnac, GETDATE())
    FROM administrador
    WHERE idadmin = @ID
    RETURN @Edad
END;

-- Procedimiento para insertar un administrador
CREATE PROCEDURE InsertarAdministrador
(
    @apeynom varchar(50),
    @viveahi varchar(1),
    @tel varchar(20),
    @sexo varchar(1),
    @fechnac datetime
)
AS
BEGIN
    INSERT INTO administrador (apeynom, viveahi, tel, sexo, fechnac)
    VALUES (@apeynom, @viveahi, @tel, @sexo, @fechnac);
END;

-- Procedimiento para modificar un administrador
CREATE PROCEDURE ModificarAdministrador
(
    @idadmin int,
    @apeynom varchar(50),
    @viveahi varchar(1),
    @tel varchar(20),
    @sexo varchar(1),
    @fechnac datetime
)
AS
BEGIN
    UPDATE administrador
    SET apeynom = @apeynom,
        viveahi = @viveahi,
        tel = @tel,
        sexo = @sexo,
        fechnac = @fechnac
    WHERE idadmin = @idadmin;
END;

-- Procedimiento para borrar un administrador
CREATE PROCEDURE BorrarAdministrador
(
    @idadmin int
)
AS
BEGIN
    DELETE FROM administrador
    WHERE idadmin = @idadmin;
END;

-- Procedimientos para el consorcio

-- Procedimiento para agregar un consorcio
CREATE PROCEDURE AgregarConsorcio
@Provincia INT,
@Localidad INT,
@Consorcio INT, 
@Nombre VARCHAR(50),
@Direccion VARCHAR(255),
@Zona INT,
@Conserje INT,
@Admin INT
AS
BEGIN
	INSERT INTO consorcio(idprovincia,idlocalidad,idconsorcio,nombre,direccion, idzona,idconserje,idadmin) 
	VALUES (@Provincia,@Localidad,@Consorcio,@Nombre,@Direccion, @Zona, @Conserje, @Admin)
END;

-- Procedimiento para modificar un consorcio
CREATE PROCEDURE ModificarConsorcio
@Provincia INT,
@Localidad INT,
@Consorcio INT, 
@Nombre VARCHAR(50),
@Direccion VARCHAR(255),
@Zona INT,
@Conserje INT,
@Admin INT
AS
BEGIN
	IF @Consorcio IS NOT NULL
		UPDATE consorcio SET idprovincia= @Provincia, idlocalidad= @Localidad,nombre= @Nombre,direccion= @Direccion,idzona= @Zona, 
		idconserje= @Conserje,idadmin= @Admin
		WHERE idconsorcio= @Consorcio
END;

-- Procedimiento para eliminar un consorcio
CREATE PROCEDURE EliminarConsorcio
@Consorcio INT
AS
BEGIN
	DELETE FROM consorcio WHERE idconsorcio=@Consorcio
END;

-- Procedimientos para la tabla gasto

-- Procedimiento para insertar un registro en la tabla gasto
CREATE PROCEDURE InsertarGasto(
    @idprovincia INT,
    @idlocalidad INT,
    @idconsorcio INT,
    @periodo INT,
    @fechapago DATETIME,
    @idtipogasto INT,
    @importe DECIMAL(8, 2)
)
AS
BEGIN
    INSERT INTO gasto (idprovincia, idlocalidad, idconsorcio, periodo, fechapago, idtipogasto, importe)
    VALUES (@idprovincia, @idlocalidad, @idconsorcio, @periodo, @fechapago, @idtipogasto, @importe);
END;

-- Procedimiento para modificar un registro en la tabla gasto
CREATE PROCEDURE ModificarGasto
(
    @idgasto INT,
    @idprovincia INT,
    @idlocalidad INT,
    @idconsorcio INT,
    @periodo INT,
    @fechapago DATETIME,
    @idtipogasto INT,
    @importe DECIMAL(8, 2)
)
AS
BEGIN
    UPDATE gasto
    SET
        idprovincia = @idprovincia,
        idlocalidad = @idlocalidad,
        idconsorcio = @idconsorcio,
        periodo = @periodo,
        fechapago = @fechapago,
        idtipogasto = @idtipogasto,
        importe = @importe
    WHERE idgasto = @idgasto;
END;

-- Procedimiento para borrar un registro en la tabla gasto
CREATE PROCEDURE BorrarGasto
(
    @idgasto INT
)
AS
BEGIN
    DELETE FROM gasto
    WHERE idgasto = @idgasto;
END;



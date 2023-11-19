use base_consorcio;

CREATE PROCEDURE ObtenerCantidadConsorciosPorProvincia
AS
BEGIN
    -- Cuerpo del procedimiento almacenado: consulta para obtener la cantidad de consorcios por provincia
    SELECT c.idprovincia AS [ID Provincia], p.descripcion as 'Nombre de provincia', COUNT(*) AS [Cantidad de Consorcios]  
    FROM consorcio AS c
    INNER JOIN provincia p ON c.idprovincia = p.idprovincia
    GROUP BY c.idprovincia, p.descripcion;
END;



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



CREATE PROCEDURE ObtenerCantidadConsorciosPorZona
AS
BEGIN
    -- Cuerpo del procedimiento almacenado: consulta para obtener la cantidad de consorcios por zona
    SELECT c.idzona AS 'Id Zona', z.descripcion AS 'Zona', COUNT(*) AS 'Cantidad de Consorcios'
    FROM consorcio AS c
    INNER JOIN zona z ON z.idzona = c.idzona
    GROUP BY c.idzona, z.descripcion;
END;




CREATE FUNCTION CalcularEdadAdministardor(@ID INT)
RETURNS VARCHAR(200)
AS
BEGIN
--Devuelve la edad del admin
	DECLARE @Edad VARCHAR(200)

	SELECT @Edad= DATEDIFF(YEAR,fechnac, GETDATE())
		FROM administrador
	WHERE idadmin= @ID
	RETURN @Edad
END;


/*
Para probar

SELECT *, dbo.CalcularEdadAdministardor(idadmin) AS Edad FROM administrador;
EXEC ObtenerCantidadConsorciosPorProvincia;
EXEC ObtenerGastoTotalPorTipo;
EXEC ObtenerCantidadConsorciosPorZona;
*/





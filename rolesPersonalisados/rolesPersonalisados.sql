USE base_consorcio;

/*
Creamos usuarios de prubea
*/

CREATE LOGIN UsuarioAnalista WITH PASSWORD = 'ContrasenaAnalista';
CREATE LOGIN UsuarioDisenador WITH PASSWORD = 'ContrasenaDisenador';


CREATE USER UsuarioAnalista FOR LOGIN UsuarioAnalista;
CREATE USER UsuarioDisenador FOR LOGIN UsuarioDisenador;


/*

Creamos dos roles
*/

CREATE ROLE Analistas;
CREATE ROLE Disenadores;


/*
Le damos permisos  a los roles
*/

GRANT SELECT TO Analistas;


GRANT CREATE TABLE TO Disenadores;
GRANT ALTER ON SCHEMA::dbo TO Disenadores;

/*
Le asignamos a cada role los usuarios
*/

ALTER ROLE Analistas ADD MEMBER UsuarioAnalista;
ALTER ROLE Disenadores ADD MEMBER UsuarioDisenador;

/*
Crear usuario solo vista
*/
CREATE SCHEMA ViewSchema AUTHORIZATION dbo;
GO
-- Crear una nueva vista en este esquema
-- Crear vistas para cada tabla
CREATE VIEW ViewSchema.ProvinciaView AS SELECT * FROM provincia;
GO
CREATE VIEW ViewSchema.LocalidadView AS SELECT * FROM localidad;
GO
CREATE VIEW ViewSchema.ZonaView AS SELECT * FROM zona;
GO
CREATE VIEW ViewSchema.ConsorcioView AS SELECT * FROM consorcio;
GO
CREATE VIEW ViewSchema.GastoView AS SELECT * FROM gasto;
GO
CREATE VIEW ViewSchema.ConserjeView AS SELECT * FROM conserje;
GO
CREATE VIEW ViewSchema.AdministradorView AS SELECT * FROM administrador;
GO
CREATE VIEW ViewSchema.TipoGastoView AS SELECT * FROM tipogasto;
GO
-- Crear un nuevo rol de base de datos
CREATE ROLE db_viewreader;

-- Otorgar permisos SELECT a todos los objetos en el esquema ViewSchema al nuevo rol de base de datos
GRANT SELECT ON SCHEMA::ViewSchema TO db_viewreader;


-- Crear un nuevo usuario
CREATE USER usuarioVista WITHOUT LOGIN;

-- Agregar el nuevo usuario al rol de base de datos
ALTER ROLE db_viewreader ADD MEMBER usuarioVista;

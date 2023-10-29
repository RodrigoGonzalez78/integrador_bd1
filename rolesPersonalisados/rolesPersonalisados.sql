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

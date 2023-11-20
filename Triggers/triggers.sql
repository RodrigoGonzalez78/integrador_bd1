

create table auditoria_administrador(
idAdministrador int,
apeynom varchar(50),
tel varchar(50),
fechnac date,
viveahi varchar(1),
sexo varchar (1),					     
fechaModif datetime,
usuario_accion varchar(100),
accion varchar (20)
);
go

go
CREATE TRIGGER trg_auditoria_administrador_insertar
ON administrador
FOR INSERT
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion insert'
    FROM
        inserted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;
--drop trigger trg_auditoria_administrador_insertar
	go
CREATE TRIGGER trg_auditoria_administrador_modificar
ON administrador
FOR update
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion modify'
    FROM
        inserted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;
--drop trigger trg_auditoria_administrador_modificar
	go
CREATE TRIGGER trg_auditoria_administrador_eliminar
ON administrador
FOR delete
AS
BEGIN
    DECLARE
        @idAdministrador INT,
        @apeynom VARCHAR(50),
        @tel VARCHAR(50),
        @fechnac DATE,
        @sexo VARCHAR(1),
        @viveahi VARCHAR(1),
        @fechaModif DATE,
        @usuario VARCHAR(50),
        @accion VARCHAR(20)

    SELECT
        @idAdministrador = idadmin,
        @apeynom = ApeyNom,
        @tel = tel,
        @fechnac = fechnac,
        @sexo = sexo,
        @viveahi = viveahi,
        @fechaModif = GETDATE(),
        @usuario = CURRENT_USER,
        @accion = 'accion delete'
    FROM
        deleted

    INSERT INTO auditoria_administrador
    VALUES (
        @idAdministrador,
        @apeynom,
        @tel,
        @fechnac,
        @sexo,
        @viveahi,
        @fechaModif,
        @usuario,
        @accion
    )
END;
--	drop trigger trg_auditoria_administrador_eliminar
Insert into administrador(ApeyNom,viveahi,tel,sexo,fechnac) values ('nombre apellido1', 'S', '19870223', 'M','2003-05-26');
select* from auditoria_administrador;


UPDATE  administrador   SET apeynom= 'Lezan Mauricio' where apeynom='nombre apellido1'
select* from auditoria_administrador;
select * from administrador
delete from administrador where apeynom='Lezan Mauricio';
select * from auditoria_administrador;

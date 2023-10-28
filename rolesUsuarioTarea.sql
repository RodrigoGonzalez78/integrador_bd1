
go
create login Benn with password='Password123';
create login artur with password='Password123';


create user benn for login Benn
create user artur for login artur

alter role db_datareader add member benn
alter role db_ddladmin add artur

go
create procedure insertarAdministrador
@apeynom varchar(50),
@viveahi varchar(1),
@tel varchar(20),
@s varchar(1),
@nacimiento datetime
as
begin
	insert into administrador(apeynom,viveahi,tel,sexo,fechnac)
	values (@apeynom,@viveahi,@tel,@s,@nacimiento);
end

--probar con benn antes del permiso 
--insert into administrador(apeynom,viveahi,tel,sexo,fechnac) values ('Lezana mauricio','S','3912819222','M','2003-05-26')
--exec  insertarAdministrador 'Lezana mauricio','S','3912819222','M','2003-05-26'
grant execute on insertarAdministrador to benn 
--probar despues de el permiso 
--exec  insertarAdministrador 'Lezana mauricio','S','3912819222','M','2003-05-26'
select * from administrador
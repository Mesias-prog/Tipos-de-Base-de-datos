create database BDveterinaria
use BDveterinaria
--tablas de clientes mascotas y consultas
create table cliente (
idcliente int identity(1,1) primary key,
nombre_cliente nvarchar (100)not null,
telefono nvarchar(10) not null,
direccion nvarchar(100) not null);
insert into cliente(nombre_cliente, telefono, direccion)
values ('Diego Mesias','0984382612','letamendi' ),
('Roque Mesias','0984678197','letamendi' ),
('Johanna Elizabeth','0987645131','letamendi' )
;

create table mascotas(
idmascotas int identity(1,1) primary key,
idcliente int,
nombre_mascota nvarchar(100)not null,
especie nvarchar (10)not null,
raza nvarchar(100)not null,
edad int not null,
foreign key (idcliente) references cliente(idcliente));
insert into mascotas(nombre_mascota, especie,raza,edad, idcliente)
values ('Princesa','Pitbull','Pura', 5,1 ),
('Deborador de mundos','Chiguahua','Pura', 6,2),
('Pepinillo','Robtwalli','Meztiza', 3,3 );
select*from mascotas

create table consultas(
idconsulta int identity(1,1) primary key,
fecha date default getdate(),
descripcion nvarchar(max),
costo decimal(10,2),
idcliente int,
idmascotas int,
foreign key (idcliente) references cliente(idcliente),
foreign key (idmascotas) references mascotas(idmascotas));
insert into consultas (descripcion, costo, idcliente, idmascotas)
values ('Vacunación anual y chequeo general', 25.00, 1, 1),
('Desparasitación y control de peso', 18.50, 2, 2),
('Revisión por alergias en la piel', 32.00, 3, 3),
('Control dental y limpieza', 40.00, 1, 1),
('Corte de uñas y revisión rápida', 10.00, 2, 2);

--crear un procedimiento
--ejercicio 1: crear un procedimiento donde se consulta mascotaXcliente
create procedure usp_mascotaXcliente
@idcliente int
as 
begin 
	select idmascotas,idcliente,nombre_mascota,especie,edad,raza
	from mascotas 
	where idcliente=@idcliente
end;

exec usp_mascotaXcliente @idcliente =3

--ejercicio 2 :calcular el costo total de una consulta por mascota

create procedure usp_consultacostotalXmascota
@nombre_mascota nvarchar(100) output,
@idmascotas int,
@costo decimal (10,2) output
as 
begin
--calculando el costo total de la consulta
	 select @costo= sum(costo) 
	 from consultas 
	 where idmascotas=@idmascotas
	 --obtener el nombre de la mascota
	 select @nombre_mascota =  nombre_mascota
	 from mascotas 
	 where idmascotas=@idmascotas
end;
--declarar una variable para tomar un resultados
declare @costo decimal(10,2);
declare @nombre_mascota nvarchar(100);
--calcular el costo total para la mascota con el codigoid 1
exec usp_consultacostotalXmascota @idmascotas =3 , @costo =@costo output,
@nombre_mascota= @nombre_mascota output;
print 'nombre: ' + @nombre_mascota
print 'costo total: ' + cast(@costo as nvarchar(50));

select @costo as costototal;

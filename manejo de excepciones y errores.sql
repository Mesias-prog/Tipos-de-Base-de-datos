--manejo de excepciones y errores
--excepciones: situacion inesperada o errores que ocurren durante la ejecucion de una consulta (scrip)
-- Capturar las excepciones : try catch
--sintaxis: 
--begin try
--codigo que causa el error!!!!!!!!!!!!!!!!!
--select,insert,update, delete
--end try
--begincatch
--codigo para manejas ese error!!!!!!!!!!!!!!!
--las funciones que se usan son error_message(), error_number(),error_severity(
--select
--error_message() : devuelve el mensaje del error
--error_number() : devuelve el numero del error
--error_severity() : devuelve la severidad del error
--end catch

create database dbclinica
use dbclinica

create table pacientes(
idpaciente int identity (1,1) primary key,
nombre nvarchar(100),
edad int,
fecha_de_ingreso datetime default getdate());
create table consultas(
idconsulta int identity (1,1) primary key,
idpaciente int,
fecha_consulta datetime default getdate(),
costo decimal (10,2),
foreign key (idpaciente) references pacientes (idpaciente));
insert into pacientes(nombre,edad)
values ('Carlos Zambrano', 45),
('María Fernanda López', 32),
('Diego Mesías', 28);
insert into consultas (idpaciente, costo)
values
(1, 20.00), 
(2, 35.50), 
(3, 18.75);  

select *from pacientes
select *from consultas

--ejemplo 1 con el try catch
--crear un procedimiento almacenado que inserte una nueva consulta,
--pero quieres manejas el caso donde el paciente no exista 
go
create procedure usp_insertarnuevaconsulta
@idpaciente int, @fecha_consulta datetime, @costo decimal (10,2)
as
begin 
begin try
--aqui intentamos insertar una nueva consulta
insert into consultas(idpaciente,fecha_consulta,costo)
values (@idpaciente,@fecha_consulta,@costo)
print 'consulta insertada correctamente'
end try
begin catch
print 'error al insertar la consulta'
select 
ERROR_MESSAGE() as errormessage,
ERROR_NUMBER() as errornamber,
ERROR_SEVERITY() as errorseverity
end catch
end;
exec usp_insertarnuevaconsulta @idpaciente=5, @fecha_consulta='2023-06-06'
,@costo=100.00
--un consejo si llegasen a ver esto, si no tienen un identity a alguno de sus ID al momento de haer un proceddure y tambien si no está como clave forane
--tienen que agregarle al proceddure con el @ caracteristico de este tipo de procedimientos
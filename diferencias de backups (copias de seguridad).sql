create database mibase
use mibase
create table empleados(
	id int primary key identity,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	salario decimal(10, 2) not null,
	fecha_contratacion date not null
)
create table departamentos(
	id int primary key identity,
	nombre varchar(50) not null,
	ubicacion varchar(100) not null
)
insert into empleados(nombre, apellido, salario, fecha_contratacion) values
('Juan', 'Pérez', 3000.00, '2020-01-15'),
('María', 'Gómez', 3500.00, '2019-03-22'),
('Carlos', 'López', 2800.00, '2021-07-30')
select *from empleados

/*tipos de seguridad
1.- copia de seguridad completa (full backup)
*/
backup database mibase to disk='D:\backups\mibase_full.bak'
with format;
go
/* si se ingresan mas datos se realiza un diferencial backups pero teniendo una copia completa hecha con anterioridad*/
backup database mibase
to disk='D:\backups\mibase_full.bak'
with differential
go
/*copia de seguridad de registros de transacciones log backup*/
backup log mibase
to disk='D:\backups\mibase_fulltansactions.trn'
go
/*back up en la nube*/
backup database mibase
to url=/*aqui va la direccion del contenedor al cual se va a registrar la base de datos*/
with credential=/*aqui van las credenciales*/
go
/*ahora como restaurar un back up*/
restore database mibase 
from disk ='D:\backups\mibase_full.bak'
with replace;
go
/*ahora el backup para el diferencial*/
--primero 
restore database mi base
from disk = 'D:\backups\mibase_full.bak'
with norecovery;
go
--segundo
restore database mi base
from disk = 'D:\backups\mibase_full.bak'
with recovery;
go
/*si no se hace en ese orden sale un error*/
/*restaurar un backup de transaction*/
restore log mi base
from disk='D:\backups\mibase_full.bak'
with replace
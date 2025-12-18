--tipos de formas normales en dbns 
--1fn(primera forma normal) = garantiza que la tabla de la base de datos este organizada de manera que cada columna contenga valores atomicos
--cada columna contenga valores aotmicos(indivisibles)
--cada registro sea unico.
--eliminar grupos repetidos.
create database videoteca
use videoteca
go

create table informacion(
nombrecompleto nvarchar(100),
direccion nvarchar(200),
pelirentadas nvarchar(max),
saludo varchar (200));

insert into informacion(nombrecompleto, direccion, pelirentadas, saludo)
values 
('Carlos Pérez', 'Av. Siempre Viva 123', 'Titanic, Matrix, Avatar', '¡Bienvenido Carlos! Gracias por visitarnos.'),
('María López', 'Calle Rosales 456', 'El Padrino, Interestelar', 'Hola María, disfruta tus películas.'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12', 'Avengers, Iron Man, Thor', '¡Hola Diego! Que tengas un gran día.'),
('Lucía Sánchez', 'Barrio Central, Casa 20', 'Coco, Moana', '¡Hola Lucía! Gracias por tu preferencia.'),
('Fernando Ruiz', 'Urbanización Las Lomas, Villa 9', 'Rápidos y Furiosos, John Wick', 'Saludos Fernando, vuelve pronto.');
select *from informacion

create table informacion_1fn(
idinformacion int identity(1,1) primary key,
nombrecompleto nvarchar(100),
direccion nvarchar(200),
pelirentadas nvarchar(max),
saludo varchar (200));

insert into informacion_1fn(nombrecompleto, direccion, pelirentadas, saludo)
values 
('Carlos Pérez', 'Av. Siempre Viva 123', 'Avatar', '¡Bienvenido Carlos! Gracias por visitarnos.'),
('Carlos Pérez', 'Av. Siempre Viva 123', 'Titanic', '¡Bienvenido Carlos! Gracias por visitarnos.'),
('Carlos Pérez', 'Av. Siempre Viva 123', 'Matrix', '¡Bienvenido Carlos! Gracias por visitarnos.'),

('María López', 'Calle Rosales 456', 'Interestelar', 'Hola María, disfruta tus películas.'),
('María López', 'Calle Rosales 456', 'El Padrino', 'Hola María, disfruta tus películas.'),

('Diego Mesías', 'Cdla. El Paraíso, Mz 12', 'Iron Man', '¡Hola Diego! Que tengas un gran día.'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12', 'Avengers','¡Hola Diego! Que tengas un gran día.'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12', 'Thor', '¡Hola Diego! Que tengas un gran día.'),

('Lucía Sánchez', 'Barrio Central, Casa 20', 'Coco', '¡Hola Lucía! Gracias por tu preferencia.'),
('Lucía Sánchez', 'Barrio Central, Casa 20', 'Moana', '¡Hola Lucía! Gracias por tu preferencia.');

select *from informacion_1fn

--tipos de formas normales en dbns 
--2fn(segunda forma normal) = la base de datos debe estar en 1nf, que la clave principal no dependa de ningun subconjunto con relacion de la clavec andidata
--eliminar grupos repetidos.

create table miembros_2nf(
idmiembro int identity(1,1) primary key,
nombrecompleto nvarchar(100),
direccion nvarchar(200),
saludo varchar (200));

insert into miembros_2nf(nombrecompleto, direccion, saludo)
values 
('Carlos Pérez', 'Av. Siempre Viva 123', '¡Bienvenido Carlos! Gracias por visitarnos.'),
('Carlos Pérez', 'Av. Siempre Viva 123', '¡Bienvenido Carlos! Gracias por visitarnos.'),
('Carlos Pérez', 'Av. Siempre Viva 123', '¡Bienvenido Carlos! Gracias por visitarnos.'),

('María López', 'Calle Rosales 456', 'Hola María, disfruta tus películas.'),
('María López', 'Calle Rosales 456',  'Hola María, disfruta tus películas.'),

('Diego Mesías', 'Cdla. El Paraíso, Mz 12', '¡Hola Diego! Que tengas un gran día.'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12','¡Hola Diego! Que tengas un gran día.'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12', '¡Hola Diego! Que tengas un gran día.'),

('Lucía Sánchez', 'Barrio Central, Casa 20', '¡Hola Lucía! Gracias por tu preferencia.'),
('Lucía Sánchez', 'Barrio Central, Casa 20', '¡Hola Lucía! Gracias por tu preferencia.');
select *from miembros_2nf

create table pelicular_2nf(
idpelicula int identity (1,1) primary key,
nombrepelicula nvarchar(100),
idmiembro int,
foreign key (idmiembro) references miembros_2nf(idmiembro));

insert into  pelicular_2nf(nombrepelicula, idmiembro)
values 
('Titanic', 1),
('El Señor de los Anillos', 2),
('Avatar', 3),
('Interestelar', 4);
select *from pelicular_2nf
select *from miembros_2nf

--tipos de formas normales en dbns 
--3fn(tercera forma normal) = debe estar en la segunda formal normal y no tener dependencias funiconales transitivas
drop table miembros_3nf
create table miembros_3fnn(
idmiembro int identity(1,1) primary key,
nombrecompleto nvarchar(100),
direccion nvarchar(200),
idsaludo int,
foreign key (idsaludo) references saludos_3nf (idsaludo));

insert into miembros_3fnn(nombrecompleto, direccion)
values 
('Carlos Pérez', 'Av. Siempre Viva 123'),
('Carlos Pérez', 'Av. Siempre Viva 123'),
('Carlos Pérez', 'Av. Siempre Viva 123'),

('María López', 'Calle Rosales 456'),
('María López', 'Calle Rosales 456'),

('Diego Mesías', 'Cdla. El Paraíso, Mz 12'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12'),
('Diego Mesías', 'Cdla. El Paraíso, Mz 12'),

('Lucía Sánchez', 'Barrio Central, Casa 20'),
('Lucía Sánchez', 'Barrio Central, Casa 20');

create table saludos_3nf(
idsaludo int identity(1,1) primary key,
saludos varchar(10));

insert into saludos_3nf( saludos)
values ('SRA'),('SR');

select *from saludos_3nf
select *from miembros_3fnn

create table pelicular_3nf(
idpelicula int identity (1,1) primary key,
nombrepelicula nvarchar(100),
idmiembro int,
foreign key (idmiembro) references miembros_3fnn(idmiembro));

insert into  pelicular_3nf(nombrepelicula, idmiembro)
values 
('Titanic', 1),
('El Señor de los Anillos', 2),
('Avatar', 3),
('Interestelar', 4);


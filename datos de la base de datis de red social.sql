--drop table = el comando permite borrar una tabla con todo y datos
--alter table = permite agregar columnas a las tablas
create table usuario(usuarioID int identity (1,1) primary key, 
nombre varchar(50) not null, 
correo varchar (50) not null unique,
fecharegistro datetime default getdate(),--getdate por defecto te da la fecha del sistema
constraint UQ_corre unique(correo))

create table publicaciones(publiID int identity (1,1) primary key,
usuarioID int,
contenido text not null,
fechadepubli datetime default getdate(),
constraint Fk_ususario_publicacion foreign key (usuarioID) 
references usuario (usuarioID))

create table amistades(
usuarioID1 int not null, --primer usuario
usuarioID2 int not null, --segundo usuario
fechaamistad datetime default getdate(),
constraint pk_amistad primary key(usuarioID1,usuarioID2),--clave compuesta 
constraint fk_amistad_usuario1 foreign key(usuarioID1) references usuario(usuarioID),
constraint fk_amistad_usuario2 foreign key(usuarioID2) references usuario(usuarioID))

--insertar los registros
insert into usuario(nombre,correo)
values('juan perez','juan@gmail.com'),
('maria lopez','maria@hotmail.com'),
('carlos gomez','carlos@camara.com')

insert into publicaciones(usuarioID,contenido)
values(1,'hola como estan'),
(2,'que tal estan'),
(3,'regresan las ofertas'),
(1,'e corrido 7km')

insert into amistades (usuarioID1,usuarioID2)
values(1,2), --juan y maria son amigos
(2,3), --mario y carlos son amigos
(3,1);

--alter table = permite agregar columnas a las tablas
alter table usuario add edad int
--modificar la columna correo para permitir mas caracteres
alter table usuario alter column correo varchar(150)
exec sp_help publicaciones
--elimiar la columna edad
alter table usuario drop column edad
--renombrar una columna
exec sp_rename 'usuario.fecharegistro', 'fechacreacion','column'
--agregar una restriccion 
alter table publicaciones
alter column contenido varchar (max)
alter table publicaciones
add constraint ck_contenido check(len(contenido)>0)
--eliminar una restriccion
alter table publicaciones
drop constraint ck_contenido 

select*from usuario
select*from publicaciones


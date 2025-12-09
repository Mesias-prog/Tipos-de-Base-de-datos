create database bdempresasac
use bdempresasac

create table cliente (idcliente int identity primary key,
nombre varchar (100),
direccion nvarchar(200));
create table pedidos (idpedidos int identity primary key,
idcliente int,
producto nvarchar(100),
cantidad int,
foreign key (idcliente) references cliente(idcliente))
 insert into cliente( nombre,direccion)
 values ('juan perez','porahí')
 insert into pedidos(idcliente,producto,cantidad)
 values (1,'laptop',2),
 (1,'mouse',4),
 (1,'tecclado',6)
 -- modificar la tabla para que las cantidades sean mayores a 0
 alter table pedidos
add constraint ck_cantidad_positiva
check (cantidad>0)
--optimizacion del acceso a datos 
select * from pedidos
where idcliente=1;
--crear un indice del id cliente, es importante para mejorar la velocidad de la consulta
--cuando tienes muchos registros que tengas que buscar
create index idx_idcliente on pedidos(idcliente)

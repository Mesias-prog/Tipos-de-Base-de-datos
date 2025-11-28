create table tbl_clientes
(idcliente varchar(5) primary key, --cadena de texto
nomcleint nvarchar(100), --cadena de texto unicode(caracteres especiales
edad int, --numerico entero
credito money, --datos numericos con formato monetario
fecharegistro datetime, -- va a akmacenar fecha y hora
esactivo bit, --dato de tipo booleano (1-verdadero,0-falso)
direccion nvarchar(200),
codpostal char(5), --cadena de texto fijo
genero char(1),
telefono varchar(10),
foto varbinary(max), --tipo de datos para ingresar imagenes o archivos
descripcion varchar(max)) --cadena de texto sin limite
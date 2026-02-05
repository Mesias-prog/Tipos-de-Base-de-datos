--habilitar el xp_cmdshell
exec sp_configure 'show advanced options', 1;--esta linea es para permitirle al sqlmanage que use los archives
reconfigure;
exec sp_configure 'xp_cmdshell',1;
reconfigure

exec sp_configure 'xp_cmdshell';
--crear un archivo
create database generardb
use generardb

declare @command varchar(100);
set @command='echo este es un texto de ejemplo >D:\salida.txt'
exec xp_cmdshell @command;
--leer cualquier archivo que uno quiera
declare @contenido nvarchar(max);
select @contenido = bulkcolumn
from openrowset(
bulk 'D:\salida.txt',
single_clob)
as archivo
select @contenido as archivo
/*generar archivo txt a partir de una tabla*/
declare @Comando varchar(2048)
set @Comando = 'bcp "SELECT * FROM generardb.dbo.Productos" '
+ 'queryout "D:\producttosstock.txt" '
+ '-S "DESKTOP-2LCMCMD" '
+ '-U "Adminuser" -P "Mesiasvelez0" -c'
exec xp_cmdshell @Comando;
--leer el archivo 
declare @info nvarchar(max);
select @info = bulkcolumn --nombre predeterminado
from openrowset(
bulk 'D:\producttosstock.txt',
single_clob) --indica que ela rchivo es un texto
as archivo

--aqui se remplaza 
set @info =replace(@info,char(13)+char(10),char(10));
select value as Linea
from STRING_SPLIT(@info,char(10));
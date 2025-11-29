create database redsocialdb
on
primary (
name='redsocialdb_data',
filename ='D:\data\redsocialdb_data.mdf',
size=10mb,
maxsize=100mb,
filegrowth=5mb
)
log on(
name='redsocialdb_log',
filename='D:\data\redsocialdb_log.ldf',
size=5mb,
maxsize=50mb,
filegrowth=2mb
);
use redsocialdb
--mostrar los archivos asociados a la bd
exec sp_helpfile


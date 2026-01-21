use msdb
/* crear el job */
exec sp_add_job
	@job_name='backupjob',
	@enabled=1, --aqui se está activando el job
	@description='este job realiza un respaldo diario de la base';
go
--agregar un paso al job
exec sp_add_jobstep
	@job_name='backupjob',
	@step_name='backupstep',
	@subsystem='TSQL',
	@command='backup database dbautomatizacion to disk='' D:\backpack\mibasededatos.bak''; ',
	@database_name='dbautomatizacion',
	@on_success_action=1,
	@on_fail_action=2;
go
--crear un horario para el job
exec sp_add_schedule
	@schedule_name='backupschedule',
	@enabled=1,
	@freq_type=4, --el 4 significa diario
	@freq_interval=1,
	@active_start_time=020000;--el termino es hora,minuto,segundo
go
--afinar el horario del job
exec sp_attach_schedule
	@job_name='backupjob',
	@schedule_name='backupschedule';
go
--habilitar el job
exec sp_update_job
	@job_name='backupjob',
	@enabled=1;
go
--enlazar con un servidor
exec sp_add_jobserver
	@job_name='backupjob',
	@server_name=N'DESKTOP-2LCMCMD';
go
--verificar los jobs
select job_id, name, enabled
from msdb.dbo.sysjobs;
go
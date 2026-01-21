--como ver el historial de los jobs
select
	j.name as jobname,
	h.run_status as jobstatus,
	h.run_date as rundate,
	h.run_duration as  runduration,
	h.message as errormessage
from 
	sysjobs j inner join sysjobhistory h on j.job_id=h.job_id
where j.name='backupjob'
order by h.run_date desc;
go
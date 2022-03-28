--  script: list-all-jobs
SELECT  job_id,name,enabled,description,date_created,date_modified
FROM msdb.dbo.sysjobs
ORDER BY date_created
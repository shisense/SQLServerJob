
-- create a new job

use msdb
go


DECLARE 
    @job nvarchar(128),
    @mycommand nvarchar(max), 
    @servername nvarchar(28),
    @startdate nvarchar(8),
    @starttime nvarchar(8)

SELECT
    @job = 'Job171', -- The job name
    @mycommand = 'C:\Users\shilu\projects\_ps171\cmd_171.cmd', -- The T-SQL command to run in the step
    @servername = null, -- SQL Server name. If running locally, you can use @servername=@@Servername
    @startdate = '20220326',
    @starttime = '120000' -- The time, 12:00:00

 
--Add a job
EXEC dbo.sp_add_job
    @job_name = @job ;

--Add a job step named process step. This step runs the stored procedure
EXEC sp_add_jobstep
    @job_name = @job,
    @step_name = N'step1:file2staging',
    @subsystem = N'CmdExec',
    @command = @mycommand

--Schedule the job at a specified date and time
EXEC sp_add_jobschedule @job_name = @job,
    @name = 'MySchedule',
    @freq_type=1,
    @active_start_date = @startdate,
    @active_start_time = @starttime

-- Add the job to the SQL Server 
EXEC dbo.sp_add_jobserver
    @job_name =  @job,
    @server_name = @servername

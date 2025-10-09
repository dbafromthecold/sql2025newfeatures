USE [master];
GO



-- drop event if it already exists
DROP EVENT SESSION [FailedQueries] ON SERVER;
GO



-- create new event session to capture failed queries with a max_duration of 60 minutes
CREATE EVENT SESSION [FailedQueries] ON SERVER 
ADD EVENT sqlserver.error_reported(
    ACTION(sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([package0].[greater_than_int64]([severity],(10)))) 
ADD TARGET package0.event_file(SET 	FILENAME=N'F:\XEvents\FailedQueries.xel')
WITH (MAX_DURATION = 60 MINUTES)



-- confirm event
SELECT [name], [max_duration], * FROM sys.server_event_sessions;



-- start event session
ALTER EVENT SESSION [FailedQueries] ON SERVER STATE = START;
GO
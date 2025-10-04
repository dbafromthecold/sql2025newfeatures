USE [tempdb];
GO



-- let's have a look to see how much log is in use
SELECT * FROM sys.dm_db_log_space_usage
GO



-- confirm ADR is off
SELECT name,is_accelerated_database_recovery_on FROM sys.databases
GO


-- we'll run a query using the other script (adr_run_query.sql) that inserts and updates data in a temp table



-- now let's see how much log is in use
SELECT * FROM sys.dm_db_log_space_usage
GO


-- does a check point reduce the log usage?
CHECKPOINT



-- now active transaction open in the database?
SELECT
    d.name,
    d.log_reuse_wait,
    d.log_reuse_wait_desc
FROM sys.databases AS d
WHERE d.name = 'tempdb';
GO



-- okay let's enable ADR for tempdb
ALTER DATABASE [tempdb] SET ACCELERATED_DATABASE_RECOVERY = ON
GO



-- confirm ADR is on for tempdb
SELECT name,is_accelerated_database_recovery_on FROM sys.databases;
GO



-- let's run the same query again (adr_run_query.sql)



-- and now see how much log is in use
SELECT * FROM sys.dm_db_log_space_usage
GO

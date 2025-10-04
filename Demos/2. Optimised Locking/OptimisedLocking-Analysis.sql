USE [master];
GO

ALTER DATABASE [tpcc] SET READ_COMMITTED_SNAPSHOT ON;
GO

ALTER DATABASE [tpcc] SET ACCELERATED_DATABASE_RECOVERY = ON
ALTER DATABASE [tpcc] SET OPTIMIZED_LOCKING = ON
GO

SELECT database_id,
       name,
       is_accelerated_database_recovery_on,
       is_read_committed_snapshot_on,
       is_optimized_locking_on
FROM sys.databases
WHERE name = 'tpcc';


SELECT IsOptimizedLockingOn = DATABASEPROPERTYEX('tpcc', 'IsOptimizedLockingOn');








SELECT name, description, *
FROM sys.dm_xe_objects
WHERE object_type = 'event'
  AND name IN ('lock_after_qual_stmt_abort','locking_stats')


IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'CaptureLAQAborts')
    DROP EVENT SESSION CaptureLAQAborts ON SERVER;
GO
CREATE EVENT SESSION CaptureLAQAborts ON SERVER
ADD EVENT sqlserver.lock_after_qual_stmt_abort(
    ACTION(
        sqlserver.session_id,
        sqlserver.request_id,
        sqlserver.database_id,
        sqlserver.client_app_name,
        sqlserver.client_hostname,
        sqlserver.sql_text,
        sqlserver.tsql_stack,
        sqlserver.plan_handle
    )
),
ADD EVENT sqlserver.locking_stats  -- periodic aggregate stats per database
ADD TARGET package0.event_file(
    SET filename = N'D:\XEvents\CaptureLAQAborts',
        max_file_size = 100,               -- MB
        max_rollover_files = 5
)
WITH (
    TRACK_CAUSALITY = ON,
    MAX_DISPATCH_LATENCY = 5 SECONDS
    -- Optional in SQL Server 2025: auto-stop after N minutes
    -- , MAX_DURATION = 60 MINUTES
);
GO
ALTER EVENT SESSION CaptureLAQAborts ON SERVER STATE = START;







select * from sys.dm_tran_locks

ALTER DATABASE [tpcc] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [tpcc] SET ACCELERATED_DATABASE_RECOVERY = OFF;
GO
ALTER DATABASE [tpcc] SET OPTIMIZED_LOCKING = OFF;
GO

USE [master];
GO



-- let's create a resource pool
CREATE RESOURCE POOL [TempDBPool]
GO



-- create a workload group that uses the pool
CREATE WORKLOAD GROUP TempDBGroup
WITH
    ( IMPORTANCE = MEDIUM,
      GROUP_MAX_TEMPDB_DATA_MB = 0.5)
      --GROUP_MAX_TEMPDB_DATA_PERCENT = value)
USING [TempDBPool];
GO



-- and now a classifier function
CREATE OR ALTER FUNCTION dbo.rg_classifier_tempdb()
RETURNS sysname
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @grp sysname;

    IF PROGRAM_NAME() LIKE '%Microsoft SQL Server Management Studio%' -- any query coming from SSMS!
        SET @grp = N'TempDBGroup';

    RETURN @grp;
END
GO



-- update resource governor to use the classifier function
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = dbo.rg_classifier_tempdb);
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO



-- run a query in new window in SSMS
USE [tpcc];
GO

BEGIN TRANSACTION

SELECT TOP (1000000) * INTO #TempTable
FROM [dbo].[order_line];

UPDATE #TempTable
SET ol_amount = ol_amount + 1

--ROLLBACK
--COMMIT





-- let's see what pool and workload group we are using
SELECT
    s.session_id,
    s.login_name,
    s.program_name,
    g.name  AS workload_group,
    p.name  AS pool_name
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_resource_governor_workload_groups AS g ON s.group_id = g.group_id
JOIN sys.dm_resource_governor_resource_pools   AS p ON g.pool_id  = p.pool_id
WHERE s.session_id = XX;
GO



-- kill other session
KILL XX



-- clean up
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
GO
DROP WORKLOAD GROUP [TempDBGroup];
GO
DROP RESOURCE POOL [TempDBPool]
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO
DROP FUNCTION dbo.rg_classifier_tempdb;
GO

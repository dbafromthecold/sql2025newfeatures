USE [tpcc]
GO


-- clear out the Query Store to start fresh
ALTER DATABASE [tpcc] SET QUERY_STORE CLEAR;
GO



-- let's create a stored procedcure that we will want to abort
CREATE OR ALTER PROCEDURE [dbo].[TerribleProc] AS
    SELECT TOP 1000000 * 
    FROM [dbo].[order_line]
GO



-- execute this "terrible" procedure
EXEC [dbo].[TerribleProc];
GO



-- let's have a look at the procedure in Query Store
DECLARE @ProcName sysname = 'TerribleProc'

SELECT
    CASE
        WHEN OBJECT_NAME(q.object_id) IS NULL THEN 'ADHOC (QUERYID:' + CAST(q.query_id AS VARCHAR(20)) + ')'
        ELSE OBJECT_NAME(q.object_id)
    END AS ProcedureName,
    MAX(rs.count_executions) AS executions,
    ROUND(SUM(rs.count_executions * rs.avg_cpu_time) / 1000 / 1000 / 60, 0) AS TotalCPUMinutes,
    ROUND(SUM(rs.count_executions * rs.avg_duration) / 1000 / 1000 / 60, 0) AS TotalDurationMinutes,
    ROUND(SUM(rs.count_executions * rs.avg_logical_io_reads), 0) AS TotalLogicalReads,
    ROUND(SUM(rs.count_executions * rs.avg_logical_io_writes), 0) AS TotalLogicalWrites,
    ROUND(SUM(rs.count_executions * rs.avg_physical_io_reads), 0) AS TotalPhysicalReads,
    ROUND(SUM(rs.count_executions * rs.avg_query_max_used_memory), 0) AS TotalMemory,
    q.query_id,
    p.plan_id,
    q.query_text_id,
    q.query_hash,
    p.query_plan_hash,
    rs.execution_type_desc,
	rs.last_execution_time
FROM
    sys.query_store_query AS q
    INNER JOIN sys.query_store_plan AS p
        ON q.query_id = p.query_id
    INNER JOIN sys.query_store_runtime_stats AS rs
        ON p.plan_id = rs.plan_id
WHERE
    rs.last_execution_time > DATEADD(HOUR, -300, GETUTCDATE())
    AND ( @ProcName IS NULL OR OBJECT_NAME(q.object_id) = @ProcName )
GROUP BY
    CASE
        WHEN OBJECT_NAME(q.object_id) IS NULL THEN 'ADHOC (QUERYID:' + CAST(q.query_id AS VARCHAR(20)) + ')'
        ELSE OBJECT_NAME(q.object_id)
    END,
    q.query_id,
    p.plan_id,
    q.query_text_id,
    q.query_hash,
    p.query_plan_hash,
    rs.execution_type_desc,
	rs.last_execution_time
ORDER BY
    rs.last_execution_time DESC;



-- now let's add the ABORT_QUERY_EXECUTION hint to this query
EXEC sys.sp_query_store_set_hints
     @query_id = X,
     @query_hints = N'OPTION (USE HINT (''ABORT_QUERY_EXECUTION''))';



-- confirm the hint has been added
SELECT qsh.query_id,
       q.query_hash,
       qt.query_sql_text
      FROM sys.query_store_query_hints AS qsh
INNER JOIN sys.query_store_query AS q ON qsh.query_id = q.query_id
INNER JOIN sys.query_store_query_text AS qt ON q.query_text_id = qt.query_text_id
    WHERE UPPER(qsh.query_hint_text) LIKE '%ABORT[_]QUERY[_]EXECUTION%'



-- now's let's try to execute the procedure
EXEC [dbo].[TerribleProc];
GO



-- if we want to remove the hint
EXEC sp_query_store_clear_hints
        @query_id = X;
GO



-- which will allow the procedure to be executed
EXEC [dbo].[TerribleProc];
GO


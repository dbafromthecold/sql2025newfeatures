USE [AdventureWorks2022];
GO


-- clear the procedure cache
DBCC FREEPROCCACHE



-- ensure the feature is disabled
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZED_SP_EXECUTESQL = OFF;
GO



-- confirm that the feature is disabled
SELECT * FROM sys.database_scoped_configurations WHERE name = 'OPTIMIZED_SP_EXECUTESQL'
GO



-- here's the test query
EXECUTE sp_executesql N'SELECT * FROM AdventureWorks2022.HumanResources.Employee
    WHERE BusinessEntityID = @level', N'@level TINYINT', @level = 109;




-- we'll execute it in parallel using ostress
--ostress -S"Z-AP-SQL-04" -d"AdventureWorks2022" -E -n32 -r1 -Q"EXECUTE sp_executesql N'SELECT * FROM AdventureWorks2022.HumanResources.Employee WHERE BusinessEntityID = @level', N'@level TINYINT', @level = 109;"



-- let's have a look at the plan cache
SELECT 
    cp.cacheobjtype,
    cp.objtype,
    cp.size_in_bytes,
    cp.usecounts,
	qs.execution_count,
    qs.last_execution_time,
	qs.creation_time,
    qt.text,
    qp.query_plan,
    qs.sql_handle,
    qs.query_hash,
    qs.query_plan_hash,
    cp.plan_handle
FROM
    sys.[dm_exec_cached_plans] AS cp 
LEFT OUTER JOIN     
    sys.[dm_exec_query_stats] AS qs ON cp.plan_handle = qs.plan_handle
CROSS APPLY 
    sys.[dm_exec_query_plan](cp.plan_handle) AS qp
CROSS APPLY
    sys.[dm_exec_sql_text](cp.plan_handle) AS qt
WHERE
    qt.text LIKE ('(@level TINYINT)SELECT * FROM AdventureWorks2022%')
ORDER BY
    cp.usecounts DESC;
GO



-- clear the plan cache again
DBCC FREEPROCCACHE



-- switch the feature on
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZED_SP_EXECUTESQL = ON;
GO



-- confirm that the feature is enabled
SELECT * FROM sys.database_scoped_configurations WHERE name = 'OPTIMIZED_SP_EXECUTESQL'
GO



-- and we'll use ostress again to execute the query in parallel
--ostress -S"Z-AP-SQL-04" -d"AdventureWorks2022" -E -n32 -r1 -Q"EXECUTE sp_executesql N'SELECT * FROM AdventureWorks2022.HumanResources.Employee WHERE BusinessEntityID = @level', N'@level TINYINT', @level = 109;"



-- and now let's have a look at the plan cache
SELECT 
    cp.cacheobjtype,
    cp.objtype,
    cp.size_in_bytes,
    cp.usecounts,
	qs.execution_count,
    qs.last_execution_time,
	qs.creation_time,
    qt.text,
    qp.query_plan,
    qs.sql_handle,
    qs.query_hash,
    qs.query_plan_hash,
    cp.plan_handle
FROM
    sys.[dm_exec_cached_plans] AS cp 
LEFT OUTER JOIN     
    sys.[dm_exec_query_stats] AS qs ON cp.plan_handle = qs.plan_handle
CROSS APPLY 
    sys.[dm_exec_query_plan](cp.plan_handle) AS qp
CROSS APPLY
    sys.[dm_exec_sql_text](cp.plan_handle) AS qt
WHERE
    qt.text LIKE ('(@level TINYINT)SELECT * FROM AdventureWorks2022%')
ORDER BY
    cp.usecounts DESC;
GO
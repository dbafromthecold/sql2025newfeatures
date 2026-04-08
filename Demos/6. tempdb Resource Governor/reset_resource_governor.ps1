# powershell script to reset resource governor changes if we lock ourselves out!!!!



# set variables
$SourceSql  = "AP-SQL2025-01"



# connect to SQL instances
$SqlCredential = Get-Credential
$SourceSqlConnection = Connect-DbaInstance -SqlInstance $SourceSql -SqlCredential $SqlCredential -TrustServerCertificate



# kill all connected SSMS sessions
Invoke-DbaQuery -SqlInstance $SourceSqlConnection -Query "
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 'KILL ' + CONVERT(NVARCHAR(10),session_id)+ ';' + CHAR(13)
FROM sys.dm_exec_sessions
WHERE program_name LIKE 'Microsoft SQL Server Management Studio%'
SELECT @sql;
EXEC sp_executesql @sql;"



# reconfigure resource governor
Invoke-DbaQuery -SqlInstance $SourceSqlConnection -Query "
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
ALTER RESOURCE GOVERNOR RECONFIGURE;"
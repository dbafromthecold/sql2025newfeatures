# powershell script to reset resource governor changes if we lock ourselves out!!!!



# set variables
$SourceSql  = "AP-SQL2025-01"



# connect to SQL instances
$SqlCredential = Get-Credential
$SourceSqlConnection = Connect-DbaInstance -SqlInstance $SourceSql -SqlCredential $SqlCredential -TrustServerCertificate



# cycle error logs on both instances
Invoke-DbaQuery -SqlInstance $SourceSqlConnection -Query "
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
ALTER RESOURCE GOVERNOR RECONFIGURE;"
# powershell script to reset resource governor changes if we lock ourselves out!!!!



# set variables
$SourceSql  = "Z-AP-SQL-04"



# connect to SQL instances
$SqlCredential = Import-CliXml -Path "E:\credentials\SA.cred"
$SourceSqlConnection = Connect-DbaInstance -SqlInstance $SourceSql -SqlCredential $SqlCredential



# cycle error logs on both instances
Invoke-DbaQuery -SqlInstance $SourceSqlConnection -Query "
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
ALTER RESOURCE GOVERNOR RECONFIGURE;"
USE [master];
GO



-- confirm no active trace flags enabled
DBCC TRACESTATUS;
GO



-- test running a backup on both nodes of the availability group
DECLARE @DBNAME SYSNAME = 'testdatabase'

IF (sys.fn_hadr_backup_is_preferred_replica(@DBNAME) != 1)  
BEGIN  
      SELECT 'Backups can only be performed on a secondary replica, exiting';   
END  
BACKUP DATABASE [testdatabase] TO DISK = 'F:\SQLBackup1\testdatabase.bak' WITH FORMAT, STATS=10;
GO



-- let's try Ola Hallengren's backup solution on both nodes
EXECUTE DBA.dbo.DatabaseBackup
      @Directory = 'F:\SQLBackup1',
      @BackupType = 'FULL',
      @AvailabilityGRoups = 'AG1';
GO



-- hmm, do T-SQL Snapshot Backups work on the secondary node?
ALTER DATABASE testdatabase SET SUSPEND_FOR_SNAPSHOT_BACKUP = ON
GO







# ssh into the server
ssh SERVERNAME



# create a directory that we will mount on tmpfs
sudo mkdir /var/opt/mssql/tempdb



# change the owner of the directory to mssql
sudo chown mssql. /var/opt/mssql/tempdb



# mount the directory on tmpfs with a size of 4GB
sudo mount -t tmpfs -o size=4G tmpfs /var/opt/mssql/tempdb/



# now update tempdb to use the new location
ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev, FILENAME = '/var/opt/mssql/tempdb/tempdb.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev2, FILENAME = '/var/opt/mssql/tempdb/tempdb2.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev3, FILENAME = '/var/opt/mssql/tempdb/tempdb3.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev4, FILENAME = '/var/opt/mssql/tempdb/tempdb4.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = templog, FILENAME = '/var/opt/mssql/tempdb/templog.ldf');
GO



# restart SQL Server
sudo systemctl restart mssql-server



# confirm tempdb is running on tmpgfs
SELECT [name], physical_name
FROM sys.master_files
WHERE database_id = 2;
GO



# OPTIONAL: If you want to move tempdb back to the default location, run the following commands
ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev, FILENAME = '/var/opt/mssql/data/tempdb.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev2, FILENAME = '/var/opt/mssql/data//tempdb2.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev3, FILENAME = '/var/opt/mssql/data/tempdb3.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = tempdev4, FILENAME = '/var/opt/mssql/data/tempdb4.mdf');

ALTER DATABASE tempdb
MODIFY FILE (NAME = templog, FILENAME = '/var/opt/mssql/data/templog.ldf');
GO
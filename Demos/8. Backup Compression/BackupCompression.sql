USE [master];
GO



-- example of using ZSTD compression with different levels
BACKUP DATABASE [tpcc] TO      
DISK = 'G:\SQLBackup1\tpcc_ZSTD_1.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_2.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_3.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_4.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_5.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_6.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_7.bak',
DISK = 'G:\SQLBackup1\tpcc_ZSTD_8.bak'
WITH    FORMAT
,		STATS=5
,       COMPRESSION (ALGORITHM = ZSTD, 
					LEVEL=LOW);
					--LEVEL=MEDIUM);
					--LEVEL=HIGH);
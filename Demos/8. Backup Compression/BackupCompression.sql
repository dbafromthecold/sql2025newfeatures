USE [master];
GO



-- exampe of using ZSTD compression with different levels
BACKUP DATABASE [tpcc] TO      
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_1.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_2.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_3.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_4.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_5.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_6.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_7.bak',
DISK = '\\fbstaines04data-vlan40-1.uklab.purestorage.com\z-ap-sql-smb01\tpcc_ZSTD_8.bak'
WITH    FORMAT
,       COMPRESSION (ALGORITHM = ZSTD, 
					LEVEL=LOW);
					--LEVEL=MEDIUM);
					--LEVEL=HIGH);
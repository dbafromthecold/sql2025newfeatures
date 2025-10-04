USE [master];
GO



-- drop and recreate the database
ALTER DATABASE [OptimizedLockingDemo] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE IF EXISTS [OptimizedLockingDemo];
GO



-- create database
CREATE DATABASE [OptimizedLockingDemo];
GO



-- confirm no options enabled for first run
SELECT database_id,
       name,
       is_read_committed_snapshot_on,
       is_accelerated_database_recovery_on,
       is_optimized_locking_on
FROM sys.databases
WHERE name = 'OptimizedLockingDemo';
GO



-- create table and insert some data
USE [OptimizedLockingDemo];
GO

CREATE TABLE dbo.TestTable (
ID INT IDENTITY(1,1) PRIMARY KEY,
ColA CHAR(1),
CREATEDDATE DATETIME DEFAULT GETDATE());

INSERT INTO dbo.TestTable 
(ColA)
VALUES
('A'),
('B'),
('C');
GO



-- confirm data
SELECT * FROM dbo.TestTable;
GO




-- open up a transaction to update a row
BEGIN TRANSACTION T1;

UPDATE dbo.TestTable 
SET ColA = 'Z'
WHERE ColA = 'A';	


-- now open another session and try to update the same row


-- commit transaction
COMMIT TRANSACTION;



-- let's do this again but with optimized locking enabled
ALTER DATABASE [OptimizedLockingDemo] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE IF EXISTS [OptimizedLockingDemo];
GO


CREATE DATABASE [OptimizedLockingDemo];
GO



-- enable the required options
ALTER DATABASE [OptimizedLockingDemo] SET READ_COMMITTED_SNAPSHOT ON;
GO
ALTER DATABASE [OptimizedLockingDemo] SET ACCELERATED_DATABASE_RECOVERY = ON;
GO
ALTER DATABASE [OptimizedLockingDemo] SET OPTIMIZED_LOCKING = ON;
GO



-- confirm options enabled for second run
SELECT database_id,
       name,
       is_read_committed_snapshot_on,
       is_accelerated_database_recovery_on,
       is_optimized_locking_on
FROM sys.databases
WHERE name = 'OptimizedLockingDemo';
GO



-- create table and insert some data
USE [OptimizedLockingDemo];
GO

CREATE TABLE dbo.TestTable (
ID INT IDENTITY(1,1) PRIMARY KEY,
ColA CHAR(1),
CREATEDDATE DATETIME DEFAULT GETDATE());

INSERT INTO dbo.TestTable 
(ColA)
VALUES
('A'),
('B'),
('C');
GO



-- confirm data
SELECT * FROM dbo.TestTable;
GO




-- open up a transaction to update a row
BEGIN TRANSACTION T1;

UPDATE dbo.TestTable 
SET ColA = 'Z'
WHERE ColA = 'A';	


-- commit transaction
COMMIT TRANSACTION;
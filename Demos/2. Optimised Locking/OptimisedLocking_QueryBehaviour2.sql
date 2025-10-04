USE [OptimisedLockingDemo];
GO


-- open up a second transaction to update the same row
BEGIN TRANSACTION T2;

UPDATE dbo.TestTable 
SET ColA = 'Y'
WHERE ColA = 'Z';


-- commit transaction
COMMIT TRANSACTION;



-- confirm data in the table
SELECT * FROM dbo.TestTable;
GO
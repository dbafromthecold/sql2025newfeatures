USE [tpcc];
GO



-- switch statistics time on to see the time taken when we rollback
SET STATISTICS TIME ON



-- begin a transaction that inserts data into a temp table and then updates that data
BEGIN TRANSACTION

SELECT TOP (1000000) * INTO #TempTable
FROM [dbo].[order_line];

UPDATE #TempTable
SET ol_amount = ol_amount + 1



-- let's see how long it takes to rollback
ROLLBACK




--COMMIT
--DROP TABLE #TempTable
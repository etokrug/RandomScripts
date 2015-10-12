/* TSQL */
/* KILL DB Connections (PRE-Restore) */
DECLARE @DBID INT, @SPID INT, @Kill_CMD VARCHAR(100)

SELECT @DBID = DBID
FROM MASTER..SysDatabases
WHERE Name = '' --INSERT DB NAME HERE

DECLARE cKill CURSOR FOR
	SELECT DISTINCT p.spid 
	FROM master.dbo.sysprocesses AS p
	WHERE p.dbid = @dbid
		AND p.spid >= 10
	OPEN cKill
	FETCH cKill into @spid
	WHILE (@@FETCH_STATUS <> -1) BEGIN
		-- Create the dyanamic SQL to kill the connection
		SET @kill_cmd = 'KILL ' + CONVERT(VARCHAR(10), @spid)
		-- Print the command
		PRINT 'Preparing to execute command ''' + @kill_cmd + '''...'
		-- Kill the connection
		EXEC (@kill_cmd)
		-- Grab the next connection
		FETCH cKill into @spid
	END
-- CURSOR cleanup
CLOSE cKill
DEALLOCATE cKill

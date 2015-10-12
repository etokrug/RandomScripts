/* TSQL */
/* Find object in DB */
/* Good for finding nested stored procedure calls and pinning down tables and data flow in new environments */
SELECT DISTINCT so.name
FROM syscomments sc
INNER JOIN sysobjects so ON sc.id=so.id
WHERE sc.TEXT LIKE '%tablename%'
/* TSQL */
/* Return the size of the databases in the system */

WITH fs
AS
(
    SELECT database_id, type, (size * 8.0 / 1024 / 1024) as [Size]
    FROM sys.master_files
)
SELECT 
    name,
    (SELECT sum(size) FROM fs WHERE type = 0 AND fs.database_id = db.database_id) DataFileSizeGB,
    (SELECT sum(size) FROM fs WHERE type = 1 AND fs.database_id = db.database_id) LogFileSizeGB
FROM sys.databases db
ORDER BY name

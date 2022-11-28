USE [db_name]
GO

-- get info for database object
sp_help 'schema.proc_name'
GO

-- display object as text
--sp_helptext 'schema.proc_name'
--GO

-- return table type columns
SELECT *
FROM sys.columns
WHERE object_id IN (
  SELECT type_table_object_id
  FROM 
	sys.table_types t1 INNER JOIN
	sys.schemas t2 ON t1.schema_id = t2.schema_id
  WHERE t1.name = 'table_type_name' and  t2.name = 'schema'
)
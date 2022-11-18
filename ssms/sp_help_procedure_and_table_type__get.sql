USE dabase_name
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
  FROM sys.table_types
  WHERE name = 'table_type_name'
)
-- get info on procedure
sp_help 'schema.proc_name';


-- Table Type Columns
SELECT *
FROM sys.columns
WHERE object_id IN (
  SELECT type_table_object_id
  FROM sys.table_types
  WHERE name = 'table_type_name'
)
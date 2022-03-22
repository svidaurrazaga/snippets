USE <DbName>
GO

-- =============================================================================================
-- Name: <SchemaName>.<TypeName>.sql
-- Description: <what is the type for>
-- Usage:
--   DECLARE @xx <TypeName>
--
-- Note: 
--   <YYYY-MM-DD> <DeveloperName>: <Note>
-- =============================================================================================
-- History:
-- ---------------------------------------------------------------------------------------------
-- When       | Who                 | Why 
-- ---------------------------------------------------------------------------------------------
-- <YYYY-MM-DD> | <DeveloperName>     | <Why Change>
-- =============================================================================================
IF EXISTS (SELECT 1 FROM sys.types t INNER JOIN sys.schemas s ON t.[schema_id] = s.[schema_id] WHERE t.[name] = '<TypeName>' AND s.[name] = '<SchemaName>')
DROP TYPE <SchemaName>.<TypeName> 
GO

CREATE TYPE <SchemaName>.<TypeName> FROM <DataType> NOT NULL
GO

CREATE TYPE <SchemaName>.<TypeName> AS TABLE (
<ColumnName> <DataType> 
, <ColumnName> <DataType> 
...
)
GO


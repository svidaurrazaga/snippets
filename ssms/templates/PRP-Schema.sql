USE <DbName>
GO

-- =============================================================================================
-- Name: <SchemaName>.sql
-- Description: <what is the schema for>
-- Usage: N/A
--   
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
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = '<SchemaName>')
EXEC ('CREATE SCHEMA <SchemaName>')
GO

USE <DbName>
GO

-- =============================================================================================
-- Name: <SequenceName>.sql
-- Description: <what is the sequence for>
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
IF NOT EXISTS (SELECT 1 FROM sys.sequences WHERE name = '<SequenceName>')
EXEC ('CREATE SEQUENCE <SchemaName>.<SequenceName> START WITH <InitialSeedNumber> INCREMENT BY <IncrementNumber>')
GO

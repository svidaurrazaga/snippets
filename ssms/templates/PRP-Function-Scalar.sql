USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION <SchemaName>.<FunctionName> (
<InputParameter> <DataType> ...
)
RETURNS <DataType>
AS
-- =============================================================================================
-- Name: <SchemaName>.<FunctionName>.sql
-- Description: <what does the function do>
-- Usage:
--   SELECT <SchemaName>.<FunctionName> (<InputParameter>)
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
BEGIN

DECLARE @<VariableName> <DataType>
...

<Populate @<VariableName>>
...

RETURN (@<VariableName>)

END
GO

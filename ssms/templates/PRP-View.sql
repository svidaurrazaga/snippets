USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW <SchemaName>.<ViewName>
WITH SCHEMABINDING 
AS
-- =============================================================================================
-- Name: <SchemaName>.<ViewName>.sql
-- Description: <what does the view do>
-- Usage:
--   SELECT * FROM <SchemaName>.<ViewName>
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

<Select Statement...>

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE [name] = '<IXV_ViewName>' AND [object_id] = OBJECT_ID('<ViewName>'))
BEGIN
  CREATE UNIQUE CLUSTERED INDEX IXV_<ViewName>
  ON <SchemaName>.<ViewName>(<index_key_columns>)
END
GO

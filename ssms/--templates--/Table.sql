-- =============================================================================================
-- Name: <SchemaName>.<TableName>.sql
-- Description: <what is the content for>
-- Usage: N/A
--
-- Note: 
-- <YYYY-MM-DD> <DeveloperName>: <Note>
-- =============================================================================================
-- History:
-- ---------------------------------------------------------------------------------------------
-- When       | Who                 | Why 
-- ---------------------------------------------------------------------------------------------
-- <YYYY-MM-DD> | <DeveloperName>     | <Why Change>
-- =============================================================================================

USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------
-- <YYYY-MM-DD> <DeveloperName>: Full Script
------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects o INNER JOIN sys.schemas s ON o.[schema_id] = s.[schema_id] WHERE o.[type] = 'U' AND o.[name] = '<TableName>' AND s.[name] = '<SchemaName>')
BEGIN

CREATE TABLE <SchemaName>.<TableName> (
<TableNameWithoutPrefix>_key INT NOT NULL IDENTITY(1,1) NOT FOR REPLICATION
CONSTRAINT pk_<TableName> PRIMARY KEY CLUSTERED (<TableNameWithoutPrefix>_key)
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100),

...

created_date DATETIME2(7) NULL
  CONSTRAINT df_<TableName>__created_date DEFAULT SYSDATETIME(),
updated_date DATETIME2(7) NULL
  CONSTRAINT df_<TableName>__updated_date DEFAULT SYSDATETIME(),
created_user SYSNAME NOT NULL
  CONSTRAINT df_<TableName>__created_user DEFAULT SUSER_SNAME(),
updated_user SYSNAME NOT NULL
  CONSTRAINT df_<TableName>__updated_user DEFAULT SUSER_SNAME(),

... 

<ColumnName> <DataType> NOT NULL
CONSTRAINT df_<TableName>__<ColumnName> DEFAULT (<FunctionOrValue>),
<ColumnName> <DataType> NOT NULL,
...
CONSTRAINT uq_<TableName>__<ColumnName1>_<ColumnName2> UNIQUE NONCLUSTERED (ColumnName1, ColumnName2)
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100),
...
CONSTRAINT fk_<TableName>__<ColumnName> FOREIGN KEY (ColumnName) REFERENCES <SchemaName>.<ParentTableName> (ParentColumnName)
)

CREATE NONCLUSTERED INDEX [ix_<TableName>__<IndexColumnName>_inc] ON <SchemaName>.<TableName> (<IndexColumnName>)
INCLUDE (<IncludeColumnName>) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100)

END
GO

------------------------------------------------------------------------------------------------
-- <YYYY-MM-DD> | <DeveloperName>     | <Why Change> Delta Change which will be removed later
------------------------------------------------------------------------------------------------

--Default--
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints d INNER JOIN sys.schemas s ON d.[schema_id] = s.[schema_id] WHERE d.[name] = '<DefaultName>' AND d.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD CONSTRAINT df_<TableName>__<ColumnName> DEFAULT (<FunctionOrValue>) FOR <ColumnName> WITH VALUES 
END
GO

IF EXISTS (SELECT 1 FROM sys.default_constraints d INNER JOIN sys.schemas s ON d.[schema_id] = s.[schema_id] WHERE d.[name] = '<DefaultName>' AND d.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP CONSTRAINT df_<TableName>__<ColumnName> 
END
GO

--Check--
IF NOT EXISTS (SELECT 1 FROM sys.check_constraints c INNER JOIN sys.schemas s ON c.[schema_id] = s.[schema_id] WHERE c.[name] = '<CheckName>' AND c.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD CONSTRAINT chk__<TableName>__<ColumnName> CHECK (<CheckStatement>)
END
GO

IF EXISTS (SELECT 1 FROM sys.check_constraints c INNER JOIN sys.schemas s ON c.[schema_id] = s.[schema_id] WHERE c.[name] = '<CheckName>' AND c.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP CONSTRAINT chk__<TableName>__<ColumnName>
END
GO

--ForeignKey--
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys f INNER JOIN sys.schemas s ON f.[schema_id] = s.[schema_id] WHERE f.[name] = '<FkName>' AND f.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD CONSTRAINT fk_<TableName>__<ColumnName> FOREIGN KEY (ColumnName) REFERENCES <SchemaName>.<ParentTableName> (ParentColumnName)
END
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys f INNER JOIN sys.schemas s ON f.[schema_id] = s.[schema_id] WHERE f.[name] = '<FkName>' AND f.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP CONSTRAINT fk_<TableName>__<ColumnName> 
END
GO

--UniqueKey--
IF NOT EXISTS (SELECT 1 FROM sys.key_constraints k INNER JOIN sys.schemas s ON k.[schema_id] = s.[schema_id] WHERE k.[name] = '<UqName>' AND k.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD CONSTRAINT uq_<TableName>__<ColumnName1>_<ColumnName2> UNIQUE NONCLUSTERED (ColumnName1, ColumnName2)
END
GO

IF EXISTS (SELECT 1 FROM sys.key_constraints k INNER JOIN sys.schemas s ON k.[schema_id] = s.[schema_id] WHERE k.[name] = '<UqName>' AND k.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP CONSTRAINT uq_<TableName>__<ColumnName1>_<ColumnName2>
END
GO

--Index--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE [name] = '<IndexName>' AND [object_id] = OBJECT_ID('<SchemaName>.<TableName>'))
BEGIN
  CREATE NONCLUSTERED INDEX ix_<TableName>__<IndexColumnName>_inc ON <SchemaName>.<TableName> (<IndexColumnName>)
  INCLUDE (<IncludeColumnName>) 
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100)
END
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE [name] = '<IndexName>' AND [object_id] = OBJECT_ID('<SchemaName>.<TableName>'))
BEGIN
  DROP INDEX <TableName>.ix_<TableName>__<IndexColumnName>_inc 
END
GO

--Column--
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD <ColumnName> <DataType> <Nullability>
END
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP COLUMN <ColumnName>
END
GO

--Column: increase data length
--text
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'dbo' AND table_name = '<TableName>' AND column_name = '<ColumnName>' AND CHARACTER_MAXIMUM_LENGTH = <ColumnDataLength>)
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ALTER COLUMN <ColumnName> <DataType> <Nullability>
END
GO

--numbers
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'dbo' AND table_name = '<TableName>' AND column_name = '<ColumnName>' AND NUMERIC_PRECISION = <ColumnDataLength>)
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ALTER COLUMN <ColumnName> <DataType> <Nullability>
END
GO

--Column: change nullability 
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>' AND IS_NULLABLE = '<YES/NO>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ALTER COLUMN <ColumnName> <DataType> <Nullability>
END
GO

--Column: change datatype
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>' AND DATA_TYPE = '<datatype>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ALTER COLUMN <ColumnName> <DataType> <Nullability>
END
GO

--Column & Default Constraint--
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> ADD <ColumnName> <DataType> <Nullability>
  CONSTRAINT df_<TableName>__<ColumnName> DEFAULT (<FunctionOrValue>) WITH VALUES 
END
GO

IF EXISTS (SELECT 1 FROM sys.default_constraints d INNER JOIN sys.schemas s ON d.[schema_id] = s.[schema_id] WHERE d.[name] = '<DefaultName>' AND d.parent_object_id = OBJECT_ID('<SchemaName>.<TableName>') AND s.[name] = '<SchemaName>' )
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP CONSTRAINT DF_<TableName>__<ColumnName> 
END
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = '<SchemaName>' AND table_name = '<TableName>' AND column_name = '<ColumnName>')
BEGIN
  ALTER TABLE <SchemaName>.<TableName> DROP COLUMN <ColumnName>
END
GO

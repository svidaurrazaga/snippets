USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE <SchemaName>.<ProcName>
<InputParameter> <DataType> = <DefaultValue>
AS
-- =============================================================================================
-- Name: <SchemaName>.<ProcName>.sql
-- Description: <what does the proc do>
-- Usage:
--   EXEC <SchemaName>.<ProcName> <InputParameter>
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
SET NOCOUNT ON

BEGIN TRY

IF @@TRANCOUNT > 0 ROLLBACK TRAN

BEGIN TRAN

<DML Code...>

IF @@TRANCOUNT > 0 COMMIT TRAN

END TRY
BEGIN CATCH

DECLARE @error_number INT, @error_message VARCHAR(4000), @proc_name SYSNAME 
SELECT @error_number = ERROR_NUMBER(), @error_message = ERROR_MESSAGE(), @proc_name = OBJECT_NAME(@@PROCID)

IF @@TRANCOUNT > 0 ROLLBACK TRAN

RAISERROR('Error Number: %d, Error Message: %s, Proc Name: %s', 16, 1, @error_number, @error_message, @proc_name)

END CATCH

END
GO

GRANT EXECUTE ON <SchemaName>.<ProcName> TO <ApplicationRole>
GO

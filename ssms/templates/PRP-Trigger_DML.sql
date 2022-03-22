USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER <SchemaName>.<TriggerName> ON <SchemaName>.<TableName> 
<FOR|AFTER|INSTEAD OF> <INSERT, UPDATE, DELETE> NOT FOR REPLICATION
AS
-- =============================================================================================
-- Name: <SchemaName>.<TriggerName>.sql
-- Description: <what does the trigger do>
-- Usage:
--   N/A
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

IF @@ROWCOUNT = 0 RETURN --Proceed only when row change exist

SET NOCOUNT ON

BEGIN TRY

<TSQL Statement ...>

END TRY
BEGIN CATCH

DECLARE @error_number INT, @error_message VARCHAR(4000), @proc_name SYSNAME 
SELECT @error_number = ERROR_NUMBER(), @error_message = ERROR_MESSAGE(), @proc_name = OBJECT_NAME(@@PROCID)

IF @@TRANCOUNT > 0 ROLLBACK TRAN

RAISERROR('Error Number: %d, Error Message: %s, Proc Name: %s', 16, 1, @error_number, @error_message, @proc_name)

END CATCH

END
GO

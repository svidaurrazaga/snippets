USE <DbName>
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE <SchemaName>.<ProcName>
<InputParameter> <DataType> = <DefaultValue>
@PageFrom INT = 0,
@PageTo INT = 0,
@SortColumn VARCHAR(256) = '<Default ColumnName>',
@SortColumnAsc BIT = 1
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

SELECT RowTotal,
  RowNumber,

  <Column1, Column2, ...>

FROM (
  SELECT RowTotal = COUNT(*) OVER (),
    RowNumber = ROW_NUMBER() OVER (ORDER BY
    CASE WHEN @SortColumn = '<Column1>' AND @SortColumnAsc = 1 THEN t3.<Column1> END ASC,
    CASE WHEN @SortColumn = '<Column1>' AND @SortColumnAsc = 0 THEN t3.<Column1> END DESC,
    CASE WHEN @SortColumn = '<Column2>' AND @SortColumnAsc = 1 THEN t1.<Column2> END ASC,
    CASE WHEN @SortColumn = '<Column2>' AND @SortColumnAsc = 0 THEN t1.<Column2> END DESC,
    ...),
    <Column1,
    Column2, ...>
  FROM <SchemaName>.<TableName> 
  ...
  ) x
WHERE (x.RowNumber BETWEEN @PageFrom AND @PageTo
  OR (@PageFrom = 0 AND @PageTo = 0)) -- Return all when both @pageFrom and @pageTo are zero
ORDER BY x.RowNumber

END TRY
BEGIN CATCH

DECLARE @error_number INT, @error_message VARCHAR(4000), @proc_name SYSNAME 
SELECT @error_number = ERROR_NUMBER(), @error_message = ERROR_MESSAGE(), @proc_name = OBJECT_NAME(@@PROCID)

RAISERROR('Error Number: %d, Error Message: %s, Proc Name: %s', 16, 1, @error_number, @error_message, @proc_name)

END CATCH

END
GO

GRANT EXECUTE ON <SchemaName>.<ProcName> TO <ApplicationRole>
GO

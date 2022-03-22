USE <DbName>
GO

-- =============================================================================================
-- Name: <SchemaName>.<DataScriptName>.sql
-- Description: <what does the data script do>
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

DECLARE @tbl TABLE (<ColumnName> <DataType>, ...)

INSERT INTO @tbl 
SELECT <ColumnValue>, ...

DECLARE @<KeyColumnName> ... = ???

SET IDENTITY_INSERT <SchemaName>.<TableName> ON

MERGE <SchemaName>.<TableName> AS t
USING @tbl AS s
ON (t.<KeyColumnName> = s.<KeyColumnName>, ...)
WHEN NOT MATCHED 
  THEN INSERT (<ColumnName>, ...)
  VALUES (s.<ColumnName>, ...)
WHEN MATCHED AND t.<ColumnName> <> s.<ColumnName> OR ...
  THEN UPDATE SET t.<ColumnName> = s.<ColumnName>,
    ...
WHEN NOT MATCHED BY SOURCE AND t.<KeyColumnName> = @<KeyColumnName>
  THEN DELETE 
OUTPUT $ACTION, INSERTED.*, DELETED.*;

SET IDENTITY_INSERT <SchemaName>.<TableName> OFF
GO

--Sample01:
--DECLARE @tbl TABLE (PropCureUserId INT, UserName VARCHAR(256), OrgId INT, IsActive BIT, FirstName VARCHAR(100), 
--  LastName VARCHAR(100), IsSystemAccount BIT, Email EMAIL NULL, UserClaimValueGuid UNIQUEIDENTIFIER, 
--  IsOrgAdmin BIT, DateCreated DATETIME2, DateModified DATETIME2, CreatedByUserId INT, ModifiedByUserId INT)

--INSERT INTO @tbl 
--SELECT 1, 'DeploymentUser', 0, 1, 'Deployment', 'Process', 1, NULL, Id, 0, SYSDATETIME(), SYSDATETIME(), 1, 1
--FROM SecurityMgr.dbo.AspNetUsers
--WHERE UserName = 'DeploymentUser'

--SET IDENTITY_INSERT dbo.PropCureUser ON

--MERGE dbo.PropCureUser AS t
--USING @tbl AS s
--ON (t.PropCureUserId = s.PropCureUserId) 
--WHEN NOT MATCHED 
--  THEN INSERT(PropCureUserId, UserName, OrgId, IsActive, FirstName, LastName, IsSystemAccount, Email, 
--    UserClaimValueGuid, IsOrgAdmin, DateCreated, DateModified, CreatedByUserId, ModifiedByUserId)
--  VALUES (s.PropCureUserId, s.UserName, s.OrgId, s.IsActive, s.FirstName, s.LastName, s.IsSystemAccount, s.Email, 
--    s.UserClaimValueGuid, s.IsOrgAdmin, s.DateCreated, s.DateModified, s.CreatedByUserId, s.ModifiedByUserId)
--WHEN MATCHED AND t.UserName <> s.UserName OR t.OrgId <> s.OrgId OR t.IsActive <> s.IsActive OR t.FirstName <> s.FirstName OR 
--  t.LastName <> s.LastName OR t.IsSystemAccount <> s.IsSystemAccount OR ISNULL(t.Email, '') <> ISNULL(s.Email, '') OR
--  t.UserClaimValueGuid <> s.UserClaimValueGuid OR t.IsOrgAdmin <> s.IsOrgAdmin 
--  THEN UPDATE SET t.UserName = s.UserName,
--    t.OrgId = s.OrgId,
--    t.IsActive = s.IsActive,
--    t.FirstName = s.FirstName,
--    t.LastName = s.LastName,
--    t.IsSystemAccount = s.IsSystemAccount,
--    t.Email = s.Email,
--    t.UserClaimValueGuid = s.UserClaimValueGuid,
--    t.IsOrgAdmin = s.IsOrgAdmin,
--    t.DateModified = s.DateModified,
--    t.ModifiedByUserId = s.ModifiedByUserId
--WHEN NOT MATCHED BY SOURCE 
--  THEN DELETE 
--OUTPUT $ACTION, INSERTED.*, DELETED.*;

--SET IDENTITY_INSERT dbo.PropCureUser OFF

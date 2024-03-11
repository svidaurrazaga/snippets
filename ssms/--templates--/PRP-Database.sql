USE master
GO

SETUSER 'dbo'
GO

--Small Size
CREATE DATABASE <DatabaseName> ON PRIMARY 
(NAME = N'<DatabaseName>_sys01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_sys01.mdf', SIZE = 20MB, MAXSIZE = 100MB, FILEGROWTH = 10MB),
FILEGROUP FG_Data 
(NAME = N'<DatabaseName>_dat01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat01.ndf', SIZE = 1500MB, MAXSIZE = 15GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat02', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat02.ndf', SIZE = 1500MB, MAXSIZE = 15GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat03', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat03.ndf', SIZE = 1500MB, MAXSIZE = 15GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat04', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat04.ndf', SIZE = 1500MB, MAXSIZE = 15GB, FILEGROWTH = 500MB)
LOG ON 
(NAME = N'<DatabaseName>_log01', FILENAME = N'l:\MSSQL\LOG\<DatabaseName>_log01.ldf', SIZE = 2GB, MAXSIZE = 20GB, FILEGROWTH = 250MB)
GO

--Medium Size
CREATE DATABASE <DatabaseName> ON PRIMARY 
(NAME = N'<DatabaseName>_sys01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_sys01.mdf', SIZE = 20MB, MAXSIZE = 100MB, FILEGROWTH = 10MB),
FILEGROUP FG_Data 
(NAME = N'<DatabaseName>_dat01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat01.ndf', SIZE = 4GB, MAXSIZE = 40GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat02', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat02.ndf', SIZE = 4GB, MAXSIZE = 40GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat03', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat03.ndf', SIZE = 4GB, MAXSIZE = 40GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat04', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat04.ndf', SIZE = 4GB, MAXSIZE = 40GB, FILEGROWTH = 500MB)
LOG ON 
(NAME = N'<DatabaseName>_log01', FILENAME = N'l:\MSSQL\LOG\<DatabaseName>_log01.ldf', SIZE = 2GB, MAXSIZE = 20GB, FILEGROWTH = 250MB)
GO

--Large Size
CREATE DATABASE <DatabaseName> ON PRIMARY 
(NAME = N'<DatabaseName>_sys01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_sys01.mdf', SIZE = 20MB, MAXSIZE = 100MB, FILEGROWTH = 10MB),
FILEGROUP FG_Data 
(NAME = N'<DatabaseName>_dat01', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat01.ndf', SIZE = 50GB, MAXSIZE = 500GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat02', FILENAME = N'g:\MSSQL\DATA\<DatabaseName>_dat02.ndf', SIZE = 50GB, MAXSIZE = 500GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat03', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat03.ndf', SIZE = 50GB, MAXSIZE = 500GB, FILEGROWTH = 500MB),
(NAME = N'<DatabaseName>_dat04', FILENAME = N's:\MSSQL\DATA\<DatabaseName>_dat04.ndf', SIZE = 50GB, MAXSIZE = 500GB, FILEGROWTH = 500MB)
LOG ON 
(NAME = N'<DatabaseName>_log01', FILENAME = N'l:\MSSQL\LOG\<DatabaseName>_log01.ldf', SIZE = 10GB, MAXSIZE = 50GB, FILEGROWTH = 250MB)
GO

ALTER DATABASE <DatabaseName>
MODIFY FILEGROUP FG_Data DEFAULT;
GO




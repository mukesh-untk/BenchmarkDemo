

IF NOT EXISTS ( SELECT ':)' FROM sys.schemas WHERE   name = N'Admin' )
	EXEC('CREATE SCHEMA [Admin]');
GO

IF OBJECT_ID('Admin.Employee') IS NULL
CREATE TABLE [Admin].[Employee](
 [EmployeeId] int identity(1,1) NOT NULL
,[FirstName] VARCHAR(50)
,[LastName] VARCHAR(50)
,[Gender] VARCHAR(50)
,[DepartmentName] VARCHAR(50)
,CONSTRAINT PK_Admin_Employee PRIMARY KEY CLUSTERED ( EmployeeId )
);

DECLARE @TotalRecords INT 
Select @TotalRecords=count(*) from Admin.Employee
IF(@TotalRecords<1000)
BEGIN
DECLARE @Counter INT 
SET @Counter=1
WHILE ( @Counter <= 1000)
BEGIN
  INSERT INTO [Admin].[Employee]
           ([FirstName]
           ,[LastName]
           ,[Gender]
           ,[DepartmentName])
     VALUES
           (CONCAT('FirstName', @Counter)
           ,CONCAT('LastName',@Counter)
           ,IIF(@Counter%2=0,'Male','Female' )
           ,CONCAT('DepartmentName' , @Counter) )
  SET @Counter=@Counter+1
END
END
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [Admin].[FetchJSONResult] 
	-- Add the parameters for the stored procedure here
	@Result NVARCHAR(MAX) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Insert statements for procedure here
  SET @Result =(SELECT 	[EmployeeId]
	   ,[FirstName]
       ,[LastName]
       ,[Gender]
       ,[DepartmentName]
  FROM  [Admin].[Employee]
  FOR JSON AUTO)

END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [Admin].[FetchEmployeeDataSet] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Insert statements for procedure here
  SELECT 	[EmployeeId]
	   ,[FirstName]
       ,[LastName]
       ,[Gender]
       ,[DepartmentName]
  FROM  [Admin].[Employee]
 

END
GO

USE [QueensClassSchedule]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitInstructorColumn]    Script Date: 5/13/2022 12:51:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[SplitInstructorColumn]( @InstructorColumn AS VARCHAR(50) )
RETURNS @InstructorName TABLE 
	(
	FirstName VARCHAR(50),
	LastName VARCHAR(50)
	)
AS
BEGIN
	SET @InstructorColumn = REPLACE(@InstructorColumn, ' ', '');
	INSERT INTO @InstructorName
	(
	FirstName,
	LastName
	) VALUES
	(
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@InstructorColumn, ',')) AS T WHERE T.[index] = 2),
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@InstructorColumn, ',')) AS T WHERE T.[index] = 1)
	)
RETURN 
END
GO



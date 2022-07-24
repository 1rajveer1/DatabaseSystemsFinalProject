USE [QueensClassSchedule]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitTimeColumn]    Script Date: 5/13/2022 12:51:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[SplitTimeColumn]( @TimeColumn AS VARCHAR(50) )
RETURNS @Time TABLE 
	(
	StartTime VARCHAR(50),
	EndTime VARCHAR(50)
	)
AS
BEGIN
	INSERT INTO @Time
	(
	StartTime,
	EndTime
	) VALUES
	(
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@TimeColumn, '-')) AS T WHERE T.[index] = 1),
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@TimeColumn, '-')) AS T WHERE T.[index] = 2)
	)
RETURN 
END
GO



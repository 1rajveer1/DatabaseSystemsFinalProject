USE [QueensClassSchedule]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitLocationColumn]    Script Date: 5/13/2022 12:51:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[SplitLocationColumn]( @LocationColumn AS VARCHAR(50) )
RETURNS @RoomLocation TABLE 
	(
	BuildingName VARCHAR(50),
	RoomNumber VARCHAR(50)
	)
AS
BEGIN
	INSERT INTO @RoomLocation
	(
	BuildingName,
	RoomNumber
	) VALUES
	(
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@LocationColumn, ' ')) AS T WHERE T.[index] = 1),
	(SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@LocationColumn, ' ')) AS T WHERE T.[index] = 2)
	)
RETURN 
END
GO



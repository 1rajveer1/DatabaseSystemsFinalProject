USE [QueensClassSchedule]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitDayColumn]    Script Date: 5/13/2022 12:51:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[SplitDayColumn]( @DayColumn AS VARCHAR(50) )
RETURNS @SepcificDay TABLE ([Day] VARCHAR(50))
AS
BEGIN
	SET @DayColumn = REPLACE(@DayColumn, ' ', '');
	INSERT INTO @SepcificDay
	SELECT F.value
	FROM string_split(@DayColumn, ',') AS F
RETURN 
END
GO



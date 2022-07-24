USE [QueensClassSchedule]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitCourseColumn]    Script Date: 5/13/2022 12:51:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[SplitCourseColumn]( @CourseColumn AS VARCHAR(50) )
RETURNS @hrAndCrd TABLE (
    CourseName VARCHAR(50),
    CourseNumber VARCHAR(50),
    [Hour(s)] VARCHAR(50),
    [Credit(s)] VARCHAR(50)
)
AS
BEGIN
    SET @CourseColumn = REPLACE(@CourseColumn, ' ', ',');
    SET @CourseColumn = REPLACE(@CourseColumn, '(', ',');
    SET @CourseColumn = REPLACE(@CourseColumn, ')', '');
    INSERT INTO @hrAndCrd
    (
        CourseName,
        CourseNumber,
        [Hour(s)],
        [Credit(s)]
    )
    VALUES
    (   (SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@CourseColumn, ',')) AS T WHERE T.[index] = 1),
        (SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@CourseColumn, ',')) AS T WHERE T.[index] = 2),
        (SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@CourseColumn, ',')) AS T WHERE T.[index] = 4),
        (SELECT T.[data] FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS [index], value AS [data] FROM STRING_SPLIT(@CourseColumn, ',')) AS T WHERE T.[index] = 6)
    )
    RETURN;
END;
GO



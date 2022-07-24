USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateCourse]    Script Date: 5/13/2022 12:46:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project3].[CreateCourse] @UserAuthorizationKey [INT].SurrogateKeyInt
AS
BEGIN
	
	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[Course];
	CREATE TABLE [Data].[Course]
	(
	CourseID [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_CourseID PRIMARY KEY,
	Code [INT].Code NOT NULL 
		CONSTRAINT DF_Couse_Code DEFAULT -1,
	Sec [CHAR].Section NOT NULL
		CONSTRAINT DF_Course_Section DEFAULT (N'N/A'),
	CourseName [STRING].CourseName NOT NULL
		CONSTRAINT DF_Course_CourseName DEFAULT (N'N/A'),
	CourseNumber [STRING].CourseNumber NOT NULL
		CONSTRAINT DF_Course_CourseNumber DEFAULT (N'N/A'),
	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Course_UserAuthorizationKey DEFAULT -1,
	[DateAdded] [TIME].[DateAdded] NULL
		CONSTRAINT DF_Course_DateAdded DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
		CONSTRAINT DF_Course_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[Course]
	(
	Code,
	Sec,
	CourseName,
	CourseNumber,
	UserAuthorizationKey,
	DateAdded,
	DateOfLastUpdate
	)
	SELECT DISTINCT 
	G.Code,
	G.Sec,
	S.CourseName,
	S.CourseNumber,
	@UserAuthorizationKey,
	SYSDATETIME(),
	SYSDATETIME()
	FROM  Mode.GoodData AS G
	CROSS APPLY dbo.SplitCourseColumn(G.[Course (hr, crd)]) AS S
	ORDER BY S.CourseName, S.CourseNumber, G.Sec, G.Code

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[Course]);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Create Course table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;


END
GO



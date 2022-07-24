USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateInstructorCourses]    Script Date: 5/13/2022 12:46:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Project3].[CreateInstructorCourses] @UserAuthorizationKey [INT].SurrogateKeyInt
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[InstructorCourses];
	CREATE TABLE [Data].[InstructorCourses]
	(
		[AssignmentID] [INT].SurrogateKeyInt NOT NULL 
			CONSTRAINT PK_AssignmentID PRIMARY KEY CLUSTERED ([AssignmentID]) IDENTITY(1,1),
		[InstructorID] [INT].SurrogateKeyInt NOT NULL 
			CONSTRAINT DF_InstructorCourse_InstructorID DEFAULT -1,
		[TeachingCourse] [String].[CourseName] NOT NULL
			CONSTRAINT DF_InstructorCourse_CourseName DEFAULT (N'N\A'),
		[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
			CONSTRAINT DF_InstructorCourse_UserAuthorizationKey DEFAULT -1,
		[DateAdded] [TIME].[DateAdded] NULL
			CONSTRAINT DF_InstructorCourse_DateAdded DEFAULT SYSDATETIME(),
		[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
			CONSTRAINT DF_InstructorCourse_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[InstructorCourses] 
	(
		[InstructorID],
		[TeachingCourse],
		[UserAuthorizationKey],
		[DateAdded],
		[DateOfLastUpdate]
	)
		SELECT DISTINCT 
			I2.InstructorID,
			C.CourseName,
			@UserAuthorizationKey,
			SYSDATETIME(),
			SYSDATETIME()
		FROM Mode.GoodData AS G
		CROSS APPLY dbo.SplitInstructorColumn(G.Instructor) AS I
		CROSS APPLY dbo.SplitCourseColumn(G.[Course (hr, crd)]) AS C
		INNER JOIN [Data].Instructors AS I2
		ON (I.FirstName = I2.FirstName AND I.LastName = I2.LastName)

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[InstructorCourses]);

        DECLARE @EndTime [TIME].[EndTime] =SYSDATETIME();

        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Created InstructorCourses Table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=NULL;

END
GO



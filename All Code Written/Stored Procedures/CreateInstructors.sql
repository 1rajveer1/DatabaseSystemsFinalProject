USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateInstructors]    Script Date: 5/13/2022 12:47:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Project3].[CreateInstructors] @UserAuthorizationKey [INT].SurrogateKeyInt
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[Instructors];
	CREATE TABLE [Data].[Instructors]
	(
		[InstructorID] [INT].SurrogateKeyInt NOT NULL 
			CONSTRAINT PK_InstructorId PRIMARY KEY CLUSTERED ([InstructorID]) IDENTITY(1101,1),
		[FirstName] [STRING].[FirstName] NOT NULL
			CONSTRAINT DF_Instructors_FirstName DEFAULT(N'N/A'),
		[LastName] [STRING].[LastName] NOT NULL
			CONSTRAINT DF_Instructors_LastName DEFAULT(N'N/A'),
		[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
			CONSTRAINT DF_Instructor_UserAuthorizationKey DEFAULT -1,
		[DateAdded] [TIME].[DateAdded] NULL
			CONSTRAINT DF_Instructor_DateAdded DEFAULT SYSDATETIME(),
		[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
			CONSTRAINT DF_Instructor_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[Instructors] 
	(
		[FirstName],
		[LastName],
		[UserAuthorizationKey],
		[DateAdded],
		[DateOfLastUpdate]
	)
	SELECT DISTINCT
		I.[FirstName],
		I.[LastName],
		@UserAuthorizationKey,
		SYSDATETIME(),
		SYSDATETIME()
	FROM Mode.GoodData AS G
	CROSS APPLY dbo.SplitInstructorColumn(G.Instructor) AS I

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[Instructors]);

        DECLARE @EndTime [TIME].[EndTime] =SYSDATETIME();

        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Created Instructors table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=NULL;

END
GO



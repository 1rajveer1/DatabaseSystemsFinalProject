USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateDepartment]    Script Date: 5/13/2022 12:46:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Project3].[CreateDepartment] @UserAuthorizationKey [INT].SurrogateKeyInt
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[Departments];
	CREATE TABLE [Data].[Departments]
	(
		[DepartmentID] [INT].SurrogateKeyInt NOT NULL 
			CONSTRAINT PK_DepartmentId PRIMARY KEY CLUSTERED ([DepartmentID]) IDENTITY(1,1),
		[CourseName] [STRING].[CourseName] NOT NULL UNIQUE,
		[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
			CONSTRAINT DF_Departments_UserAuthorizationKey DEFAULT -1,
		[DateAdded] [TIME].[DateAdded] NULL
			CONSTRAINT DF_Departments_DateAdded DEFAULT SYSDATETIME(),
		[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
			CONSTRAINT DF_Departments_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[Departments] 
	(
		[CourseName],
		[UserAuthorizationKey],
		[DateAdded],
		[DateOfLastUpdate]
	)
	SELECT DISTINCT
		[CourseName],
		@UserAuthorizationKey,
		SYSDATETIME(),
		SYSDATETIME()
	FROM Mode.GoodData AS G
	CROSS APPLY dbo.SplitCourseColumn(G.[Course (hr, crd)])

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[Departments]);

        DECLARE @EndTime [TIME].[EndTime] =SYSDATETIME();

        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Created Department table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
										@EndTime=@EndTime,
                                        @ClassTime=null;


END
GO



USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[NormalizeDatabase]    Script Date: 5/13/2022 12:47:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [Project3].[NormalizeDatabase] @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();
	EXEC Project3.SettingTables;
	EXEC Project3.DropForiegnKeys @UserAuthorizationKey = 2;
	EXEC Project3.CreateCourse @UserAuthorizationKey = 2;
	EXEC Project3.CreateDepartment @UserAuthorizationKey = 1;
	EXEC Project3.CreateInstructors @UserAuthorizationKey = 1;
	EXEC Project3.CreateInstructorCourses @UserAuthorizationKey = 1;
	EXEC Project3.CreateModeOfInstructionTable @UserAuthorizationKey = 2;
	EXEC Project3.CreateBldingName @UserAuthorizationKey = 5;
	EXEC Project3.CreateRoomNumber @UserAuthorizationKey = 2;
	EXEC Project3.CreateClass @UserAuthorizationKey = 4;
	EXEC Project3.AddForiegnKeys  @UserAuthorizationKey = 2;

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Normalize QueensClassSchedule Database',
                                        @WorkflowStepTableRowCount = 0,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END
GO



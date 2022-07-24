USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[DropForiegnKeys]    Script Date: 5/13/2022 12:47:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project3].[DropForiegnKeys] @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	ALTER TABLE [Data].[Classes]
	DROP CONSTRAINT IF EXISTS FK_Classes_CourseID; 

	ALTER TABLE [Data].[Classes]
	DROP CONSTRAINT IF EXISTS FK_Classes_InstructorID;

	ALTER TABLE [Data].[Classes]
	DROP CONSTRAINT IF EXISTS FK_Classes_BuildingNameID;

	ALTER TABLE [Data].[Classes]
	DROP CONSTRAINT IF EXISTS FK_Classes_RoomNumber;

	ALTER TABLE [Data].[Classes]
	DROP CONSTRAINT IF EXISTS FK_Classes_ModeOfInstructionID;

	ALTER TABLE [Data].InstructorCourses
	DROP CONSTRAINT IF EXISTS FK_InstructorCourses_InstructorID;

	ALTER TABLE [Data].InstructorCourses
	DROP CONSTRAINT IF EXISTS FK_InstructorCourses_TeachingCourse;

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();

	EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Drop Foreign Keys',
                                        @WorkflowStepTableRowCount = 0,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;

END
GO



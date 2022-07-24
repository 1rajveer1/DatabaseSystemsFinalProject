USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[AddForiegnKeys]    Script Date: 5/13/2022 12:46:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project3].[AddForiegnKeys]  @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	ALTER TABLE [Data].[Classes]
	ADD CONSTRAINT FK_Classes_CourseID FOREIGN KEY (CourseID) REFERENCES [Data].[Course](CourseID);

	ALTER TABLE [Data].[Classes]
	ADD CONSTRAINT FK_Classes_InstructorID FOREIGN KEY (InstructorID) REFERENCES [Data].[Instructors](InstructorID);

	ALTER TABLE [Data].[Classes]
	ADD CONSTRAINT FK_Classes_BuildingNameID FOREIGN KEY (BuildingID) REFERENCES [Data].BuildingName(BuildingNameID);

	ALTER TABLE [Data].[Classes]
	ADD CONSTRAINT FK_Classes_RoomNumber FOREIGN KEY (RoomNumber) REFERENCES [Data].RoomNumber(RoomNumber);

	ALTER TABLE [Data].[Classes]
	ADD CONSTRAINT FK_Classes_ModeOfInstructionID FOREIGN KEY (ModeOfInstructionID) REFERENCES [Data].ModeOfInstruction(ModeOfInstructionID);

	ALTER TABLE [Data].InstructorCourses
	ADD CONSTRAINT FK_InstructorCourses_InstructorID FOREIGN KEY (InstructorID) REFERENCES [Data].Instructors(InstructorID);

	ALTER TABLE [Data].InstructorCourses
	ADD CONSTRAINT FK_InstructorCourses_TeachingCourse FOREIGN KEY ([TeachingCourse]) REFERENCES [Data].[Departments](CourseName);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Add Foreign Keys',
                                        @WorkflowStepTableRowCount = 0,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END

DROP PROCEDURE IF EXISTS Project3.DropForeignKeys;
GO



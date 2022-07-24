USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateClass]    Script Date: 5/13/2022 12:46:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [Project3].[CreateClass] @UserAuthorizationKey [INT].SurrogateKeyInt
AS
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[Classes];
	CREATE TABLE [Data].[Classes]
	(
	ClassID [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_Class_ClassID PRIMARY KEY,
	CourseID [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Classes_CourseID DEFAULT -1,
	CourseName [STRING].CourseName NOT NULL
		CONSTRAINT DF_Classes_CourseName DEFAULT (N'N/A'),
	CourseNumber [STRING].CourseNumber NOT NULL
		CONSTRAINT DF_Classes_CourseNumber DEFAULT (N'N/A'),
	[Description] [STRING].[Description] NOT NULL
		CONSTRAINT DF_Classes_Description DEFAULT (N'N/A'),
	[Day] [TIME].[Day] NOT NULL
		CONSTRAINT DF_Classes_Day DEFAULT -1,
	StartTime [TIME].[ClassStartTime] NOT NULL
		CONSTRAINT DF_Classes_ClassStartTime DEFAULT -1,
	EndTime [TIME].[ClassEndTIme] NOT NULL
		CONSTRAINT DF_Classes_ClassEndTIme DEFAULT -1,
	[Hour] [TIME].[Hour] NOT NULL
		CONSTRAINT DF_Classes_Hour DEFAULT -1,
	Credit [INT].[Credit] NOT NULL
		CONSTRAINT DF_Classes_Credit DEFAULT -1,
	InstructorID [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Classes_InstructorID DEFAULT -1,
	BuildingID [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Classes_BuildingID DEFAULT -1,
	RoomNumber [CHAR].RoomNumber NOT NULL
		CONSTRAINT DF_Classes_RoomNumber DEFAULT -1,
	Enrolled [INT].[Enrolled] NOT NULL
		CONSTRAINT DF_Classes_Enrolled DEFAULT -1,
	Limit [INT].[Limit] NOT NULL
		CONSTRAINT DF_Classes_Limit DEFAULT -1,
	ModeOfInstructionID [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Classes_ModeOfInstructionID DEFAULT -1,
	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_Classes_UserAuthorizationKey DEFAULT -1,
	[DateAdded] [TIME].[DateAdded] NULL
		CONSTRAINT DF_Classes_DateAdded DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
		CONSTRAINT DF_Classes_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[Classes]
	(
	CourseID,
	CourseName,
	CourseNumber,
	[Description],
	[Day],
	StartTime,
	EndTime,
	[Hour],
	Credit,
	InstructorID,
	BuildingID,
	RoomNumber,
	Enrolled,
	Limit,
	ModeOfInstructionID,
	UserAuthorizationKey,
	DateAdded,
	DateOfLastUpdate
	)
	SELECT DISTINCT C2.CourseID,
		C2.CourseName,
		C2.CourseNumber,
		G.[Description],
		D.[Day],
		T.StartTime,
		T.EndTime,
		C1.[Hour(s)],
		C1.[Credit(s)],
		I2.InstructorID,
		BN.BuildingNameID,
		RN.RoomNumber,
		G.Enrolled,
		G.Limit,
		MOI.ModeOfInstructionID,
		@UserAuthorizationKey,
		SYSDATETIME(),
		SYSDATETIME()
	FROM Mode.GoodData AS G
	 CROSS APPLY dbo.SplitCourseColumn(G.[Course (hr, crd)]) AS C1
        CROSS APPLY dbo.SplitDayColumn(G.[Day]) AS D
        CROSS APPLY dbo.SplitInstructorColumn(G.Instructor) AS I1 
        CROSS APPLY dbo.SplitTimeColumn(G.[Time]) AS T
        CROSS APPLY dbo.SplitLocationColumn(G.[Location]) AS L
		INNER JOIN [Data].Course AS C2 ON (C1.CourseName = C2.CourseName AND C1.CourseNumber = C2.CourseNumber AND G.Sec = C2.Sec AND G.Code = C2.Code)
        INNER JOIN [Data].Instructors as I2 ON (I1.FirstName=I2.FirstName AND I1.LastName = I2.LastName)
        INNER JOIN [Data].BuildingName as BN ON (L.BuildingName=BN.BuildingName)
		INNER JOIN [Data].RoomNumber as RN ON (l.RoomNumber = RN.RoomNumber)
        INNER JOIN [Data].[ModeOfInstruction] as MOI ON (G.[Mode Of Instruction]=MOI.ModeOfInstructions)


	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[Classes]);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Create Class table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END;
GO



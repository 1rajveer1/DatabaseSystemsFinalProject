USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateModeOfInstructionTable]    Script Date: 5/13/2022 12:47:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Project3].[CreateModeOfInstructionTable] @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[ModeOfInstruction];
	CREATE TABLE [Data].[ModeOfInstruction]
	(
	ModeOfInstructionID [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_ModeOfInstructionID PRIMARY KEY,
	ModeOfInstructions [STRING].ModeOfInstruction NOT NULL
		CONSTRAINT DF_ModeOfInstruction_ModeOfInstructions DEFAULT (N'N\A'),
	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_ModeOfInstruction_UserAuthorizationKey DEFAULT -1,
	[DateAdded] [TIME].[DateAdded] NULL
		CONSTRAINT DF_ModeOfInstruction_DateAdded DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
		CONSTRAINT DF_ModeOfInstruction_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[ModeOfInstruction]
	(
	ModeOfInstructions,
	[UserAuthorizationKey],
	[DateAdded],
	[DateOfLastUpdate]
	)
	SELECT DISTINCT 
	G.[Mode of Instruction],
	@UserAuthorizationKey,
	SYSDATETIME(),
	SYSDATETIME()
	FROM Mode.GoodData AS G

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[ModeOfInstruction]);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Create ModeOfInstruction table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END
GO



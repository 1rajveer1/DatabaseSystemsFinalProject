USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateRoomNumber]    Script Date: 5/13/2022 12:47:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Project3].[CreateRoomNumber] @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[RoomNumber];
	CREATE TABLE [Data].[RoomNumber]
	(
	[RoomNumber] [CHAR].RoomNumber NOT NULL
		CONSTRAINT PK_RoomNumber_RoomNumber PRIMARY KEY,
	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_RoomNumber_UserAuthorizationKey DEFAULT -1,
	[DateAdded] [TIME].[DateAdded] NULL
		CONSTRAINT DF_RoomNumber_DateAdded DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
		CONSTRAINT DF_RoomNumber_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[RoomNumber]
	(
	RoomNumber,
	[UserAuthorizationKey],
	[DateAdded],
	[DateOfLastUpdate]
	)
	SELECT DISTINCT 
	L.RoomNumber,
	@UserAuthorizationKey,
	SYSDATETIME(),
	SYSDATETIME()
	FROM Mode.GoodData AS G
	CROSS APPLY dbo.SplitLocationColumn(G.Location) AS L
	

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[RoomNumber]);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Create RoomNumber table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END
GO



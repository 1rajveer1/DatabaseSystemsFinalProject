USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateBldingName]    Script Date: 5/13/2022 12:46:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Project3].[CreateBldingName] @UserAuthorizationKey [INT].SurrogateKeyInt
AS 
BEGIN

	DECLARE @StartTime [TIME].[StartTime] = SYSDATETIME();

	DROP TABLE IF EXISTS [Data].[BuildingName];
	CREATE TABLE [Data].[BuildingName]
	(
	BuildingNameID [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_BuildingName_BuildingNameID PRIMARY KEY,
	BuildingName [CHAR].BuildingName NOT NULL
		CONSTRAINT DF_BuildingName_BuildingName DEFAULT (N'N\A'),
	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL
		CONSTRAINT DF_BuildingName_UserAuthorizationKey DEFAULT -1,
	[DateAdded] [TIME].[DateAdded] NULL
		CONSTRAINT DF_BuildingName_DateAdded DEFAULT SYSDATETIME(),
	[DateOfLastUpdate] [TIME].[DateOfLastUpdate] NULL
		CONSTRAINT DF_BuildingName_DateOfLastUpdate DEFAULT SYSDATETIME()
	)
	INSERT INTO [Data].[BuildingName]
	(
	BuildingName,
	[UserAuthorizationKey],
	[DateAdded],
	[DateOfLastUpdate]
	)
	SELECT DISTINCT 
		L.BuildingName,
		@UserAuthorizationKey,
		SYSDATETIME(),
		SYSDATETIME()
	FROM Mode.GoodData AS G
	CROSS APPLY dbo.SplitLocationColumn(G.Location) AS L
	

	DECLARE @RowCount [INT].[WorkFlowStepTableRowCount] = (SELECT COUNT(*) FROM [Data].[BuildingName]);

	DECLARE @EndTime [TIME].[EndTIme] = SYSDATETIME();


        EXEC [Process].[usp_TrackWorkFlow] @UserAuthorizationKey=@UserAuthorizationKey,
                                        @WorkFlowStepsDescription=N'Create BuidingName table',
                                        @WorkflowStepTableRowCount = @RowCount,
                                        @StartTime=@StartTime,
                                        @EndTime=@EndTime,
                                        @ClassTime=null;
END
GO



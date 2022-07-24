USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[SettingTables]    Script Date: 5/13/2022 12:48:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [Project3].[SettingTables]
AS
BEGIN

	DROP TABLE IF EXISTS Process.WorkFlowSteps;
	CREATE TABLE Process.WorkFlowSteps
	(	[WorkFlowStepKey] [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
			CONSTRAINT PK_WorkFlowStepKey PRIMARY KEY,
		[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL,
		[WorkFlowStepDescription] [STRING].[WorkFlowStepsDescription] NOT NULL,
		[WorkFlowStepTableRowCount] [INT].[WorkFlowStepTableRowCount] NULL,
		[StartingDateTime] [TIME].StartTime NULL DEFAULT SYSDATETIME(),
		[EndingDateTime] [TIME].EndTime NULL DEFAULT SYSDATETIME(),
		[ClassTime] [CHAR].[ClassTime] NULL DEFAULT ('9:15'),
	)

	DROP TABLE IF EXISTS DbSecurity.UserAuthorization;
	CREATE TABLE DbSecurity.UserAuthorization
	(	[UserAuthorizationKey] [INT].SurrogateKeyInt NOT NULL IDENTITY(1,1)
			CONSTRAINT PK_UserAuthorizationKey PRIMARY KEY,
		[ClassTime] [CHAR].[ClassTime] NULL
			CONSTRAINT def_ClassTime DEFAULT ('9:15'),
		[IndivisualProject] [STRING].[IndivisualProject] NULL
			CONSTRAINT def_IndivisualProject DEFAULT ('PROJECT 3 NORMALIZE QueensClassSchedule DATABASE'),
		[GroupMemberFirstName] [STRING].[GroupMemberFirstName] NOT NULL,
		[GroupMemberLastName] [STRING].[GroupMemberLastName] NOT NULL,
		[DateAdded] [TIME].[DateAdded] NULL
			CONSTRAINT def_DateAdded DEFAULT SYSDATETIME()
	)

	INSERT INTO DbSecurity.UserAuthorization (GroupMemberLastName,GroupMemberFirstName)
		VALUES (N'Enerio',N'Edison'),
			   (N'Patel',N'Meet'),
			   (N'Rahman',N'Mashiur'),
			   (N'Roth',N'Eliyahu'),
			   (N'Singh',N'Rajveer');

END
GO



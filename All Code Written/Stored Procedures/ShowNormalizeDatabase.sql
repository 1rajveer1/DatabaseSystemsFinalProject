USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[ShowNormalizeDatabase]    Script Date: 5/13/2022 12:48:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project3].[ShowNormalizeDatabase]
AS 
BEGIN
	EXEC Project3.NormalizeDatabase @UserAuthorizationKey = 2;
	EXEC Process.ShowWorkFlowSteps;
END;
GO



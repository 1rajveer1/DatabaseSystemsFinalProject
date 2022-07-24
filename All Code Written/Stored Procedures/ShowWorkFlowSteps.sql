DROP PROCEDURE IF EXISTS Process.ShowWorkFlowSteps;
GO
CREATE PROCEDURE Process.ShowWorkFlowSteps
AS
BEGIN
	SELECT *
	FROM Process.WorkFlowSteps;
END
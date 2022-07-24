----------------------------------------------------
---- TIME TO LOAD EVERYTHING INTO DATABASE
----------------------------------------------------

--USE QueensClassSchedule;
--SELECT CONCAT (DATEDIFF (MILLISECOND, MIN(StartingDateTime), MAX(EndingDateTime)), ' ms') AS [Total Time to Load Star Minus Delay],
--CONCAT(SUM(DATEDIFF (MILLISECOND, StartingDateTime, EndingDateTime)), ' ms') AS [Total Time to Run Procedures]
--FROM Process.WorkFlowSteps
--WHERE WorkFlowStepDescription <> 'Normalize QueensClassSchedule Database'

----------------------------------------------------
---- PROCEDURE FOR EACH PERSON
----------------------------------------------------
--USE QueensClassSchedule;
--SELECT WFS.UserAuthorizationKey,
--CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
--CONCAT(SUM(DATEDIFF (MILLISECOND, WFS.StartingDateTime, WFS.EndingDateTime)), ' ms') AS TimeToExecuteAllProcedures,

--  (SELECT CONCAT(SUM(DATEDIFF (MILLISECOND, WFS2.StartingDateTime, WFS2.EndingDateTime)), ' ms')
--   FROM Process.WorkFlowSteps AS WFS2
--   WHERE WFS2.UserAuthorizationKey <= WFS.UserAuthorizationKey AND  WFS2.WorkFlowStepDescription <> 'Normalize QueensClassSchedule Database'
--   ) AS TOTAL

--FROM Process.WorkFlowSteps AS WFS
--INNER JOIN DbSecurity.UserAuthorization AS UA
--ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
--WHERE WFS.WorkFlowStepDescription <> 'Normalize QueensClassSchedule Database'
--GROUP BY WFS.UserAuthorizationKey, CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName)
--ORDER BY WFS.UserAuthorizationKey;

--------------------------------------------------
-- SHOW TRACK WORK FLOW
--------------------------------------------------

--USE QueensClassSchedule;
--EXEC Process.ShowWorkflowSteps;
--GO

--------------------------------------------------
-- PROCEDURE FOR EDISON
--------------------------------------------------
USE QueensClassSchedule;
SELECT CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
       UA.UserAuthorizationKey,
       WFS.WorkFlowStepKey,
       WFS.WorkFlowStepDescription,
       WFS.WorkFlowStepTableRowCount,
       WFS.StartingDateTime,
       WFS.EndingDateTime,
       WFS.ClassTime
FROM Process.WorkFlowSteps AS WFS
INNER JOIN DbSecurity.UserAuthorization AS UA
ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
WHERE  WFS.UserAuthorizationKey = 1
ORDER BY WFS.WorkFlowStepKey;

--------------------------------------------------
-- PROCEDURE FOR MEET
--------------------------------------------------
USE QueensClassSchedule;
SELECT CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
       UA.UserAuthorizationKey,
       WFS.WorkFlowStepKey,
       WFS.WorkFlowStepDescription,
       WFS.WorkFlowStepTableRowCount,
       WFS.StartingDateTime,
       WFS.EndingDateTime,
       WFS.ClassTime
FROM Process.WorkFlowSteps AS WFS
INNER JOIN DbSecurity.UserAuthorization AS UA
ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
WHERE  WFS.UserAuthorizationKey = 2
ORDER BY WFS.WorkFlowStepKey;

--------------------------------------------------
-- PROCEDURE FOR MASHIUR
--------------------------------------------------
USE QueensClassSchedule;
SELECT CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
       UA.UserAuthorizationKey,
       WFS.WorkFlowStepKey,
       WFS.WorkFlowStepDescription,
       WFS.WorkFlowStepTableRowCount,
       WFS.StartingDateTime,
       WFS.EndingDateTime,
       WFS.ClassTime
FROM Process.WorkFlowSteps AS WFS
INNER JOIN DbSecurity.UserAuthorization AS UA
ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
WHERE  WFS.UserAuthorizationKey = 3
ORDER BY WFS.WorkFlowStepKey;

--------------------------------------------------
-- PROCEDURE FOR ELI
--------------------------------------------------
USE QueensClassSchedule;
SELECT CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
       UA.UserAuthorizationKey,
       WFS.WorkFlowStepKey,
       WFS.WorkFlowStepDescription,
       WFS.WorkFlowStepTableRowCount,
       WFS.StartingDateTime,
       WFS.EndingDateTime,
       WFS.ClassTime
FROM Process.WorkFlowSteps AS WFS
INNER JOIN DbSecurity.UserAuthorization AS UA
ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
WHERE  WFS.UserAuthorizationKey = 4
ORDER BY WFS.WorkFlowStepKey;

--------------------------------------------------
-- PROCEDURE FOR RAJ
--------------------------------------------------
USE QueensClassSchedule;
SELECT CONCAT(UA.GroupMemberFirstName, ' ', UA.GroupMemberLastName) AS MemberName,
       UA.UserAuthorizationKey,
       WFS.WorkFlowStepKey,
       WFS.WorkFlowStepDescription,
       WFS.WorkFlowStepTableRowCount,
       WFS.StartingDateTime,
       WFS.EndingDateTime,
       WFS.ClassTime
FROM Process.WorkFlowSteps AS WFS
INNER JOIN DbSecurity.UserAuthorization AS UA
ON UA.UserAuthorizationKey = WFS.UserAuthorizationKey
WHERE  WFS.UserAuthorizationKey = 5
ORDER BY WFS.WorkFlowStepKey;
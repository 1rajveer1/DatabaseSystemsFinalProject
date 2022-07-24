USE [QueensClassSchedule]
GO

/****** Object:  StoredProcedure [Project3].[CreateUdts]    Script Date: 5/13/2022 12:47:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Project3].[CreateUdts] 
AS 
BEGIN

	-- General
	DROP TYPE IF EXISTS [INT].SurrogateKeyInt;
	CREATE TYPE [INT].SurrogateKeyInt FROM INT;

	-- UserAuthorization
	DROP TYPE IF EXISTS [TIME].[DateAdded]; 
    CREATE TYPE [TIME].[DateAdded] FROM DATETIME2(7);

    DROP TYPE IF EXISTS [TIME].[DateOfLastUpdate]; 
    CREATE TYPE [TIME].[DateOfLastUpdate] FROM DATETIME2(7);

	DROP TYPE IF EXISTS [STRING].[IndivisualProject];
	CREATE TYPE [STRING].[IndivisualProject] FROM NVARCHAR(60);

	DROP TYPE IF EXISTS [STRING].[GroupMemberFirstName];
	CREATE TYPE [STRING].[GroupMemberFirstName] FROM NVARCHAR(35);

	DROP TYPE IF EXISTS [STRING].[GroupMemberLastName];
	CREATE TYPE [STRING].[GroupMemberLastName] FROM NVARCHAR(25);




	-- Work Flow Steps
	DROP TYPE IF EXISTS [TIME].StartTime;
	CREATE TYPE [TIME].StartTime FROM DATETIME2;

	DROP TYPE IF EXISTS [TIME].EndTime;
	CREATE TYPE [TIME].EndTime FROM DATETIME2;

	DROP TYPE IF EXISTS [STRING].[WorkFlowStepsDescription];
	CREATE TYPE [STRING].[WorkFlowStepsDescription] FROM NVARCHAR(100) NOT NULL;
	
	DROP TYPE IF EXISTS [INT].[WorkFlowStepTableRowCount];
	CREATE TYPE [INT].[WorkFlowStepTableRowCount] FROM INT NULL;
	
	DROP TYPE IF EXISTS [CHAR].[ClassTime];
	CREATE TYPE [CHAR].[ClassTime] FROM NVARCHAR(5) NULL;


	-- Course Table
	DROP TYPE IF EXISTS [INT].Code;
	CREATE TYPE [INT].Code FROM INT;

	DROP TYPE IF EXISTS [CHAR].Section;
	CREATE TYPE [CHAR].Section  FROM VARCHAR(10);

	DROP TYPE IF EXISTS [STRING].CourseName;
	CREATE TYPE [STRING].CourseName FROM VARCHAR(10);

	DROP TYPE IF EXISTS [STRING].CourseNumber;
	CREATE TYPE [STRING].CourseNumber FROM VARCHAR(10);

	-- Mode of Instruction
	DROP TYPE IF EXISTS [STRING].ModeOfInstruction;
	CREATE TYPE [STRING].ModeOfInstruction FROM VARCHAR(20);

	--Building Name
	DROP TYPE IF EXISTS [CHAR].BuildingName;
	CREATE TYPE [CHAR].BuildingName FROM VARCHAR(2);

	-- RoomNumber
	DROP TYPE IF EXISTS [CHAR].RoomNumber;
	CREATE TYPE [CHAR].RoomNumber FROM VARCHAR(5);

	-- Classes
	DROP TYPE IF EXISTS [STRING].[Description];
	CREATE TYPE [STRING].[Description] FROM VARCHAR(50);

	DROP TYPE IF EXISTS [TIME].[Day];
	CREATE TYPE [TIME].[Day] FROM VARCHAR(50)

	DROP TYPE IF EXISTS [TIME].[ClassStartTime];
	CREATE TYPE [TIME].[ClassStartTime] FROM VARCHAR(5);

	DROP TYPE IF EXISTS [TIME].[ClassEndTime];
	CREATE TYPE [TIME].[ClassEndTime] FROM VARCHAR(5);

	DROP TYPE IF EXISTS [TIME].[Hour];
	CREATE TYPE [TIME].[Hour] FROM VARCHAR(5);

	DROP TYPE IF EXISTS [INT].[Credit];
	CREATE TYPE [INT].[Credit] FROM INT;

	DROP TYPE IF EXISTS [INT].[Enrolled];
	CREATE TYPE [INT].[Enrolled] FROM INT;

	DROP TYPE IF EXISTS [INT].[Limit];
	CREATE TYPE [INT].[Limit] FROM INT;
END
GO



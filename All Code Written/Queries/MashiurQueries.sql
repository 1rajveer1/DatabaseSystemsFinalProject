
-- Find all math courses where Enrollment greater than 30
SELECT distinct
CourseName , 
Description ,
Enrolled  

FROM Data.Classes

WHERE CourseName LIKE ('%Math') AND Enrolled > 30;

-- Find  classes where mininum number of students enrolled in 
SELECT 
CourseName as [Course] , 
Description  ,
Min(Enrolled) as [MinEnrollment] 

FROM Data.Classes

WHERE Enrolled = 12
GROUP BY CourseName, Description, Enrolled
ORDER BY CourseName, Description, Enrolled;

	

-- Find each Mode of Instruction for each class using Inner joins

Select C.CourseName, C.Description, MOI.ModeOfInstructions
From [Data].Classes as C
INNER JOIN [Data].[ModeOfInstruction] as MOI on (C.ModeOfInstructionID = MOI.ModeOfInstructionID) 

GROUP BY C.CourseName, C.Description, MOI.ModeOfInstructions

--See the Courses for the CSCI classes, as well as room number and professor names
Select distinct 
C.CourseName, C.Description, C.RoomNumber,  B.BuildingNameID, B.BuildingName, I.FirstName, I.LastName,MOI.ModeOfInstructions
From [Data].Classes as C 

INNER JOIN [Data].BuildingName as B 
	on (B.BuildingNameID = C.BuildingID) 
INNER JOIN [Data].Instructors as I 
	on (I.InstructorID = C.InstructorID)

	INNER JOIN [Data].[ModeOfInstruction] as MOI 
		on (MOI.ModeOfInstructionID = C.ModeOfInstructionID) 
	 WHERE C.CourseName LIKE ('%CSCI')




	
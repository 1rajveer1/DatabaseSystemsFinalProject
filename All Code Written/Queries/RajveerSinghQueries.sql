
/*	Rajveer Singh Queries */


/*	1.  List the name of all the instructors that teach in the science building and their room numbers from highest to lowest	*/
Use QueensClassSchedule;
Select I.FirstName,	I.LastName, B.BuildingName, R.RoomNumber
From Data.Instructors as I
Join Data.Classes as C
On i.InstructorID = c.InstructorID
Join  Data.RoomNumber as R
on R.RoomNumber = C.RoomNumber
Join Data.BuildingName as B
On B.BuildingNameID = C.BuildingID
Where B.BuildingName = 'SB'
Group by I.FirstName, I.LastName, R.RoomNumber, B.BuildingName
Order by R.RoomNumber

/*	2. Find the total number of teaching in each building that are teaching Physics		*/

Use QueensClassSchedule;
Select C.CourseName, B.BuildingName, Count(B.BuildingName) as ClassesInBuilding
From Data.Course as C
Join Data.Classes as Cl
On C.CourseID = Cl.CourseID
join Data.BuildingName as B
On Cl.BuildingID = B.BuildingNameID
Where C.CourseName = 'Phys'
Group by  C.CourseName, B.BuildingName

/*	3. 	Which professor teaches the most classes 	*/

Use QueensClassSchedule;
Select Top (1) I.InstructorID, Concat(I.FirstName, ' ', I.LastName) as Name ,Count(C.CourseName) as Total
From data.Instructors as I 
Join Data.Classes as C
On I.InstructorID = C.InstructorID
Join Data.Course as Co
on Co.CourseID = C.CourseID
Group By I.InstructorID, Concat(I.FirstName, ' ', I.LastName) ,(C.CourseName) 
Order BY Total DESC

/*	4. Show the length of time for all computer science classes that are In Person		*/

Use QueensClassSchedule;
Select distinct D.CourseName, C.CourseNumber, C.Description, DATEDIFF(MINUTE, c.StartTime, c.EndTime) as ClassLength, M.ModeOfInstructions
From Data.Classes as C 
Join Data.ModeOfInstruction as M
On C.ModeOfInstructionID  = M.ModeOfInstructionID
Join Data.Departments as D
on D.CourseName = C.CourseName
Where D.CourseName = 'CSCI' AND M.ModeOfInstructions = 'In-Person' 
Order by ClassLength DESC
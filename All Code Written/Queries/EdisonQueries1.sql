/*
Proposition:
Show all instructors who are teaching in classes in multiple departments

*/
SELECT CONCAT(I.FirstName, ' ', I.LastName) AS Instructor, Dept.Departments AS [Departments Teaching], COUNT(IC.InstructorID) AS [Count of Departments Teaching]
FROM [Data].InstructorCourses AS IC 
	INNER JOIN [Data].Instructors AS I
	ON IC.InstructorID = I.InstructorID
	INNER JOIN 
	(SELECT InstructorID, (select string_agg(value,', ') from (select distinct value from string_split(string_agg(TeachingCourse, ','),',')) t) as Departments
	FROM [Data].InstructorCourses
	GROUP BY InstructorID) AS Dept
	ON I.InstructorID = Dept.InstructorID
GROUP BY IC.InstructorID, I.FirstName, I.LastName, Dept.Departments
HAVING COUNT(IC.InstructorID) > 1;
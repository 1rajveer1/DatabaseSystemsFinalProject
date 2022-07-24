/*
Proposition:
How many instructors are in each department?

*/

SELECT TeachingCourse AS Department, COUNT(TeachingCourse) AS [Number of Instructors]
FROM [Data].InstructorCourses
GROUP BY TeachingCourse
ORDER BY TeachingCourse
--How may classes that are being taught that semester grouped by course and aggregating the total enrollment, total class limit and the percentage of enrollment.
SELECT [CourseName], CourseNumber, SUM(Enrolled) as [Total Enrolled], Sum([Limit]) as [Total Limit], Case 
                                                                                                        WHEN (SUM([Limit]) != 0 ) then CAST(Sum(Enrolled) as numeric)/CAST(SUM([Limit]) as numeric)*100
                                                                                                        Else -1
                                                                                                        END as [Percentage Enrolled]
  FROM [QueensClassSchedule].[Data].[Classes]
  GROUP BY CourseName, CourseNumber
  Order by CourseName, CourseNumber



--How many classes are each instructor teaching?
Select I.FirstName, I.LastName, COUNT(C.ClassID) as [Number Of Classes Teaching]
From [Data].Classes as C INNER JOIN [Data].[Instructors] as I on (C.InstructorID=I.InstructorID)
GROUP BY C.InstructorID, I.FirstName, I.LastName


--What percentage of the total courses is each mode of instruction?
Select ModeOfInstructions, COUNT(*) as [Number Of Classes Taught], COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS [Percentage Of All Classes]
From [Data].Classes as C INNER JOIN [Data].ModeOfInstruction as MOI on (C.ModeOfInstructionID=MOI.ModeOfInstructionID)
GROUP BY C.ModeOfInstructionID, MOI.ModeOfInstructions
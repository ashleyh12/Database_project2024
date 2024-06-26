-- Insert into Department: This adds a new department with DeptID 1 named "Computer Science".
INSERT INTO Department (DeptID, Name) VALUES (1, 'Computer Science');
-- Insert into Course: Adds a course named "Intro to Computer Science" (CS101) for the Fall semester of 2023, belonging to the Computer Science department (DeptID 1).
INSERT INTO Course (CourseID, DeptID, Number, Name, Semester, Year) VALUES (1, 1, 'CS101', 'Intro to Computer Science', 'Fall', 2023);
-- Insert into Student: Adds two students, John Doe and Jane Q Doe, with StudentIDs 1 and 2, respectively.
INSERT INTO Student (StudentID, FirstName, LastName) VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Q Doe');
-- Insert into Enrollment: Registers John and Jane in the course CS101 by creating enrollment records linking the students to the course.
INSERT INTO Enrollment (EnrollmentID, StudentID, CourseID) VALUES (1, 1, 1), (2, 2, 1);
-- Insert into AssignmentCategory: Creates two categories of assignments for the course—Homework and Exam, homework weighed at 20% and the exam at 50%
INSERT INTO AssignmentCategory (CategoryID, CourseID, Name, Weight) VALUES (1, 1, 'Homework', 20.00), (2, 1, 'Exam', 50.00),(3, 1, 'Course Participation', 10.00),(4, 1, 'Projects', 20.00);
-- Insert into Assignment: Adds two assignments, "HW1" under the Homework category and "Midterm" under the Exam category.
INSERT INTO Assignment (AssignmentID, CategoryID, Name) VALUES (1, 1, 'HW1'), (2, 2, 'Midterm');
-- Insert into Scores: Records scores for both students on both assignments, such as John scoring 85 on HW1 and 78 on Midterm.
INSERT INTO Scores (ScoreID, AssignmentID, StudentID, Score) VALUES (1, 2, 1, 85.00), (2, 1, 2, 90.00), (3, 2, 1, 78.00), (4, 2, 2, 88.00);

-- Select from Student: Retrieves all records from the Student table.
SELECT * FROM Student;


-- Task 7:
-- Add an assignment to a course
INSERT INTO Assignment (AssignmentID, CategoryID, Name) VALUES (3, 2, 'Final Exam');

-- Task 8:
-- Change the percentages of the categories for a course
UPDATE AssignmentCategory 
SET Weight = 60.00 
WHERE CourseID = 1 AND Name = 'Exam';

-- Task 9:
-- Add 2 points to the score of each student on an assignment
UPDATE Scores 
SET Score = Score + 2 
WHERE AssignmentID = 2;

-- Task 10:
-- Add 2 points to  students whose last name contains a ‘Q’
UPDATE Scores
SET Score = Score + 2
WHERE AssignmentID = 2
AND StudentID IN (
    SELECT StudentID FROM Student WHERE LastName LIKE '%Q%'
    );

-- Task 5:
-- Complex Join Including Scores: This more complex query retrieves a list of students in CourseID 1, along with their scores on all assignments. It joins several tables to collect this information:
-- Student to get student names.
-- Enrollment to filter students by course.
-- Scores to get the scores for each student.
-- Assignment to get the names of the assignments.
-- AssignmentCategory and Course are joined through the chain but not directly used in the selection; however, they are necessary to link assignments to courses.
SELECT 
    s.StudentID, s.FirstName, s.LastName, 
    a.Name AS AssignmentName, sc.Score
FROM 
    Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    JOIN Scores sc ON s.StudentID = sc.StudentID
    JOIN Assignment a ON sc.AssignmentID = a.AssignmentID
    JOIN AssignmentCategory ac ON a.CategoryID = ac.CategoryID
    JOIN Course c ON ac.CourseID = c.CourseID
WHERE 
    c.CourseID = 1;

-- Task 4:
-- Get the average, highest, and lowest scores for each assignment in CourseID 

SELECT 
    a.Name AS AssignmentName,
    AVG(sc.Score) AS AverageScore,
    MAX(sc.Score) AS HighestScore,
    MIN(sc.Score) AS LowestScore
FROM 
    Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    JOIN Scores sc ON s.StudentID = sc.StudentID
    JOIN Assignment a ON sc.AssignmentID = a.AssignmentID
    JOIN AssignmentCategory ac ON a.CategoryID = ac.CategoryID
    JOIN Course c ON ac.CourseID = c.CourseID
WHERE 
    c.CourseID = 1
GROUP BY 
    a.Name;

-- Task 11:
SELECT 
    s.StudentID, s.FirstName, s.LastName,
    AVG(sc.Score) AS AverageGrade
FROM 
    Student s
    JOIN Scores sc ON s.StudentID = sc.StudentID
GROUP BY 
    s.StudentID;

-- Task 12:
-- Compute the average grade for a student, where the lowest score for a given category is dropped
-- This query calculates the average grade for each student after dropping their lowest score for each assignment category.
WITH MinScorePerCategory AS (
    SELECT 
        s.StudentID,
        a.CategoryID,
        MIN(sc.Score) AS MinScore,
        COUNT(*) AS AssignmentCount
    FROM 
        Student s
        JOIN Scores sc ON s.StudentID = sc.StudentID
        JOIN Assignment a ON sc.AssignmentID = a.AssignmentID
    GROUP BY 
        s.StudentID, a.CategoryID
)
SELECT 
    s.StudentID, s.FirstName, s.LastName,
    AVG(CASE 
        WHEN m.AssignmentCount = 1 THEN sc.Score
        WHEN sc.Score > m.MinScore THEN sc.Score 
        ELSE NULL 
    END) AS AverageGrade
FROM 
    Student s
    JOIN Scores sc ON s.StudentID = sc.StudentID
    JOIN MinScorePerCategory m ON s.StudentID = m.StudentID AND sc.AssignmentID = m.CategoryID
GROUP BY 
    s.StudentID;

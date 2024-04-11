-- Departments
-- Department Table: Stores information about departments. Each department has a unique identifier (DeptID) and a name (Name). For example, the Computer Science department.
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

-- Courses
-- Course Table: Contains courses offered by departments. Each course has a unique identifier (CourseID), a department identifier to show which department offers the course (DeptID), a course number (Number), a name (Name), the semester it's offered (Semester), and the year (Year). The DeptID acts as a foreign key linking each course to its department.
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    DeptID INT,
    Number VARCHAR(10),
    Name VARCHAR(255),
    Semester VARCHAR(50),
    Year INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Assignment Categories
-- AssignmentCategory Table: Differentiates between types of assignments (e.g., exams, homework). It includes a unique identifier (CategoryID), the course it belongs to (CourseID), a name (Name), and a weight (Weight) indicating its importance in the overall course grading. The CourseID serves as a foreign key connecting the category to its course.
CREATE TABLE AssignmentCategory (
    CategoryID INT PRIMARY KEY,
    CourseID INT,
    Name VARCHAR(255),
    Weight DECIMAL(5,2),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Assignments
-- Assignment Table: Details individual assignments. Each has a unique identifier (AssignmentID), a category it belongs to (CategoryID), and a name (Name). The CategoryID is a foreign key that links the assignment to its respective category.
CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY,
    CategoryID INT,
    Name VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES AssignmentCategory(CategoryID)
);

-- Students
-- Student Table: Holds student information, with each student having a unique identifier (StudentID), a first name (FirstName), and a last name (LastName).
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255)
);

-- Enrollments
-- Enrollment Table: Tracks which students are enrolled in which courses. It includes a unique identifier (EnrollmentID), a student identifier (StudentID), and a course identifier (CourseID). The StudentID and CourseID are foreign keys that reference the Student and Course tables, respectively.
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Scores
-- Scores Table: Records the scores students receive on assignments. Each entry has a unique identifier (ScoreID), an assignment identifier (AssignmentID), a student identifier (StudentID), and the score (Score). The AssignmentID and StudentID are foreign keys linking the score to the respective assignment and student.
CREATE TABLE Scores (
    ScoreID INT PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    Score DECIMAL(5,2),
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

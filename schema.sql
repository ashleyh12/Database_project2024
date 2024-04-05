-- Departments
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

-- Courses
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
CREATE TABLE AssignmentCategory (
    CategoryID INT PRIMARY KEY,
    CourseID INT,
    Name VARCHAR(255),
    Weight DECIMAL(5,2),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Assignments
CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY,
    CategoryID INT,
    Name VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES AssignmentCategory(CategoryID)
);

-- Students
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255)
);

-- Enrollments
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Scores
CREATE TABLE Scores (
    ScoreID INT PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    Score DECIMAL(5,2),
    FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

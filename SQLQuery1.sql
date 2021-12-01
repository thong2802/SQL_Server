CREATE DATABASE THONGNGUYEN
GO

CREATE TABLE Student(
	StudentID nvarchar(255) Primary key,
	Fullname  nvarchar(255),
	AverageScore float,
	FacultyID int
);


ALTER TABLE Student
ADD FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID);

CREATE TABLE Faculty(
	FacultyID int Primary key,
	FacultyName  nvarchar(255)	
);



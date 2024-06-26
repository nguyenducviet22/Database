﻿--DROP DATABASE StudentManagement

CREATE DATABASE StudentManagement

USE StudentManagement

CREATE TABLE Major
(
	MajorID char(2) PRIMARY KEY,         -- PK Primary Key
	MajorName varchar(30),
	Hotline varchar(11)
)

INSERT INTO Major VALUES('SE', 'Software Engineering', '090x')
INSERT INTO Major VALUES('IA', 'Information Assurance', '091x')
INSERT INTO Major VALUES('GD', 'Graphic Design', '092x')
INSERT INTO Major VALUES('JP', 'Japanese', '093x')
INSERT INTO Major VALUES('KR', 'Korean', '094x')

SELECT * FROM Major

--DROP TABLE Student
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,          -- PK Primary Key
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50), 
	MajorID char(2) REFERENCES Major(MajorID)  -- FK Foreign Key
)

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE3', N'Trần', N'Ba', 'SE');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE6', N'Võ', N'Sáu', 'IA');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD8', N'Huỳnh', N'Tám', 'GD');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('JP9', N'Ngô', N'Chín', 'JP');

SELECT * FROM Student

-- TỪ TỪ HÃY THÊM VÀO ĐỂ XEM FULL-OUTER JOIN RA SAO
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('UNK', N'Đặng', N'Mười', NULL);

SELECT s.*, m.MajorName, m.Hotline FROM Student s RIGHT JOIN Major m 
									ON s.MajorID = m.MajorID 
									WHERE s.MajorID IN ('SE', 'IA')

SELECT * FROM Major
SELECT * FROM Student

SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID HAVING COUNT(MajorID) >= 3
SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID 
	HAVING COUNT(MajorID) <= ALL(SELECT COUNT(MajorID) FROM Student GROUP BY MajorID)

SELECT COUNT(*) AS [No SE student] FROM Student WHERE MajorID = 'SE'
SELECT MajorID, COUNT(*) AS [No SE student] FROM Student WHERE MajorID = 'SE' GROUP BY MajorID
SELECT MajorID, COUNT(*) AS [No SE student] FROM Student GROUP BY MajorID HAVING MajorID = 'SE'

SELECT m.MajorID, m.MajorName, COUNT(*) AS [No students] FROM Student s INNER JOIN Major m 
	ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName

SELECT s.StudentID ,m.MajorID, m.MajorName FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID
SELECT m.MajorID, m.MajorName, COUNT(m.MajorID) AS [No students] FROM Student s RIGHT JOIN Major m 
	ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName --KR = 1
SELECT m.MajorID, m.MajorName, COUNT(s.MajorID) AS [No students] FROM Student s RIGHT JOIN Major m 
	ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName --KR = 0
SELECT m.MajorID, m.MajorName, COUNT(StudentID) AS [No students] FROM Student s RIGHT JOIN Major m 
	ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName --KR = 0
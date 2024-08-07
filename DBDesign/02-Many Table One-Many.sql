﻿CREATE DATABASE DBDESIGN_ONEMANY

USE DBDESIGN_ONEMANY

CREATE TABLE MajorV1
(
	MajorID char(2) PRIMARY KEY,
	MajorName nvarchar(40) NOT NULL
)

INSERT INTO MajorV1 VALUES ('SE', 'Software Engineering')
INSERT INTO MajorV1 VALUES ('IS', 'Information System')

CREATE TABLE StudentV1
(
	StudentID char(8),
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime,
	[Address] nvarchar(50),
	MajorID char(2)
	CONSTRAINT PK_STUDENTV1 PRIMARY KEY(StudentID)
)

INSERT INTO StudentV1 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')
INSERT INTO StudentV1 VALUES ('SE2', N'Tran', N'Binh', 2004, NULL, 'GD')

SELECT * FROM StudentV1
SELECT * FROM MajorV1

DROP TABLE MajorV2
CREATE TABLE MajorV2
(
	MajorID char(2) PRIMARY KEY,
	MajorName nvarchar(40) NOT NULL
)

INSERT INTO MajorV2 VALUES ('SE', 'Software Engineering')
INSERT INTO MajorV2 VALUES ('IS', 'Information System')

CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime,
	[Address] nvarchar(50),
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID) --full command
--	MajorID char(2) REFERENCES MajorV2(MajorID)
)

INSERT INTO StudentV2 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')
INSERT INTO StudentV2 VALUES ('SE2', N'Tran', N'Binh', NULL, 'TP HCM', 'IS')

SELECT * FROM StudentV2
SELECT * FROM MajorV2

----------------------------------------------------
DROP TABLE MajorV3
CREATE TABLE MajorV3
(
	MajorID char(2) PRIMARY KEY,
	MajorName nvarchar(40) NOT NULL
)

DROP TABLE StudentV3
/*CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime,
	[Address] nvarchar(50),
	MajorID char(2) CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY REFERENCES MajorV3(MajorID)
)*/

CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime,
	[Address] nvarchar(50),
	MajorID char(2) DEFAULT 'SE' CONSTRAINT FK_StudentV3_MajorV3 
			FOREIGN KEY REFERENCES MajorV3(MajorID) ON DELETE SET DEFAULT ON UPDATE CASCADE
)

--Do not enter majorId -> automatically set as SE cuz of DEFAULT
INSERT INTO StudentV3(StudentID, LastName, FirstName) VALUES ('SE2', N'Tran', N'Phat')

--Delete JP (PK) -> DEFAULT -> set as SE
DELETE FROM MajorV3 WHERE MajorID = 'JP'

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)

INSERT INTO MajorV3 VALUES ('SE', N'Software Engineering')
INSERT INTO StudentV3 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')

INSERT INTO MajorV3 VALUES ('CH', N'Chinese Language')
INSERT INTO StudentV3 VALUES ('CH2', N'Nguyễn', N'Cuong', NULL, NULL, 'CH')

DELETE FROM StudentV3 WHERE StudentID = 'ch2'
DELETE FROM MajorV3 WHERE MajorID = 'CH'

--Cannot delete MajorId cuz of being a PK
DELETE FROM MajorV3 WHERE MajorID = 'CH'

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY (MajorID) 
			REFERENCES MajorV3(MajorID) ON DELETE CASCADE ON UPDATE CASCADE

--Update info PK -> change all obj having this PK
UPDATE MajorV3 SET MajorID = 'CL' WHERE MajorID = 'CH'

--Delete a major -> delete all student in this major
--Delete a PK -> delete all obj having this PK
DELETE FROM MajorV3 WHERE MajorID = 'CL'

INSERT INTO MajorV3 VALUES ('JP', N'Japan Language')
INSERT INTO StudentV3 VALUES ('JP2', N'Nguyễn', N'Binh', NULL, NULL, 'JP')

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY (MajorID) 
			REFERENCES MajorV3(MajorID) ON DELETE SET NULL ON UPDATE CASCADE

UPDATE MajorV3 SET MajorID = 'JL' WHERE MajorID = 'JP'
--Delete PK -> all obj having this PK set as NULL
DELETE FROM MajorV3 WHERE MajorID = 'JL'

INSERT INTO StudentV3 VALUES ('JP1', N'Tran', N'Duong', NULL, NULL, NULL)
--If majorId is NULL -> automatically set as 'CH'
UPDATE StudentV3 SET MajorID = 'CH' WHERE MajorID IS NULL

SELECT * FROM StudentV3
SELECT * FROM MajorV3

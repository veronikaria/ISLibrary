﻿CREATE TABLE Book
(
	Code INT NOT NULL PRIMARY KEY, 
	Name NVARCHAR(100) NOT NULL,
	EditionId INT NOT NULL,
	Year INT NOT NULL,
	IsExclusion BIT NOT NULL DEFAULT 0,

	CONSTRAINT check_year CHECK(Year<=YEAR(GETDATE())),
	CONSTRAINT FK_Book_Edition FOREIGN KEY (EditionId) REFERENCES Edition(Id)
)

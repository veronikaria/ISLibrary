﻿CREATE TABLE Author
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Lastname  NVARCHAR(50) NOT NULL,
	Firstname  NVARCHAR(50) NOT NULL,
	Middlename  NVARCHAR(50) NULL
)

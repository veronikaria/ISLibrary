﻿CREATE TABLE Reader
(
	Ticket_Number INT IDENTITY(1,1) PRIMARY KEY,  
	Lastname  NVARCHAR(50) NOT NULL,
	Passport CHAR(9) NOT NULL UNIQUE,
	Birthdate DATE NULL,
	Address NVARCHAR(100) NULL,
	Phone CHAR(13) NULL,
	Education NVARCHAR(10),
	IsDegreeScientific BIT DEFAULT 0,
	DateReRegistration DATE DEFAULT GETDATE(),

	CONSTRAINT Check_Education CHECK (Education IN ('початкова','середня','вища'))
)
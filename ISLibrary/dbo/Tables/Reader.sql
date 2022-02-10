CREATE TABLE Reader
(
	Ticket_Number INT PRIMARY KEY,  
	Lastname  NVARCHAR(50) NOT NULL,
	Passport CHAR(9) NOT NULL UNIQUE,
	Birthdate DATE NULL,
	Address NVARCHAR(100) NULL,
	Phone CHAR(13) NULL,
	Education NVARCHAR(10),
	IsDegreeScientific BIT DEFAULT 0,
	DateRegistration DATE DEFAULT GETDATE(),
	DateReRegistration DATE DEFAULT GETDATE(),
	IsExclusion BIT NOT NULL DEFAULT 0,

	CONSTRAINT Check_Education CHECK (Education IN (N'початкова', N'середня', N'вища'))
)
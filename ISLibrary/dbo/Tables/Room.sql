CREATE TABLE Room
(
	Number INT IDENTITY(1,1) PRIMARY KEY,  
	Name NVARCHAR(100) NOT NULL,
	Roominess INT NOT NULL,
	
	CONSTRAINT Check_Roominess CHECK (Roominess>0)
)



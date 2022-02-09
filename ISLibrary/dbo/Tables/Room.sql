CREATE TABLE Room
(
	Number INT IDENTITY(1,1) PRIMARY KEY,  
	Code_Book INT NOT NULL,
	Roominess INT NOT NULL,

	CONSTRAINT Check_Roominess CHECK (Roominess>0)
)


CREATE TABLE Accounting
(
	Id INT IDENTITY(1,1) PRIMARY KEY,  
	Number_Room INT NOT NULL,
	Code_Book INT NOT NULL,
	Ticket_Number INT NOT NULL,
	DateGetBook DATETIME NOT NULL DEFAULT GETDATE(),
	DateReturnBook DATETIME NULL,

	CONSTRAINT FK_Accounting_Book FOREIGN KEY (Code_Book) REFERENCES Book(Code),
	CONSTRAINT FK_Accounting_Room FOREIGN KEY (Number_Room) REFERENCES Room(Number),
	CONSTRAINT FK_Accounting_Reader FOREIGN KEY (Ticket_Number) REFERENCES Reader(Ticket_Number)
)


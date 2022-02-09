CREATE TABLE Book_Author
(
	Code_Book INT NOT NULL,
	Id_Author INT NOT NULL,

	PRIMARY KEY(Code_Book, Id_Author),
	CONSTRAINT FK_Book_Author_Book FOREIGN KEY (Code_Book) REFERENCES Book(Code),
	CONSTRAINT FK_Book_Author_Author FOREIGN KEY (Id_Author) REFERENCES Author(Id)
)



CREATE TABLE Room_Book
(
	Number_Room INT NOT NULL,
	Code_Book INT NOT NULL,
	Quantity INT NOT NULL,

	PRIMARY KEY(Number_Room, Code_Book),
	CONSTRAINT FK_Room_Book_Room FOREIGN KEY (Number_Room) REFERENCES Room(Number),
	CONSTRAINT FK_Room_Book_Book FOREIGN KEY (Code_Book) REFERENCES Book(Code)
)


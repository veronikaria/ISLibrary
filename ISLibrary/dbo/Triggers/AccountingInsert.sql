CREATE TRIGGER dbo.AccountingInsert
ON dbo.Accounting
INSTEAD OF INSERT
AS
BEGIN
DECLARE @room INT
DECLARE @book INT
DECLARE @ticket INT
DECLARE @dateget DATETIME
DECLARE @datereturn DATETIME
DECLARE @cnt_poss INT
DECLARE @roominess INT
DECLARE @cnt_busy_book INT
DECLARE @cnt_allowed_book INT
DECLARE accounting_Cursor CURSOR FAST_FORWARD 
FOR 
SELECT Number_Room, Code_Book, Ticket_Number, DateGetBook, DateReturnBook FROM inserted	
 OPEN accounting_Cursor 
 FETCH NEXT FROM accounting_Cursor into @room, @book, @ticket, @dateget, @datereturn
 WHILE @@FETCH_STATUS = 0 
 BEGIN 
 SELECT @cnt_poss=COUNT(*) 
	FROM Accounting
	WHERE Number_Room=@room 
	AND DateReturnBook<@dateget
	SELECT @roominess = Roominess
	FROM Room 
	WHERE Number=@room
	SELECT @cnt_busy_book=COUNT(*) 
	FROM Accounting
	WHERE Code_Book=@book 
	AND Number_Room = @room
	AND DateGetBook<@dateget
	AND (DateReturnBook>@dateget
	OR DateReturnBook IS NULL)
	SELECT @cnt_allowed_book=Quantity
	FROM Room_Book 
	WHERE Number_Room = @room 
	AND Code_Book = @book
 IF @cnt_poss<@roominess AND @cnt_busy_book<@cnt_allowed_book
 BEGIN
	INSERT INTO Accounting
	(Number_Room, Code_Book, Ticket_Number, DateGetBook, DateReturnBook)
	VALUES
	(@room, @book, @ticket, @dateget, @datereturn)
 END
 ELSE
 PRINT 'Sorry! This room or book is busy!'
 FETCH NEXT FROM accounting_Cursor into @room, @book, @ticket, @dateget, @datereturn
 END
CLOSE accounting_Cursor
DEALLOCATE accounting_Cursor
END

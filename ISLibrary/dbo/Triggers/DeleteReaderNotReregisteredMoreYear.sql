-- Исключить из списка читателей людей, которые записались в библиотеку больше года назад и не прошли перерегистрацию.
CREATE TRIGGER DeleteReaderNotReregisteredMoreYear
ON Reader
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ticket_number INT
	DECLARE @date INT
	DECLARE mycursor CURSOR FAST_FORWARD FOR 
	SELECT Ticket_Number, DateReRegistration  FROM deleted
	OPEN mycursor
	FETCH NEXT FROM mycursor into @ticket_number, @date
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		UPDATE Reader 
		SET IsExclusion = 1
		WHERE Ticket_Number=@ticket_number
		FETCH NEXT FROM mycursor into @ticket_number, @date
	END
	CLOSE mycursor
	DEALLOCATE mycursor
END

-- Списать старую или утраченную книгу.
CREATE TRIGGER DeleteOldOrLostBook
ON Book
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @code INT
	DECLARE mycursor CURSOR FAST_FORWARD FOR 
	SELECT Code  FROM deleted
	OPEN mycursor
	FETCH NEXT FROM mycursor into @code
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		UPDATE Book 
		SET IsExclusion = 1
		WHERE Code=@code
		FETCH NEXT FROM mycursor into @code
	END
	CLOSE mycursor
	DEALLOCATE mycursor
END
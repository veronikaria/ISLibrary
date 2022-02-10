-- Выдача справки о количестве книг автора в читальном зале
-- поиск автора по идентификатору
CREATE FUNCTION QuantityBooksByAuthorId(@id INT)
RETURNS INT
AS
BEGIN
	DECLARE @cnt INT;
	SELECT @cnt=COUNT(*)  FROM Book b
	JOIN Book_Author ba ON b.Code=ba.Code_Book
	WHERE ba.Id_Author = @id;
	RETURN @cnt
END
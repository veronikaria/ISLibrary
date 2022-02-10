-- Выдача справки о количестве книг автора в читальном зале
-- поиск автора по ФИО
CREATE FUNCTION QuantityBooksByAuthorPIB(@lastname NVARCHAR(50), 
@firstname NVARCHAR(50), @middlename NVARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @cnt INT;
	SELECT @cnt=COUNT(*) FROM Book b
	JOIN Book_Author ba ON b.Code=ba.Code_Book
	JOIN Author a ON a.Id=ba.Id_Author
	WHERE a.Lastname=@lastname 
	AND a.Firstname=@firstname 
	AND COALESCE(a.Middlename, 'NULL')=COALESCE(@middlename, 'NULL')
	RETURN @cnt
END
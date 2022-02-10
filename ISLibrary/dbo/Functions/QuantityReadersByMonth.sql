-- отчет о работе библиотеки в течение месяца
-- количество читателей, записавшихся в библиотеку за отчетный месяц
CREATE FUNCTION QuantityReadersByMonth(@month INT)
RETURNS INT
AS
BEGIN
	DECLARE @cnt INT
	SELECT @cnt=COUNT(*) FROM Reader
	WHERE MONTH(DateRegistration)=@month
	AND YEAR(DateRegistration)=YEAR(GETDATE())
	RETURN @cnt
END

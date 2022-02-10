-- отчет о работе библиотеки в течение месяца
-- какие книги и сколько раз были взяты за отчетный месяц
CREATE PROCEDURE ReportNameAndQuantityBooksByMonth(@month INT)
AS
BEGIN
SELECT b.Code, b.Name, COUNT(*) Quantity FROM Book b
JOIN Accounting a ON b.Code=a.Code_Book
WHERE MONTH(DateGetBook)=@month
GROUP BY b.Code, b.Name
END
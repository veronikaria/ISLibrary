-- отчет о работе библиотеки в течение месяца
-- количество книг и читателей на текущий день в каждом из залов и в библиотеке в целом
CREATE PROCEDURE ReportQuantityBooksAndReaders(@month INT)
AS
BEGIN
SELECT t1.Day, t1.Number_Room, t1.QuantityReadersAndBooks, t2.TotalQuantityReadersAndBooks
FROM
(SELECT  DAY(DateGetBook) AS Day, Number_Room, COUNT(*) AS QuantityReadersAndBooks
FROM Accounting
WHERE MONTH(DateGetBook)=@month AND YEAR(DateGetBook)=YEAR(GETDATE())
GROUP BY  Number_Room, DAY(DateGetBook)) t1
JOIN
(SELECT  DAY(DateGetBook) AS Day, COUNT(*) AS TotalQuantityReadersAndBooks
FROM Accounting
WHERE MONTH(DateGetBook)=@month AND YEAR(DateGetBook)=YEAR(GETDATE())
GROUP BY DAY(DateGetBook)) t2
ON t1.Day=t2.Day
END


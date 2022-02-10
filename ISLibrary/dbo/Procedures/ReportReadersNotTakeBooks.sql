-- кто из читателей не брал книг
CREATE PROCEDURE ReportReadersNotTakeBooks
AS
BEGIN
SELECT r.Ticket_Number, r.Lastname,r.Phone FROM Reader r
LEFT JOIN Accounting a ON r.Ticket_Number=a.Ticket_Number
WHERE a.Id IS NULL
END


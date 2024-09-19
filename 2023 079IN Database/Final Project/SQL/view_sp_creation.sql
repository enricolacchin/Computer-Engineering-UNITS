-- VIEWS CREATION --
DROP VIEW IF EXISTS BOD_Members;
CREATE VIEW BOD_Members AS
SELECT firstName, lastName, jobTitle FROM employees
WHERE BOD = 'T';

DROP VIEW IF EXISTS currentYearInvoices;
CREATE VIEW currentYearInvoices AS
SELECT * FROM invoices
WHERE YEAR(issuedDate) = YEAR(CURRENT_TIMESTAMP);

DROP VIEW IF EXISTS yearTurnover;
CREATE VIEW yearTurnover AS
SELECT YEAR(issuedDate) AS Year, sum(amount) AS Turnover FROM invoices
GROUP BY YEAR(issuedDate);

-- STORE PROCEDURE CREATION --
DROP PROCEDURE IF EXISTS clientNInvoices;
CREATE PROCEDURE clientNInvoices(IN numInvoices INT(5))
BEGIN
SELECT customerID, customers.name, count(DISTINCT invoiceID) AS numInvoices FROM invoices
INNER JOIN projects ON projects.invoice = invoices.invoiceID
INNER JOIN customers ON customers.customerID = projects.client
WHERE YEAR(issuedDate) = YEAR(CURRENT_TIMESTAMP)
GROUP BY customerID
HAVING count(DISTINCT invoiceID) >= numInvoices;
END;

DROP PROCEDURE IF EXISTS invoicesBetweenDates;
CREATE PROCEDURE invoicesBetweenDates(IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT customerID, customers.name, invoiceID, issuedDate FROM invoices
    INNER JOIN projects ON projects.invoice = invoices.invoiceID
    INNER JOIN customers ON customers.customerID = projects.client
    WHERE issuedDate BETWEEN startDate AND endDate;
END;
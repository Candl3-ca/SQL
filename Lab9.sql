/*1. Create the tables and add the primary and foreign keys for this database.
*/

CREATE TABLE CUSTOMER(
CUST_NUM CHAR(4) PRIMARY KEY,
CUST_LNAME VARCHAR(20),
CUST_FNAME VARCHAR(20),
CUST_BALANCE NUMERIC);

CREATE TABLE INVOICE(
INV_NUM CHAR(4) PRIMARY KEY,
CUST_NUM char(4),
INV_DATE DATE,
INV_AMOUNT NUMERIC);

ALTER TABLE INVOICE
ADD CONSTRAINT INV_CUSTNUM_FK FOREIGN KEY(CUST_NUM) REFERENCES CUSTOMER;


/*2. Insert the data into the tables you created in Problem 1. All operations must be executed as 
one transaction unit. What would the statements look like? How to save the changes permanently in 
the database?
*/

INSERT INTO CUSTOMER VALUES ('1000', 'Smith', 'Jeane', 1050.11);
INSERT INTO CUSTOMER VALUES ('1001', 'Ortega', 'Juan', 840.92);


INSERT INTO INVOICE VALUES('8000', '1000', '23-Mar-10', 235.89);
INSERT INTO INVOICE VALUES('8001', '1001', '23-Mar-10', 312.82);
INSERT INTO INVOICE VALUES('8002', '1001', '30-Mar-10', 528.10);
INSERT INTO INVOICE VALUES('8003', '1000', '12-Apr-10', 194.78);
INSERT INTO INVOICE VALUES('8004', '1000', '23-Apr-10', 619.44);


/*3. Create a view that shows the invoice number, the customer number, the invoice date, and 
the invoice amount for all customers with a invoice amount of $500 or more. Add an option 
to your view so whenever you update or insert a row of the base tables through a view, 
database engine ensures that the insert or update operation is conformed with the 
definition of the view.*/

CREATE OR REPLACE VIEW VW_CUS_INV_INFO
AS
SELECT CUST_NUM, INV_DATE, INV_AMOUNT FROM INVOICE
WHERE INV_AMOUNT > 500
WITH CHECK OPTION;


/*4. Write the query that will create a sequence to produce automatic customer number. Start 
the customer numbers at 1002.
*/

CREATE SEQUENCE SEQ_CUSNUM
START WITH 1002;


/*5. Modify the CUSTOMER table to include a new attribute: CUST_DOB. Update Customer table 
such that customer 1000 was born on March 15, 1979, and customer 1001 was born on 
December 22, 1988. */

ALTER TABLE CUSTOMER 
ADD CUST_DOB DATE;

UPDATE CUSTOMER 
SET CUST_DOB = '15-Mar-1979'
WHERE CUST_NUM = '1000';

UPDATE CUSTOMER 
SET CUST_DOB = '22-Dec-1988'
WHERE CUST_NUM = '1001';


/*6. Write a procedure prc_cust_add to add a new customer to the CUSTOMER table. Use a 
sequence that you created in Problem 4 for cust_number values. Test the procedure by 
using the following values: ‘Rauthor’, ‘Peter’, 0.00. Run a query to see if the record has been 
added.*/

CREATE OR REPLACE PROCEDURE prc_cust_add
AS
BEGIN
INSERT INTO CUSTOMER (CUST_NUM,CUST_LNAME,CUST_FNAME,CUST_BALANCE ) VALUES (SEQ_CUSNUM.NEXTVAL, 'Rauthor', 'Peter', 0.00);
END;

/*7. Write the trigger trg_updatecustbalance to update the CUST_BALANCE in the CUSTOMER 
table when a new invoice record is entered. Test the trigger, using the following new 
INVOICE record: 8005, 1001, ‘27-APR-10', 225.40. Run a query to see if the CUST_BALANCE 
has been changed.*/

CREATE OR REPLACE TRIGGER trg_updatecustbalance 
AFTER INSERT ON INVOICE 
FOR EACH ROW
BEGIN
UPDATE CUSTOMER
SET CUST_BALANCE = :NEW.INV_AMOUNT + CUST_BALANCE;
END;



/*8. Write a procedure to delete an invoice, giving the invoice number as a parameter. Name 
the procedure prc_inv_delete. Test the procedure by deleting invoices 8005 and 8006.*/

CREATE OR REPLACE PROCEDURE PRO_INV_DELETE(VINV_NUM INVOICE.INV_NUM%TYPE)
AS
BEGIN
DELETE INVOICE 
WHERE VINV_NUM = INV_NUM;
END;

/* Deleted customer records must be moved to a customer history table */

CREATE TABLE CUS_HISTORY (
CUS_CODE NUMBER,
CUS_FNAME VARCHAR(40),
CUS_LNAME VARCHAR(40));

SELECT * FROM CUS_HISTORY;

CREATE OR REPLACE TRIGGER TRG_CUS_HIS
AFTER DELETE ON CUSTOMER
FOR EACH ROW
BEGIN
INSERT INTO CUS_HISTORY(CUS_CODE, CUS_FNAME, CUS_LNAME) VALUES (:OLD.CUS_CODE, :OLD.CUS_FNAME, :OLD.CUS_LNAME);
END;


/* Customer tables can only be modified between 8am to 6pm */

CREATE OR REPLACE TRIGGER MOD_CUS
BEFORE DELETE OR UPDATE OR INSERT ON CUSTOMER
BEGIN
IF TO_CHAR(SYSDATE, 'hh24') < '08' OR TO_CHAR(SYSDATE, 'hh24') > '18' THEN
RAISE_APPLICATION_ERROR (-20001, 'Data cannot be modified at this time');
END IF;
END;



/* Create a trigger that automatically reduces the quantity on hand for each
product sold after a new LINE row is added */

CREATE OR REPLACE TRIGGER TRG_RED_QOH
AFTER INSERT ON LINE
FOR EACH ROW
BEGIN
UPDATE PRODUCT
SET P_QOH = P_QOH - :NEW.LINE_UNITS
WHERE P_CODE = :NEW.P_CODE;
END;


/*  Create a trigger to evaluate the product's quantity on hand,
if the quantity on hand is below the minimum quantity shown in P_MIN,
the trigger will set the P_REORDER column to 1.
(Remember that the number 1 in the P_REORDER columen represents "YES.")*/

CREATE OR REPLACE TRIGGER TRG_REORDER
AFTER INSERT OR UPDATE OF P_QOH ,P_MIN ON PRODUCT
FOR EACH ROW
BEGIN
IF :NEW.P_QOH <= :NEW.P_MIN THEN
:NEW.P_REORDER := 1 
-----------UNDONE
UPDATE PRODUCT 
SET P_REORDER = 1
WHERE P_QOH <= P_MIN;
END;


/* Create a trigger to update the customer balance in the customer table
after inserting every new LINE row*/


CREATE OR REPLACE TRIGGER TRG_CUS_BALANCE
AFTER INSERT ON LINE
FOR EACH ROW
DECLARE
CUS_NUM NUMBER;
-- TO GET CUS CODE
BEGIN
SELECT CUS_CODE INT CUS_NUM
FROM INVOICE 
WHERE INV_NUMBER = :NEW.INV_NUMBER;
-- TO UPDATE CUS NUM
UPDATE CUSTOMER
SET CUS_BALANCE = CUS_BALANCE + :NEW.LINE_TOTAL
WHERE CUS_CODE = CUS_NUM;
END;


/*  */


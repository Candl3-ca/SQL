/* 1. Create a stored procedure to insert new rows in the RENTAL table. The procedure should 
satisfy the following conditions. 
a) The membership number will be provided as a parameter.
b) Use Count() function to verify that the membership number exists in the 
MEMBERSHIP table. If it does not exist, then a message should be displayed stating 
that the membership does not exist, and no data should be written to the database. 
c) If the membership does exist, then retrieve the membership balance and display a 
message stating the balance amount as the previous balance. (For example, if the 
membership has a balance of $5.00, then display “Previous balance: $5.00”.)
d) Test your procedure.
*/


CREATE SEQUENCE SEQ_RENT_NUM
START WITH 1004;

CREATE OR REPLACE PROCEDURE PROC_INSERT_RENTAL(MEM_NO MEMBERSHIP.MEM_NUM%TYPE)
AS
MEMCOUNT NUMBER;
previousbalance NUMERIC;
BEGIN 
    SELECT COUNT(*) INTO MEMCOUNT
    FROM MEMBERSHIP
    WHERE MEM_NUM = MEM_NO;
    IF (MEMCOUNT = 0) THEN
        DBMS_OUTPUT.PUT_LINE('The membership does not exist');
    ELSE
    SELECT MEM_BALANCE INTO previousbalance
    FROM MEMBERSHIP
    WHERE MEM_NUM = MEM_NO;
    DBMS_OUTPUT.PUT_LINE('Previous Balance: ' || previousbalance);
    INSERT INTO RENTAL VALUES(SEQ_RENT_NUM.NEXTVAL, SYSDATE, MEM_NO);
    DBMS_OUTPUT.PUT_LINE('ONE ROW HAS BEEN INSERTED');
END IF;
END;

EXECUTE PROC_INSERT_RENTAL(MEM_NO MEMBERSHIP.MEM_NUM%TYPE);

SELECT * FROM MEMBERSHIP;
SELECT * FROM RENTAL;


/* 2. Create a stored procedure to enter data about the return of videos that have been 
rented. The procedure should satisfy the following requirements. The video number will 
be provided as a parameter.
a) Verify the video number exists in the VIDEO table. If it does not exist, display a 
message that the video number provided was not found and do not write any data 
to the database.
b) If the video number does exist, then use a Count() function to ensure that the video 
has only one record in DETAILRENTAL for which it does not have a return date. If 
more than one row in DETAILRENTAL indicates that the video is rented but not 
returned, display an error message that the video has multiple outstanding rentals 
and do not write any data to the database.
c) If the video does not have any outstanding rentals, then update the video status for 
the video in the VIDEO table to “IN” and display a message that the video had no 
outstanding rentals, but it is now available for rental. If the video has only one 
outstanding rental, then update the return date to the current system date and
update the video status for that video in the VIDEO table to “IN”. Then display a 
message stating that the video was successfully returned
d) Test your procedure.*/



CREATE PROCEDURE VID_RETURNED_ORNOT(VID_NUM  VIDEO.VID_NUM%TYPE)
AS
CVID_NUM NUMBER;
CNT NUMBER;
BEGIN
    SELECT COUNT(*) INTO CVID_NUM
    FROM VIDEO
    WHERE VID_NUM = VID_NUM;
    IF (CVID_NUM = 0) THEN
        DBMS_OUTPUT.PUT_LINE('The video inputted does not exist in our database');
    ELSE
    SELECT COUNT(VID_NUM) INTO CNT FROM DETAILRENTAL
      WHERE VID_NUM = VID_NUM and DETAIL_RETURNDATE IS NULL;
        IF (CNT > 1) THEN
            DBMS_OUTPUT.PUT_LINE('The video has multiple outstanding rentals');
        ELSE
            DBMS_OUTPUT.PUT_LINE('The video has no multiple outstanding rentals, but the video is now available for rental');
            UPDATE VIDEO
            SET VIDEO_STATUS = 'IN' WHERE VID_NUM = VID_NUM;
            UPDATE DETAILRENTAL
            SET DETAIL_RETURNDATE = SYSDATE WHERE VID_NUM = VID_NUM;
        END IF;
        IF (CNT = 0) THEN
            DBMS_OUTPUT.PUT_LINE('The video has been successfully returned');
            UPDATE VIDEO
            SET VIDEO_STATUS = 'IN' WHERE VID_NUM = VID_NUM;
        END IF;
END;



DROP PROCEDURE VID_RETURNED_ORNOT;

SELECT * FROM VIDEO;
SELECT * FROM RENTAL;
select * from detailrental;

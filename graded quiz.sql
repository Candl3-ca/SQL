CREATE TABLE DONORS
(
 DONOR_ID CHAR(6) PRIMARY KEY,
 DONOR_NAME VARCHAR(30) NOT NULL,
 DONOR_AGE VARCHAR(3));

INSERT INTO DONORS VALUES ( '000001', 'FADI', '19');
INSERT INTO DONORS VALUES ( '000002', 'YAMAN', '19');

CREATE TABLE DONATIONS
( 
 PLEDGE_ID CHAR(6) PRIMARY KEY,
 PLEDGE_DATE DATE,
 AMOUNT_PLEDGED NUMERIC,
 ISPAID VARCHAR(3),
 DONOR_ID CHAR(6),
CONSTRAINT DONATIONS_DONORID_FK FOREIGN KEY (DONOR_ID) REFERENCES DONORS);

INSERT INTO DONATIONS VALUES ( '000011', '10-5-2022', '20', 'YES', '000001');
INSERT INTO DONATIONS VALUES ( '000012', '08-5-2022', '40', 'YES', '000002');

ALTER TABLE DONORS
ADD DONORS_AGE VARCHAR(3);

ALTER TABLE DONORS
ADD CONSTRAINT VERY_YOUNG CHECK (DONORS_AGE < 20);


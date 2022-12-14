CREATE TABLE NEW_USER (
ID_NUMBER NUMBER GENERATED ALWAYS AS IDENTITY,
USERPASS VARCHAR(10) NOT NULL);

INSERT INTO NEW_USER (USERPASS) VALUES('P123');


CREATE TABLE NEW_USER (
ID_NUMBER NUMBER GENERATED BY DEFAULT AS IDENTITY,
USERPASS VARCHAR(10) NOT NULL);

INSERT INTO NEW_USER VALUES(3, 'P123');
INSERT INTO NEW_USER (USERPASS) VALUES('P123');


CREATE TABLE NEW_USER (
ID_NUMBER NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
USERPASS VARCHAR(10) NOT NULL);

INSERT INTO NEW_USER VALUES(NULL, 'P123');
INSERT INTO NEW_USER VALUES(3, 'P123');
INSERT INTO NEW_USER (USERPASS) VALUES('P123');

CREATE TABLE NEW_USER (
ID_NUMBER NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 100 INCREMENT BY 10,
USERPASS VARCHAR(10) NOT NULL);


SELECT * FROM NEW_USER;


DROP TABLE NEW_USER;



CREATE SEQUENCE SEQ_USER_NUM;

INSERT INTO NEW_USER VALUES(SEQ_USER_NUM.NEXTVAL, 'P123');


CREATE TABLE CUSTOMER(
CUS_NUM NUMBER);

INSERT INTO CUSTOMER VALUES(SEQ_USER_NUM.NEXTVAL);

INSERT INTO CUSTOMER VALUES(SEQ_CUS_NUM.NEXTVAL);

CREATE SEQUENCE SEQ_CUS_NUM
START WITH 1000
INCREMENT BY 20
NOCACHE
MAXVALUE 1060;

SELECT * FROM CUSTOMER;


SELECT * FROM USER_SEQUENCES;


ALTER SEQUENCE SEQ_CUS_NUM
MAXVALUE 10000000000;

DROP SEQUENCE SEQ_CUS_NUM;
DROP SEQUENCE SEQ_USER_NUM;

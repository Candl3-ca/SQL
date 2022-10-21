CREATE SEQUENCE GEN_GUIDE_ID
START WITH 000001
INCREMENT BY 13
CYCLE
MAXVALUE 999999;
 
 CREATE TABLE GUIDES (
 GUIDES_ID NUMERIC GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
 FULL_NAME VARCHAR(30) NOT NULL,
 STREET# VARCHAR(5) NOT NULL,
 STREET_NAME VARCHAR(20) NOT NULL,
 CITY VARCHAR(10) NOT NULL,
 ZIPCODE VARCHAR(6) NOT NULL,
 DATE_OF_HIRE DATE,
 IS_QUALIFIED VARCHAR(3) NOT NULL,
 NO_OF_TRIPS VARCHAR(4));
 
 CREATE TABLE TRIP (
 TRIP_ID CHAR(4) PRIMARY KEY, 
 DATE_ DATE,
 TIME VARCHAR(10),
 IS_NEW CHAR(3),
 GUIDES_ID NUMERIC REFERENCES GUIDES ON DELETE CASCADE); -- SO WE DELETEINFORMATION ABOUT UNAVAILABLE GUIDES

 ALTER TABLE GUIDES
 ADD TRIP_ID CHAR(4);
 
 ALTER TABLE GUIDES
 ADD CONSTRAINT INV_ID FOREIGN KEY(TRIP_ID) REFERENCES TRIP ON DELETE CASCADE; -- SO WE DONT SHOW INFORMATION ABOUT UNAVAILABLE TRIPS
 
 CREATE TABLE TOURS (
 TOURS_ID CHAR(6) PRIMARY KEY, 
 TOUR_NAME VARCHAR(20) UNIQUE,
 LENGTH VARCHAR(10),
 FEE NUMERIC,
 TRACKER VARCHAR(10),
 TRIP_ID CHAR(4) REFERENCES TRIP ON DELETE CASCADE); -- SO WE DONT SHOW INFORMATION ABOUT UNAVAILABLE TOURS

 ALTER TABLE TRIP
 ADD TOURS_ID CHAR(6) REFERENCES TOURS;
 
 CREATE TABLE TOURS_TO_GUIDE (
 GUIDES_ID NUMERIC REFERENCES GUIDES,
 TOURS_ID CHAR(6) REFERENCES TOURS,
 PRIMARY KEY(GUIDES_ID, TOURS_ID));
 
 
 
 
 

 
 
 

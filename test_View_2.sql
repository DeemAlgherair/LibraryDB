
CREATE VIEW vBookStatus AS
  SELECT Auther_ID,BA.Author_Fname, BA.Author_Lname,B.ISBN,B.AvailabilityStatus
  FROM Book_Auother BA
    JOIN Book B ON B.ISBN = BA.ISBN
  WHERE B.AvailabilityStatus = 'Available';
--CREATE TRIGGER TO INSERT INTO COMPLEX VIEW 
 CREATE OR REPLACE TRIGGER vBookStatusT
INSTEAD OF INSERT ON vBookStatus
BEGIN
IF :new.AvailabilityStatus = 'Available' THEN
INSERT INTO Book (ISBN, AvailabilityStatus) VALUES (:new.ISBN,:new.AvailabilityStatus);
INSERT INTO Book_Auother (Auther_ID,Author_Fname, Author_Lname, ISBN) VALUES (:new.Auther_ID, :new.Author_Fname, :new.Author_Lname, :new.ISBN);
ELSE
RAISE_APPLICATION_ERROR(-20111,'UNAVAILABLE BOOKS ARE NOT ALLOWED');
END IF;
END; 
--TEST
-- ALLOWED
INSERT INTO vBookStatus VALUES ('0000000','Test Fname','Test Lname','0000000','Available');
--NOT ALLOWED
INSERT INTO vBookStatus VALUES ('1111111','Test Fname','Test Lname','1111111','UnAvailable');


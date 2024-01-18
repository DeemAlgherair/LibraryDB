-- create view 

CREATE VIEW vBookStatus AS
  SELECT Auther_ID,BA.Author_Fname, BA.Author_Lname,B.ISBN,B.AvailabilityStatus
  FROM Book_Auother BA
    JOIN Book B ON B.ISBN = BA.ISBN
  WHERE B.AvailabilityStatus = 'Available';

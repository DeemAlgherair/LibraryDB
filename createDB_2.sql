-- Catalog Service Schema
CREATE TABLE Room (
  RoomNumber VARCHAR(20) PRIMARY KEY,
  RoomStatus VARCHAR(20) CHECK (RoomStatus IN ('busy', 'not busy')),
  HoldDuration VARCHAR(20),
  Location VARCHAR(255),
  RoomType VARCHAR(255) CHECK (RoomType IN ('lab', 'reading room','working room')) 
  );

CREATE TABLE Collection (
  CollectionName VARCHAR(255),
  CollectionType VARCHAR(255),
  SerialNumber INT,
   PRIMARY KEY(SerialNumber,CollectionName)
);

 
CREATE TABLE Book (
  ISBN VARCHAR(20) PRIMARY KEY,
  Publisher VARCHAR(255),
  title VARCHAR(255),
  CollectionName VARCHAR(255),
  SerialNumber INT,
  AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'UnAvailable')),
 FOREIGN KEY (CollectionName, SerialNumber) REFERENCES Collection(CollectionName,SerialNumber)
);

 
create table Book_Auother (
Auther_ID char(10),
ISBN VARCHAR(255) , 
Author_Fname VARCHAR(255),
Author_Lname VARCHAR(255),
Primary key (Auther_ID,ISBN),
FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

CREATE TABLE VideoRecording (
  VideoID VARCHAR(20) PRIMARY KEY,
  title VARCHAR(255),
  Location VARCHAR(255),
  CollectionName VARCHAR(255),
    SerialNumber INT,
  Publisher VARCHAR(255),
  AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'UnAvailable')),
  FOREIGN KEY (CollectionName,SerialNumber) REFERENCES Collection(CollectionName,SerialNumber)
);


CREATE TABLE SoundRecording (
  SoundID VARCHAR(20) PRIMARY KEY,
  title VARCHAR(255),
  Location VARCHAR(255),
  Publisher VARCHAR(255),
  CollectionName VARCHAR(255),
  SerialNumber INT,
  AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'UnAvailable')),
  FOREIGN KEY (CollectionName,  SerialNumber) REFERENCES Collection(CollectionName,  SerialNumber)
);

CREATE TABLE Thesis (
  CallNumber VARCHAR(255) PRIMARY KEY,
  Location VARCHAR(255),
  title VARCHAR(255),
  CollectionName VARCHAR(255),
   SerialNumber INT,
  AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'UnAvailable')),
  FOREIGN KEY (CollectionName,  SerialNumber) REFERENCES Collection(CollectionName,  SerialNumber)
);

create table Thesis_Auother (
Auther_ID char(10),
CallNumber VARCHAR(255) ,
Author_Fname VARCHAR(255),
Author_Lname VARCHAR(255),
Primary key (Auther_ID,CallNumber),
FOREIGN KEY (CallNumber) REFERENCES Thesis(CallNumber)
);

CREATE TABLE Journal (
  CallNumber VARCHAR(255) PRIMARY KEY,
  Title VARCHAR(255),
  CollectionName VARCHAR(255),
  SerialNumber INT,
  AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'UnAvailable')),
  FOREIGN KEY (CollectionName,SerialNumber) REFERENCES Collection(CollectionName,SerialNumber)
);

-- Circulation Service Schema
CREATE TABLE Privilege (
  PrivilegeName VARCHAR(255)CHECK ( PrivilegeName IN ('PostGraduate','UnderGraduate','Staff','community patrons')),
  LoanPeriod INT,
  MaxBorrowLimit INT,
  MaxRenewalLimit INT,
  PRIMARY KEY (PrivilegeName)
);
  
CREATE TABLE Member (
  MemberID VARCHAR(20) PRIMARY KEY,
  MemberType VARCHAR(255) ,
  FName VARCHAR(255),
  LName VARCHAR(255),
  PIN VARCHAR(255),
  DateOfBirth DATE,
  Address VARCHAR(255),
  ContactNumbers VARCHAR(255),
  DateJoined DATE,
  ExpiryDate DATE,
  MemberStatus VARCHAR(255),
 FOREIGN KEY (MemberType) REFERENCES Privilege(PrivilegeName)
);

CREATE TABLE Booking (
  RoomNumber VARCHAR(20),
  MemberID VARCHAR(20),
  FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Loan_Book (
  LoanID VARCHAR(20) PRIMARY KEY,
  BookID VARCHAR(20),
  MemberID VARCHAR(20),
  LoanStatus VARCHAR(20),
  LoanedDate DATE,
  DueDate DATE,
  FOREIGN KEY (BookID) REFERENCES Book(ISBN),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Loan_Sound (
  LoanID VARCHAR(20) PRIMARY KEY,
  SoundID VARCHAR(20),
  MemberID VARCHAR(20),
  LoanStatus VARCHAR(20),
  LoanedDate DATE,
  DueDate DATE,
  FOREIGN KEY (SoundID) REFERENCES SoundRecording(SoundID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Loan_Video (
  LoanID VARCHAR(20) PRIMARY KEY,
  VideoID VARCHAR(20),
  MemberID VARCHAR(20),
  LoanStatus VARCHAR(20),
  LoanedDate DATE,
  DueDate DATE,
  FOREIGN KEY (VideoID) REFERENCES VideoRecording(VideoID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Loan_Theses (
  LoanID VARCHAR(20) PRIMARY KEY,
  ThesesID VARCHAR(20),
  MemberID VARCHAR(20),
  LoanStatus VARCHAR(20),
  LoanedDate DATE,
  DueDate DATE,
  FOREIGN KEY (ThesesID) REFERENCES Thesis(CallNumber),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Loan_Journal  (
  LoanID VARCHAR(20) PRIMARY KEY,
  JournalsID VARCHAR(20),
  MemberID VARCHAR(20),
  LoanStatus VARCHAR(20),
  LoanedDate DATE,
  DueDate DATE,
  FOREIGN KEY (JournalsID) REFERENCES Journal(CallNumber),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Fine (
  FineID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  Amount DECIMAL(10, 2),
  FineDescription VARCHAR(255),
  FineStatus VARCHAR(20),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

-- Short Loan Service Schema
CREATE TABLE ShortLoan_Book (
  ReservationID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  BookID VARCHAR(20) UNIQUE,
  ReservationDate TIMESTAMP,
  ExpiryReservation TIMESTAMP,
  ReservationStatus VARCHAR(20) CHECK ( ReservationStatus IN ('Active','UnActive')),
  FOREIGN KEY (BookID) REFERENCES Book(ISBN),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE ShortLoan_Sound (
  ReservationID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  SoundID VARCHAR(20) UNIQUE,
  ReservationDate TIMESTAMP,
  ExpiryReservation TIMESTAMP,
  ReservationStatus VARCHAR(20) CHECK ( ReservationStatus IN ('Active','UnActive')),
  FOREIGN KEY (SoundID) REFERENCES SoundRecording(SoundID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE ShortLoan_Video (
  ReservationID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  VideoID VARCHAR(20) UNIQUE,
  ReservationDate TIMESTAMP,
  ExpiryReservation TIMESTAMP,
  ReservationStatus VARCHAR(20) CHECK ( ReservationStatus IN ('Active','UnActive')),
  FOREIGN KEY (VideoID) REFERENCES VideoRecording(VideoID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE ShortLoan_Theses (
  ReservationID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  ThesesID VARCHAR(20) UNIQUE,
  ReservationDate TIMESTAMP,
  ExpiryReservation TIMESTAMP,
  ReservationStatus VARCHAR(20)CHECK ( ReservationStatus IN ('Active','UnActive')),
  FOREIGN KEY (ThesesID) REFERENCES Thesis(CallNumber),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE ShortLoan_Journal  (
  ReservationID VARCHAR(20) PRIMARY KEY,
  MemberID VARCHAR(20),
  JournalsID VARCHAR(20) UNIQUE,
  ReservationDate TIMESTAMP,
  ExpiryReservation TIMESTAMP,
  ReservationStatus VARCHAR(20) CHECK ( ReservationStatus IN ('Active','UnActive')),
  FOREIGN KEY (JournalsID) REFERENCES Journal(CallNumber),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

-- Create a trigger function
CREATE OR REPLACE TRIGGER check_journal_availability
BEFORE INSERT ON ShortLoan_Journal
FOR EACH ROW
DECLARE
    v_availability_status VARCHAR(20);
BEGIN
    -- Retrieve the availability status of the corresponding journal
    SELECT AvailabilityStatus INTO v_availability_status
    FROM Journal
    WHERE CallNumber = :NEW.JournalsID;

          IF v_availability_status = 'Unavailable' THEN
        -- Create a tuple with the same ReservationID, MemberID, and BookID
        INSERT INTO ShortLoan_Journal (ReservationID, MemberID, JournalsID, ReservationDate, ExpiryReservation, ReservationStatus)
        VALUES (:NEW.ReservationID, :NEW.MemberID, :NEW.JournalsID, :NEW.ReservationDate, :NEW.ExpiryReservation, :NEW.ReservationStatus);
    END IF;
    
END;



-- Create a trigger function
CREATE OR REPLACE TRIGGER check_book_availability
BEFORE INSERT ON ShortLoan_Book
FOR EACH ROW
DECLARE
    v_availability_status VARCHAR(20);
BEGIN
    -- Retrieve the availability status of the corresponding book
    SELECT AvailabilityStatus INTO v_availability_status
    FROM Book
    WHERE ISBN = :NEW.BookID;

    -- Check if the availability status is 'Unavailable'
    IF v_availability_status = 'Unavailable' THEN
        -- Create a tuple with the same ReservationID, MemberID, and BookID
        INSERT INTO ShortLoan_Book (ReservationID, MemberID, BookID, ReservationDate, ExpiryReservation, ReservationStatus)
        VALUES (:NEW.ReservationID, :NEW.MemberID, :NEW.BookID, :NEW.ReservationDate, :NEW.ExpiryReservation, :NEW.ReservationStatus);
    END IF;
END;


-- Create a trigger function
CREATE OR REPLACE TRIGGER check_Sound_availability
BEFORE INSERT ON ShortLoan_Sound
FOR EACH ROW
DECLARE
    v_availability_status VARCHAR(20);
BEGIN
    -- Retrieve the availability status of the corresponding book
    SELECT AvailabilityStatus INTO v_availability_status
    FROM SoundRecording A
    WHERE A.SoundID = :NEW.SoundID;

    -- Check if the availability status is 'Unavailable'
    IF v_availability_status = 'Unavailable' THEN
        -- Create a tuple with the same ReservationID, MemberID, and BookID
        INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus)
        VALUES (:NEW.ReservationID, :NEW.MemberID,  :NEW.SoundID, :NEW.ReservationDate, :NEW.ExpiryReservation, :NEW.ReservationStatus);
    END IF;
END;


CREATE OR REPLACE TRIGGER check_Video_availability
BEFORE INSERT ON ShortLoan_Video
FOR EACH ROW
DECLARE
    v_availability_status VARCHAR(20);
BEGIN
    -- Retrieve the availability status of the corresponding book
    SELECT AvailabilityStatus INTO v_availability_status
    FROM VideoRecording A
    WHERE A.VideoID = :NEW.VideoID;

    -- Check if the availability status is 'Unavailable'
    IF v_availability_status = 'Unavailable' THEN
        -- Create a tuple with the same ReservationID, MemberID, and BookID
        INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus)
        VALUES (:NEW.ReservationID, :NEW.MemberID, :NEW.VideoID, :NEW.ReservationDate, :NEW.ExpiryReservation, :NEW.ReservationStatus);
    END IF;
END;


CREATE OR REPLACE TRIGGER check_These_availability
BEFORE INSERT ON ShortLoan_Theses
FOR EACH ROW
DECLARE
    v_availability_status VARCHAR(20);
BEGIN
    -- Retrieve the availability status of the corresponding book
    SELECT AvailabilityStatus INTO v_availability_status
    FROM Thesis 
    WHERE CallNumber = :NEW.ThesesID;

    -- Check if the availability status is 'Unavailable'
    IF v_availability_status = 'Unavailable' THEN
        -- Create a tuple with the same ReservationID, MemberID, and BookID
        INSERT INTO ShortLoan_Theses (ReservationID, MemberID, ThesesID, ReservationDate, ExpiryReservation, ReservationStatus)
        VALUES (:NEW.ReservationID, :NEW.MemberID, :NEW.ThesesID, :NEW.ReservationDate, :NEW.ExpiryReservation, :NEW.ReservationStatus);
    END IF;
END;


-- Insert into Collection table
INSERT INTO Collection VALUES ('c1', 'Science', 1001);
INSERT INTO Collection VALUES ('c2', 'Literature', 1002);
INSERT INTO Collection VALUES ('c3', 'Mathematics', 1003);
INSERT INTO Collection VALUES ('c1', 'Science', 2001);
INSERT INTO Collection VALUES ('c2', 'Literature', 2002);
INSERT INTO Collection VALUES ('c3', 'Mathematics', 2003);
INSERT INTO Collection VALUES ('c1', 'Science', 3001);
INSERT INTO Collection VALUES ('c2', 'Literature', 3002);
INSERT INTO Collection VALUES ('c3', 'Mathematics', 3003);
INSERT INTO Collection VALUES ('c1', 'Science', 4001);
INSERT INTO Collection VALUES ('c2', 'Literature', 4002);
INSERT INTO Collection VALUES ('c3', 'Mathematics', 4003);
INSERT INTO Collection VALUES ('c1', 'Science', 5001);
INSERT INTO Collection VALUES ('c2', 'Literature', 5002);
INSERT INTO Collection VALUES ('c3', 'Mathematics', 5003);

-- Insert into Books table
INSERT INTO Book VALUES ('9780544112009', 'Little Brown and Company', 'The Lord of the Rings: The Fellowship of the Ring', 'c1', 1001, 'Available');
INSERT INTO Book VALUES ('9780446364781', 'Penguin Books', 'Pride and Prejudice', 'c2', 1002, 'Available');
INSERT INTO Book VALUES ('9781472206010', 'W.W. Norton & Company', 'To Kill a Mockingbird', 'c3', 1003, 'UnAvailable');
INSERT INTO Book VALUES ('9780439702532', 'HarperCollins Publishers', 'The Book Thief', 'c1', 2001, 'Available');
INSERT INTO Book VALUES ('9781501116727', 'Ecco', 'The Handmaids Tale', 'c2', 2002, 'Available');
INSERT INTO Book  VALUES ('9780143124287', 'Viking Penguin', 'The Kite Runner', 'c3', 2003, 'Available');
INSERT INTO Book VALUES ('9780374112173', 'Random House Trade Paperbacks', 'The Things They Carried', 'c1', 3001, 'Available');
INSERT INTO Book VALUES ('9780140187319', 'Viking Books', '1984', 'c2', 3002, 'Available');
INSERT INTO Book VALUES ('9780441009768', 'Random House Trade Paperbacks', 'The Catcher in the Rye', 'c3', 3003, 'UnAvailable');
INSERT INTO Book VALUES ('9780743282195', 'Penguin Classics', 'The Great Gatsby', 'c1', 4001, 'Available');
INSERT INTO Book VALUES ('9780446665065', 'HarperCollins Publishers', 'The Girl with the Dragon Tattoo', 'c2', 4002, 'Available');
INSERT INTO Book VALUES ('9781524795499', 'Dutton Adult', 'The Book Woman of Troublesome Creek', 'c3', 4003, 'UnAvailable');
INSERT INTO Book VALUES ('9780345413408', 'HarperCollins Publishers', 'And Then There Were None', 'c1', 5001, 'Available');


--Insert into Book_Auother table
INSERT INTO Book_Auother VALUES ('A-1', '9780544112009', 'J.R.R.', 'Tolkien');
INSERT INTO Book_Auother VALUES ('A-2', '9780446364781', 'Jane', 'Austen');
INSERT INTO Book_Auother VALUES ('A-3', '9781472206010', 'Harper', 'Lee');
INSERT INTO Book_Auother VALUES ('A-4', '9780439702532', 'Markus', 'Zusak');
INSERT INTO Book_Auother VALUES ('A-5', '9781501116727', 'Margaret', 'Atwood');
INSERT INTO Book_Auother VALUES ('A-6', '9780143124287', 'Khaled', 'Hosseini');
INSERT INTO Book_Auother VALUES ('A-7', '9780374112173', 'Tim', 'O Brien');
INSERT INTO Book_Auother VALUES ('A-8', '9780140187319', 'George', 'Orwell');
INSERT INTO Book_Auother VALUES ('A-9', '9780441009768', 'J.D.', 'Salinger');
INSERT INTO Book_Auother VALUES ('A-10', '9780743282195', 'F. Scott', 'Fitzgerald');
INSERT INTO Book_Auother VALUES ('A-11', '9780446665065', 'Stieg', 'Larsson');
INSERT INTO Book_Auother VALUES ('A-12', '9781524795499', 'Kim', 'Edwards');
INSERT INTO Book_Auother VALUES ('A-13', '9780345413408', 'Agatha', 'Christie');


--Insert into VideoRecording table
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-001', 'Hamlet', 'shelf1', 'c2', 2002, 'William Shakespeare', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-002', 'Pride and Prejudice', 'shelf2', 'c2', 2002, 'Jane Austen', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-003', 'To Kill a Mockingbird', 'shelf3', 'c2', 2002, 'Harper Lee', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-004', 'Calculus for Beginners', 'shelf1', 'c3', 2003, 'Tom Apostol', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-005', 'Linear Algebra Done Right', 'shelf2', 'c3', 2003, 'Sheldon Axler', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-006', 'Introduction to Probability and Statistics', 'shelf3', 'c3', 2003, 'DeGroot and Schervish', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-007', 'The Principles of Quantum Mechanics', 'shelf1', 'c1', 2001, 'P.A.M. Dirac', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-008', 'The Theory of Relativity', 'shelf2', 'c1', 2001, 'Albert Einstein', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-009', 'The Origin of Species', 'shelf3', 'c1', 2001, 'Charles Darwin', 'Available');
INSERT INTO VideoRecording (VideoID, title, Location, CollectionName, SerialNumber, Publisher, AvailabilityStatus) VALUES('VR-010', 'A Short History of Time', 'shelf1', 'c1', 2001, 'Stephen Hawking', 'Available');

--Insert into SoundRecording table
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES ('SR-001', 'Beethoven s Symphony No. 5', 'shelf1', 'Deutsche Grammophon', 'c1', 3001, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-002', 'The Beatles - Sgt. Peppers Lonely Hearts Club Band', 'shelf2', 'EMI Records', 'c2', 3002, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-003', 'Michael Jackson - Thriller', 'shelf3', 'Epic Records', 'c2', 3002, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-004', 'Mozarts Clarinet Concerto', 'shelf1', 'Decca Records', 'c1', 3001, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-005', 'Vivaldis The Four Seasons', 'shelf2', 'Naxos Records', 'c2', 3002, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-006', 'Rachmaninoffs Piano Concerto No. 2', 'shelf3', 'Melodiya', 'c3', 3003, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-007', 'Miles Davis - Kind of Blue', 'shelf1', 'Columbia Records', 'c1', 3001, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-008', 'John Coltrane - A Love Supreme', 'shelf2', 'Impulse! Records', 'c2', 3002, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-009', 'Chet Baker - Chet Baker Sings', 'shelf3', 'Riverside Records', 'c3', 3003, 'Available');
INSERT INTO SoundRecording (SoundID, title, Location, Publisher, CollectionName, SerialNumber, AvailabilityStatus) VALUES('SR-010', 'Ella Fitzgerald - Sings the Gershwin Songbook', 'shelf2', 'Verve Records', 'c3', 3003, 'Available');

-- Insert into Thesis table
INSERT INTO Thesis VALUES ('987654', 'Library B', 'Research Thesis', 'c1', 1001, 'Available');
INSERT INTO Thesis VALUES ('789012', 'Library C', 'Thesis Paper', 'c2', 1002, 'Available');
INSERT INTO Thesis VALUES ('345678', 'Library A', 'Advanced Research Thesis', 'c3', 1003, 'Available');
INSERT INTO Thesis VALUES ('456789', 'Library C', 'Scientific Thesis', 'c1', 2001, 'Available');
INSERT INTO Thesis VALUES ('234567', 'Library B', 'Master\s Thesis', 'c2', 2002, 'UnAvailable');
INSERT INTO Thesis VALUES ('567890', 'Library A', 'Ph.D. Dissertation', 'c3', 2003, 'Available');
INSERT INTO Thesis VALUES ('890123', 'Library B', 'Thesis on Data Analysis', 'c1', 3001, 'Available');
INSERT INTO Thesis VALUES ('012345', 'Library C', 'Social Sciences Thesis', 'c2', 3002, 'Available');
INSERT INTO Thesis VALUES ('456123', 'Library A', 'Literature Review Thesis', 'c3', 3003, 'Available');
INSERT INTO Thesis VALUES ('789456', 'Library B', 'Thesis on Artificial Intelligence', 'c1', 4001, 'Available');
    
-- Insert into Thesis_Auother tabel 
INSERT INTO Thesis_Auother VALUES ('A12345', '987654', 'John', 'Smith');
INSERT INTO Thesis_Auother VALUES ('B56789', '789012', 'Jane', 'Doe');
INSERT INTO Thesis_Auother VALUES ('C90123', '345678', 'Peter', 'Jones');
INSERT INTO Thesis_Auother VALUES ('D34567', '234567', 'Mary', 'Brown');
INSERT INTO Thesis_Auother VALUES ('E78901', '456789', 'David', 'Williams');
INSERT INTO Thesis_Auother VALUES ('F12345', '567890', 'Elizabeth', 'Miller');
INSERT INTO Thesis_Auother VALUES ('G56789', '234567', 'Mark', 'Taylor');
INSERT INTO Thesis_Auother VALUES ('H90123', '456789', 'Susan', 'Anderson');
INSERT INTO Thesis_Auother VALUES ('I34567', '567890' , 'Paul', 'Thompson');
INSERT INTO Thesis_Auother VALUES ('J78901', '890123', 'Barbara', 'Edwards');
INSERT INTO Thesis_Auother VALUES ('K12345', '012345', 'Christopher', 'Garcia');
INSERT INTO Thesis_Auother VALUES ('L56789', '456123', 'Jennifer', 'Martinez');
INSERT INTO Thesis_Auother VALUES ('M90123', '789456', 'Michael', 'Gonzalez');
INSERT INTO Thesis_Auother VALUES ('N34567', '012345', 'Sandra', 'Lopez');
INSERT INTO Thesis_Auother VALUES ('O78901', '456123', 'Kenneth', 'Lee');




-- Insert into Journal table
INSERT INTO Journal VALUES ('JN001', 'Journal 1', 'c1', 1001, 'Available');
INSERT INTO Journal VALUES ('JN002', 'Journal 2', 'c2', 1002, 'Available');
INSERT INTO Journal VALUES ('JN003', 'Journal 3', 'c3', 1003, 'Available');
INSERT INTO Journal VALUES ('JN004', 'Journal 4', 'c1', 2001, 'UnAvailable');
INSERT INTO Journal VALUES ('JN005', 'Journal 5', 'c2', 2002, 'Available');
INSERT INTO Journal VALUES ('JN006', 'Journal 6', 'c3', 2003, 'UnAvailable');
INSERT INTO Journal VALUES ('JN007', 'Journal 7', 'c1', 3001, 'Available');
INSERT INTO Journal VALUES ('JN008', 'Journal 8', 'c2', 3002, 'Available');
INSERT INTO Journal VALUES ('JN009', 'Journal 9', 'c3', 3003, 'UnAvailable');
INSERT INTO Journal VALUES ('JN010', 'Journal 10', 'c1', 4001, 'Available');


-- Insert into Privilege table
INSERT INTO Privilege(PrivilegeName,LoanPeriod,MaxBorrowLimit,MaxRenewalLimit) VALUES ('PostGraduate', 30, 5, 2);
INSERT INTO Privilege(PrivilegeName,LoanPeriod,MaxBorrowLimit,MaxRenewalLimit) VALUES ('UnderGraduate', 21, 3, 1);
INSERT INTO Privilege(PrivilegeName,LoanPeriod,MaxBorrowLimit,MaxRenewalLimit) VALUES ('Staff', 14, 7, 3);
INSERT INTO Privilege (PrivilegeName,LoanPeriod,MaxBorrowLimit,MaxRenewalLimit) VALUES ('community patrons', 7, 2, 0);

-- Insert into Member table
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M001', 'PostGraduate', 'Norah', 'Abdullah', '1234567890', TO_DATE('1995-01-01','YYYY-MM-DD'), 'ALRas', '+966 555 555 555',TO_DATE('2023-10-01','YYYY-MM-DD'),TO_DATE('2026-09-30','YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M002', 'UnderGraduate', 'Alia', 'Mohammed', '9876543210', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'ALRas', '+966 500 500 500', TO_DATE('2024-10-02', 'YYYY-MM-DD'), TO_DATE('2065-02-13', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M003', 'Staff', 'Khaola', 'Ahmed',  '4567890123', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Unizah', '+966 544 444 444', TO_DATE('2024-10-03', 'YYYY-MM-DD'), TO_DATE('2026-03-07', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M004', 'community patrons', 'Fatima', 'Ibrahim',  '1234567890', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Unizah', '+966 512 123 456', TO_DATE('2023-10-04', 'YYYY-MM-DD'), TO_DATE('2024-04-21', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M005', 'PostGraduate', 'Sarah', 'Omar', '1234567890',TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Burydah', '+966 566 777 888', TO_DATE('2023-10-05', 'YYYY-MM-DD'), TO_DATE('2026-05-04', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M006', 'UnderGraduate', 'Sarah', 'Hassan', '4567890123', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Unizah', '+966 531 987 654', TO_DATE('2024-10-06', 'YYYY-MM-DD'), TO_DATE('2026-06-19', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M007', 'Staff', 'Amal', 'Ali', '4567890123',TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Burydah', '+966 599 123 456', TO_DATE('2023-10-07', 'YYYY-MM-DD'), TO_DATE('2027-07-14', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M008', 'PostGraduate', 'Mona', 'Abdullah', '1234567890',TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'Burydah', '+966 577 456 123', TO_DATE('2023-10-16', 'YYYY-MM-DD'), TO_DATE('2027-09-20', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M009', 'UnderGraduate', 'Abdullah', 'Ibrahim', '1234567890', TO_DATE('2001-10-12', 'YYYY-MM-DD'), 'Unizah', '+966 598 765 432', TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2027-10-11', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M010', 'Staff', 'Ibrahim', 'Ahmed', '9876543210', TO_DATE('1984-11-23', 'YYYY-MM-DD'), 'Unizah', '+966 522 345 678', TO_DATE('2024-10-18', 'YYYY-MM-DD'), TO_DATE('2028-11-22', 'YYYY-MM-DD'), 'Active');
INSERT INTO Member(MemberID,MemberType,FName,LName,PIN,DateOfBirth,Address,ContactNumbers,DateJoined,ExpiryDate,MemberStatus) VALUES ('M011', 'community patrons', 'Noura', 'Ali', '4567890123',  TO_DATE('1976-12-04', 'YYYY-MM-DD'), 'Unizah', '+966 588 567 890', TO_DATE('2022-10-19', 'YYYY-MM-DD'), TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'Active');

--  INSERT statements for the Room table
INSERT INTO Room VALUES ('101', 'busy', '2 hours', 'Floor 1', 'lab');
INSERT INTO Room VALUES ('201', 'not busy', NULL, 'Floor 2', 'reading room');
INSERT INTO Room VALUES ('301', 'busy', '1.5 hours', 'Floor 3', 'working room');
INSERT INTO Room VALUES ('102', 'not busy', NULL, 'Floor 1', 'lab');
INSERT INTO Room VALUES ('202', 'busy', '3 hours', 'Floor 2', 'reading room');
INSERT INTO Room VALUES ('302', 'not busy', NULL, 'Floor 3', 'working room');
INSERT INTO Room VALUES ('103', 'busy', '2.5 hours', 'Floor 1', 'lab');
INSERT INTO Room VALUES ('203', 'not busy', NULL, 'Floor 2', 'reading room');
INSERT INTO Room VALUES ('303', 'busy', '1 hour', ' Floor 3', 'working room');
INSERT INTO Room VALUES ('104', 'not busy', NULL, 'Floor 1', 'lab');
INSERT INTO Room VALUES ('204', 'busy', NULL, ' Floor 2', 'reading room');
INSERT INTO Room VALUES ('304', 'not busy', '2 hours', ' Floor 3', 'working room');
INSERT INTO Room VALUES ('105', 'busy', NULL, 'Floor 1', 'lab');
INSERT INTO Room VALUES ('205', 'not busy', '1.5 hours', 'Floor 2', 'reading room');

-- Inserting values into the Booking table
INSERT INTO Booking VALUES ('101', 'M001');
INSERT INTO Booking VALUES ('201', 'M002');
INSERT INTO Booking VALUES ('301', 'M003');
INSERT INTO Booking VALUES ('102', 'M004');
INSERT INTO Booking VALUES ('202', 'M005');
INSERT INTO Booking VALUES ('302', 'M006');
INSERT INTO Booking VALUES ('103', 'M007');
INSERT INTO Booking VALUES ('203', 'M008');
INSERT INTO Booking VALUES ('303', 'M009');
INSERT INTO Booking VALUES ('104', 'M010');
INSERT INTO Booking VALUES ('202', 'M011');

-- Insert values into Loan_Book table
INSERT INTO Loan_Book VALUES ('L001', '9780544112009', 'M001', 'Active', TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_DATE('2024-12-10', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L002', '9780446364781', 'M002', 'Active', TO_DATE('2024-11-11', 'YYYY-MM-DD'), TO_DATE('2024-12-11', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L003', '9781472206010', 'M003', 'Active', TO_DATE('2024-11-12', 'YYYY-MM-DD'), TO_DATE('2024-12-12', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L004', '9780439702532', 'M004', 'Active', TO_DATE('2024-11-13', 'YYYY-MM-DD'), TO_DATE('2024-12-13', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L005', '9781501116727', 'M005', 'Active', TO_DATE('2024-11-14', 'YYYY-MM-DD'), TO_DATE('2024-12-14', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L006', '9780143124287', 'M006', 'Active', TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L007', '9780374112173', 'M007', 'Active', TO_DATE('2024-11-16', 'YYYY-MM-DD'), TO_DATE('2024-12-16', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L008', '9780140187319', 'M008', 'Active', TO_DATE('2024-11-17', 'YYYY-MM-DD'), TO_DATE('2024-12-17', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L009', '9780441009768', 'M009', 'Active', TO_DATE('2024-11-18', 'YYYY-MM-DD'), TO_DATE('2024-12-18', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L010', '9780743282195', 'M010', 'Active', TO_DATE('2024-11-19', 'YYYY-MM-DD'), TO_DATE('2024-12-19', 'YYYY-MM-DD'));
INSERT INTO Loan_Book VALUES ('L011', '9780446665065', 'M011', 'Active', TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'));
-- Inserting values into the Loan_Video table
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LS-001', 'SR-001', 'M001', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-002', 'SR-002', 'M002', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-003', 'SR-003', 'M003', 'Active', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-004', 'SR-004', 'M004', 'Active', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-005', 'SR-005', 'M005', 'Active', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-006', 'SR-006', 'M006', 'Active', TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-007', 'SR-007', 'M007', 'Active', TO_DATE('2023-11-24', 'YYYY-MM-DD'), TO_DATE('2023-12-08', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-008', 'SR-008', 'M008', 'Active', TO_DATE('2023-11-23', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-009', 'SR-009', 'M009', 'Active', TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Sound (LoanID, SoundID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES('LS-010', 'SR-010', 'M010', 'Active', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-09', 'YYYY-MM-DD'));

-- Inserting values into the Loan_Video table
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-001', 'VR-001', 'M001', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-002', 'VR-002', 'M002', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-003', 'VR-003', 'M003', 'Active', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-004', 'VR-004', 'M004', 'Active', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-005', 'VR-005', 'M005', 'Active', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-006', 'VR-006', 'M006', 'Active', TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-007', 'VR-007', 'M007', 'Active', TO_DATE('2023-11-24', 'YYYY-MM-DD'), TO_DATE('2023-12-08', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-008', 'VR-008', 'M008', 'Active', TO_DATE('2023-11-23', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-009', 'VR-009', 'M009', 'Active', TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Video (LoanID, VideoID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LN-010', 'VR-010', 'M010', 'Active', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-09', 'YYYY-MM-DD'));

-- Inserting values into the Loan_Theses table
INSERT INTO Loan_Theses VALUES ('Loan001', '987654', 'M001', 'Pending', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan002', '789012', 'M002', 'Loaned', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan003', '345678', 'M003', 'Returned', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan004', '456789', 'M004', 'Loaned', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan005', '234567', 'M005', 'Pending', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan006', '567890', 'M006', 'Returned', TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan007', '890123', 'M007', 'Loaned', TO_DATE('2023-11-23', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan008', '012345', 'M008', 'Returned', TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan009', '456123', 'M009', 'Loaned', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-09', 'YYYY-MM-DD'));
INSERT INTO Loan_Theses VALUES ('Loan010', '789456', 'M010', 'Pending', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-09', 'YYYY-MM-DD'));

-- Inserting values into the Loan_Journal table
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ001', 'JN001', 'M001', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ002', 'JN002', 'M002', 'Active', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ003', 'JN003', 'M003', 'Active', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ004', 'JN004', 'M004', 'Active', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ005', 'JN005', 'M005', 'Active', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ006', 'JN006', 'M006', 'Active', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-09', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ007', 'JN007', 'M007', 'Active', TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ008', 'JN008', 'M008', 'Active', TO_DATE('2023-11-23', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ009', 'JN009', 'M009', 'Active', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'));
INSERT INTO Loan_Journal (LoanID, JournalsID, MemberID, LoanStatus, LoanedDate, DueDate) VALUES ('LJ010', 'JN010', 'M010', 'Active', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'));

-- Inserting values into the Fine table
INSERT INTO Fine VALUES ('F001', 'M001', 30.54, 'Overdue book return', 'Unpaid');
INSERT INTO Fine VALUES ('F002', 'M002', 40.61, 'Damaged book', 'Paid');
INSERT INTO Fine VALUES ('F003', 'M003', 42.95, 'Library rules violation', 'Paid');
INSERT INTO Fine VALUES ('F004', 'M004', 36.66, 'Overdue book return', 'Unpaid');
INSERT INTO Fine VALUES ('F005', 'M005', 20.43, 'Library rules violation', 'Paid');
INSERT INTO Fine VALUES ('F006', 'M004', 47.17, 'Library rules violation', 'Waived');
INSERT INTO Fine VALUES ('F007', 'M002', 43.52, 'Overdue book return', 'Unpaid');
INSERT INTO Fine VALUES ('F008', 'M009', 29.63, 'Overdue book return', 'Waived');
INSERT INTO Fine VALUES ('F009', 'M004', 26.16, 'Other', 'Waived');
INSERT INTO Fine VALUES ('F0011', 'M011', 27.54, 'Damaged book', 'Paid');


-- Short Loan Service Schema

-- Inserting values into the ShortLoan_Book table
INSERT INTO ShortLoan_Book VALUES ('SLB001', 'M001', '9780544112009', TO_TIMESTAMP('2024-11-10 11:12:34', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB002', 'M002', '9780446364781', TO_TIMESTAMP('2024-11-11 13:45:26', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-16 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB003', 'M003', '9781472206010', TO_TIMESTAMP('2024-11-12 09:28:11', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB004', 'M004', '9780439702532', TO_TIMESTAMP('2024-11-13 15:46:23', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-18 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB005', 'M005', '9781501116727', TO_TIMESTAMP('2024-11-14 10:32:14', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-19 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB006', 'M006', '9780143124287', TO_TIMESTAMP('2024-11-15 02:59:08', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2024-11-20 03:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB007', 'M007', '9780374112173', TO_TIMESTAMP('2024-11-16 12:13:57', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2024-11-21 11:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Book VALUES ('SLB009', 'M011', '9780446665065', TO_TIMESTAMP('2024-11-20 02:46:18', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2024-11-25 03:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
-- Inserting values into the ShortLoan_Sound table

INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-001', 'M001', 'SR-001', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-002', 'M002', 'SR-002', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-02', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-003', 'M003', 'SR-003', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-004', 'M004', 'SR-004', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-005', 'M005', 'SR-005', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-006', 'M006', 'SR-006', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-02', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-007', 'M007', 'SR-007', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-008', 'M008', 'SR-008', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-009', 'M009', 'SR-009', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Sound (ReservationID, MemberID, SoundID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SLS-010', 'M010', 'SR-010', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'Active');

-- Inserting values into the ShortLoan_Video table
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-001', 'M001', 'VR-001', TO_DATE('2023-11-29','YYYY-MM-DD'), TO_DATE('2023-12-03','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-002', 'M002', 'VR-002', TO_DATE('2023-11-29','YYYY-MM-DD'),TO_DATE('2023-12-02','YYYY-MM-DD') , 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-003', 'M003', 'VR-003',TO_DATE('2023-11-29','YYYY-MM-DD') , TO_DATE('2023-12-01','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-004', 'M004', 'VR-004', TO_DATE('2023-11-28','YYYY-MM-DD'),TO_DATE( '2023-12-04','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-005', 'M005', 'VR-005', TO_DATE('2023-11-28','YYYY-MM-DD'), TO_DATE('2023-12-03','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-006', 'M006', 'VR-006', TO_DATE('2023-11-28','YYYY-MM-DD'),TO_DATE('2023-12-02','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-007', 'M007', 'VR-007', TO_DATE('2023-11-27','YYYY-MM-DD'), TO_DATE('2023-12-05','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-008', 'M008', 'VR-008',TO_DATE('2023-11-27','YYYY-MM-DD'), TO_DATE('2023-12-04','YYYY-MM-DD'), 'Active');
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-009', 'M009', 'VR-009',TO_DATE('2023-11-27','YYYY-MM-DD'), TO_DATE('2023-12-03','YYYY-MM-DD'), 'Active'); 
INSERT INTO ShortLoan_Video (ReservationID, MemberID, VideoID, ReservationDate, ExpiryReservation, ReservationStatus) VALUES ('SL-010', 'M010', 'VR-010',TO_DATE('2023-11-27','YYYY-MM-DD'), TO_DATE('2023-12-06','YYYY-MM-DD'), 'Active');
-- Inserting values into the ShortLoan_Theses table
INSERT INTO ShortLoan_Theses VALUES ('RSVN0001', 'M001', '987654', TO_TIMESTAMP('2023-10-16 10:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-23 10:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0002', 'M002', '789012', TO_TIMESTAMP('2023-10-17 11:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-24 11:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0003', 'M003', '345678', TO_TIMESTAMP('2023-10-18 12:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-25 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0004', 'M004', '456789', TO_TIMESTAMP('2023-10-19 01:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-26 01:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0005', 'M005', '234567', TO_TIMESTAMP('2023-10-20 02:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-27 02:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0006', 'M006', '567890', TO_TIMESTAMP('2023-10-21 03:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-28 03:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0007', 'M007', '890123', TO_TIMESTAMP('2023-10-22 04:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-29 04:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0008', 'M008', '012345', TO_TIMESTAMP('2023-10-23 05:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-30 05:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0009', 'M009', '456123', TO_TIMESTAMP('2023-10-24 06:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-31 06:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0010', 'M010', '789456', TO_TIMESTAMP('2023-10-25 07:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-11-01 07:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0011', 'M011', '987654', TO_TIMESTAMP('2023-10-26 08:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-11-02 08:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Theses VALUES ('RSVN0012', 'M001', '789012', TO_TIMESTAMP('2023-10-27 09:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-11-03 09:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');

-- Inserting values into the ShortLoan_Journal table
INSERT INTO ShortLoan_Journal VALUES ('RSVN0023', 'M001', 'JN001', TO_TIMESTAMP('2023-10-16 10:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-23 10:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0013', 'M002', 'JN002', TO_TIMESTAMP('2023-10-17 11:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-24 11:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0014', 'M003', 'JN003', TO_TIMESTAMP('2023-10-18 12:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-25 12:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0015', 'M004', 'JN004', TO_TIMESTAMP('2023-10-19 01:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-26 01:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0016', 'M005', 'JN005', TO_TIMESTAMP('2023-10-20 02:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-27 02:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0017', 'M006', 'JN006', TO_TIMESTAMP('2023-10-21 03:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-28 03:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0018', 'M007', 'JN007', TO_TIMESTAMP('2023-10-22 04:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-29 04:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0019', 'M008', 'JN008', TO_TIMESTAMP('2023-10-23 05:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-30 05:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0020', 'M009', 'JN009', TO_TIMESTAMP('2023-10-24 06:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-10-31 06:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0021', 'M010', 'JN010', TO_TIMESTAMP('2023-10-25 07:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-11-01 07:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
INSERT INTO ShortLoan_Journal VALUES ('RSVN0022', 'M011', 'JN011', TO_TIMESTAMP('2023-10-26 08:00:00', 'YYYY-MM-DD HH:MI:SS'), TO_TIMESTAMP('2023-11-02 08:00:00', 'YYYY-MM-DD HH:MI:SS'), 'Active');
 SELECT * FROM Collection;
 SELECT * FROM Book;
  SELECT * FROM ShortLoan_Book;
 SELECT * FROM SoundRecording;
 SELECT * FROM VideoRecording;
 SELECT * FROM Thesis;
 SELECT * FROM Thesis_Auother;
SELECT * FROM Journal;
 SELECT * FROM Booking;
 SELECT * FROM Member;
 SELECT * FROM Fine;
 SELECT * FROM Book_Auother;
  SELECT * FROM Loan_Book;
 SELECT * FROM Loan_Sound;
 SELECT * FROM Loan_Video;
 SELECT * FROM Loan_Theses;
SELECT * FROM Loan_Journal;
 SELECT * FROM ShortLoan_Book;
 SELECT * FROM ShortLoan_Sound;
 SELECT * FROM ShortLoan_Video;
 SELECT * FROM ShortLoan_Theses;
SELECT * FROM ShortLoan_Journal;

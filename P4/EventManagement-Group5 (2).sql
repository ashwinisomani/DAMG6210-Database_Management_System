
DROP DATABASE EventManagement_Group5                        /* drop database */

CREATE DATABASE EventManagement_Group5						/* create database */

USE EventManagement_Group5 

/*users password column encryption*/
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'Group5_P@sswOrd'


-- Create certificate to protect symmetric key
CREATE CERTIFICATE Group5_Certificate
WITH   SUBJECT = 'Project Group5 Certificate',
EXPIRY_DATE =     '2026-9-28'


-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY Group5_SymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE Group5_Certificate


-- Open symmetric key
OPEN SYMMETRIC KEY Group5_SymmetricKey
DECRYPTION BY CERTIFICATE Group5_Certificate

----------------------------------------------------------------------------------------------------------------------

/* Create Table */


DROP TABLE Manager
CREATE TABLE Manager
(
    Manager_Id  INT         PRIMARY KEY,
    FirstName   VARCHAR(50) NOT NULL,
    LastName    VARCHAR(50) NOT NULL
)


DROP TABLE Employee
CREATE TABLE Employee
(                
Emp_Id     INT   NOT NULL PRIMARY KEY,                
Manager_Id INT   FOREIGN KEY REFERENCES Manager(Manager_Id),         
First_Name VARCHAR(30) NOT NULL,                
Last_Name  VARCHAR(30) NOT NULL,    
Salary     MONEY       NOT NULL, 
Phone      VARCHAR(30) NOT NULL,
Email      VARCHAR(30) NOT NULL        
)
 
 
DROP TABLE Customer
CREATE TABLE Customer
(
    Customer_Id     INT   NOT NULL PRIMARY KEY,
    SalesPerson_Id  INT   NOT NULL FOREIGN KEY REFERENCES Employee(Emp_id),
    FirstName       Varchar(50) NOT NULL,
    LastName        VARCHAR(50) NOT NULL,
    Email           VARCHAR(50) NOT NULL,
    Phone           VARCHAR(50) NOT NULL,
    Street_No       INT         NOT NULL,
    City            VARCHAR(30) NOT NULL,
    State           VARCHAR(30) NOT NULL,
    Zip_Code        INT NOT NULL,
 ) 
 
 ALTER TABLE  Customer  ADD Birthday DATE
 
 ALTER TABLE  Customer  ADD Gender  VARCHAR(45) NOT NULL CHECK (Gender IN ('Male', 'Female'))

 ALTER TABLE  Customer  ADD Password VARBINARY(250)
 
 ALTER TABLE  Customer  ADD Username VARCHAR(30)
 

DROP TABLE Event 
CREATE TABLE Event
 (
Event_id   INT NOT NULL PRIMARY KEY,
Event_Type VARCHAR(20) NOT NULL
 ) 
 
DROP TABLE Customer_Feedback 
CREATE TABLE Customer_Feedback        
(
Event_id       INT NOT NULL REFERENCES Event(Event_Id),    
Customer_id    INT NOT NULL REFERENCES Customer(Customer_Id),
Feedback  VARCHAR (30)
)


DROP TABLE Package 
CREATE TABLE Package
(
    Package_Id   INT         NOT NULL PRIMARY KEY,
    Description  VARCHAR(50) NOT NULL,
    Amount       MONEY       NOT NULL
)


DROP TABLE Booking 
CREATE TABLE Booking
(                
Booking_Id  INT  NOT NULL PRIMARY KEY,                
Customer_Id INT  NOT NULL FOREIGN KEY REFERENCES Customer(Customer_Id),                
Event_Id    INT  NOT NULL FOREIGN KEY REFERENCES Event(Event_Id),                
Package_Id  INT  NOT NULL FOREIGN KEY REFERENCES Package(Package_Id),    
Book_Date   DATE NOT NULL
) 


DROP TABLE Invoice
CREATE TABLE Invoice
(
Invoice_Id   INT NOT NULL PRIMARY KEY,
Booking_Id   INT NOT NULL FOREIGN KEY REFERENCES  Booking(Booking_Id ),
Customer_Id  INT NOT NULL FOREIGN KEY REFERENCES Customer(Customer_Id),
Invoice_Date DATE,
Amount       MONEY
)

 

DROP TABLE Payment
CREATE TABLE Payment
(
Payment_Id INT NOT NULL PRIMARY KEY,
Invoice_Id INT NOT NULL FOREIGN KEY REFERENCES Invoice(Invoice_Id),
Event_Id   INT NOT NULL FOREIGN KEY REFERENCES Event(Event_Id),
Pay_date   DATE NOT NULL,
Mode_of_Payment VARCHAR(80) NOT NULL
)
 

DROP TABLE Vendor
CREATE TABLE Vendor
(
Vendor_id   INT NOT NULL PRIMARY KEY,
Vendor_type VARCHAR(30) NOT NULL,
FirstName   VARCHAR(30) NOT NULL,
LastName    VARCHAR(30) NOT NULL,
Phone       VARCHAR(30) NOT NULL,
Email       VARCHAR(30) NOT NULL
)

DROP TABLE Equipment
CREATE TABLE Equipment
(
Equipment_id INT NOT NULL PRIMARY KEY,
Vendor_id    INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
Name         VARCHAR(45) NOT NULL
)


DROP TABLE Performer
CREATE TABLE Performer
(
Performer_id INT NOT NULL PRIMARY KEY,
Vendor_id    INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
Category    VARCHAR(45) NOT NULL,
FirstName   VARCHAR(30) NOT NULL,
LastName    VARCHAR(30) NOT NULL,
Email       VARCHAR(30) NOT NULL
)

DROP TABLE Photographer
CREATE TABLE Photographer
(
Photographer_id INT NOT NULL PRIMARY KEY,
Vendor_id       INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id) ,
FirstName       VARCHAR(30) NOT NULL,
LastName        VARCHAR(30) NOT NULL,
Email           VARCHAR(30) NOT NULL
)


DROP TABLE Makeup_Artist
CREATE TABLE Makeup_Artist
(
Artist_id INT NOT NULL PRIMARY KEY,
Vendor_id INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
FirstName VARCHAR(30) NOT NULL,
LastName  VARCHAR(30) NOT NULL,
Phone     VARCHAR(30) NOT NULL,
Email     VARCHAR(30) NOT NULL
)


DROP TABLE Transportation
CREATE TABLE Transportation
(
Tranportation_id INT NOT NULL PRIMARY KEY,
Vendor_id INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
Cost_per_km MONEY NOT NULL,
No_of_seats INT NOT NULL,
Vehicle_type VARCHAR(30) NOT NULL,
License_type VARCHAR(30) NOT NULL
)


DROP TABLE Caterer
CREATE TABLE Caterer
(
Cat_id INT NOT NULL PRIMARY KEY,
Vendor_id INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
Charges INT NOT NULL
)


DROP TABLE Venue
CREATE TABLE Venue
(
Venue_id  INT NOT NULL PRIMARY KEY,
Vendor_id INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_id),
Name      VARCHAR(30) NOT NULL,
Capacity  INT NOT NULL,
Street_No VARCHAR(30) NOT NULL,
City      VARCHAR(30) NOT NULL,
State     VARCHAR(30) NOT NULL,
Zipcode   INT NOT NULL,
Rent      INT NOT NULL,
Phone     VARCHAR(45) NOT NULL CONSTRAINT check_phone CHECK (Phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') /* check constraint */
)

DROP TABLE Decoration
CREATE TABLE Decoration
(
Decor_Id  INT NOT NULL PRIMARY KEY,
Vendor_Id INT NOT NULL FOREIGN KEY REFERENCES Vendor(Vendor_Id),
Charge    MONEY NOT NULL
)

	
/* Insert Sample data */

INSERT INTO	
Manager(Manager_Id, FirstName , LastName )	 
VALUES	
(101, 'Nidhi'  ,  'Walia'  ),	
(105, 'Manisha',  'Nakawe' ),	
(117, 'John'   ,  'Ibrahim'),	
(108, 'Priya'  ,  'Sharma' ),	
(103, 'Ankit'  ,  'Singh'  ),	
(107, 'Priyanka', 'Saraf'  ),	
(110, 'Ronak'  ,  'Somani' ),	
(113, 'Heni'   ,  'Singh'  ),
(120, 'Jeff'   ,  'Bezos'  ),
(119, 'Vicky'  ,  'Kaushal')

SELECT * FROM Manager m 

INSERT INTO        
Employee (Emp_id, Manager_id , First_Name, Last_Name, Salary, Phone, Email )        
VALUES        
(101,  null  ,'Nidhi'  , 'Walia'    , 25000  ,   4256519440, 'abc@example.com'),        
(102,  105  , 'Anuya'  , 'Somani'  , 50000  ,   4256519441, 'def@example.com'),    
(103,  117  , 'Ankit'  , 'Singh'   , 250000 ,   4256519442, 'ghi@example.com'),        
(104,  105  , 'Chintan', 'Aggarwal', 250000 ,   4256519443, 'jkl@example.com'),
(105,  101  , 'Manisha', 'Nakawe'  , 150000 ,   4256519444, 'mno@example.com'),
(106,  108  , 'Swati'  , 'Duhan'   , 50000  ,   4256519445, 'pqr@example.com'),
(107,  108  , 'Priyanka', 'Saraf'  , 2000   ,   4256519446, 'stu@example.com'),
(108,  103  , 'Priya'  , 'Sharma'  , 2000   ,   4256519447, 'vwx@example.com'),
(109,  103  , 'Ashwini', 'Goyal'   , 50000  ,   4256519448, 'yz@example.com' ),
(110,  107  , 'Ronak'  , 'Somani'  , 250000 ,   4256519449, '123@example.com'),
(111,  107  , 'Kushal' , 'Dahiya'  , 250000 ,   4256519450, '456@example.com'),
(112,  110  , 'Ayush'  , 'Shriwastav',2500  ,   4256519451, '251@example.com'),
(113,  110  , 'Heni'   , 'Singh'   , 2000   ,   4256519452, '531@example.com'),
(114,  113  , 'Jaya'   , 'Kalele'  , 10000  ,   4256519453, '999@example.com'),
(115,  113  , 'Utkarsh', 'Sharma'  , 20000  ,   4256519454, '555@example.com'),
(116,  120  , 'Jeremy' , 'Sanders' , 20000  ,   4256519455, '222@example.com'),
(117,  120  , 'John'   , 'Ibrahim' , 50000  ,   4256519456, '111@example.com'),
(118,  120  , 'Ranbir' , 'Kapoor'  , 60000  ,   4256519457, '444@example.com'),
(119,  120  , 'Vicky'  , 'Kaushal' , 750000 ,   4256519458, '333@example.com'),
(120,  101  , 'Jeff'   , 'Bezos'   , 50000  ,   4256519459, '777@example.com'),
(121,  101  , 'Sunder' , 'Pichai'  , 80000  ,   4256519460, '888@example.com')

SELECT * FROM Employee e 



/* inserted one at a time */
INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES	
(2321, 109, 'Beth'    , 'Bigidea'  ,   'beth@example.com'    , 206-290-8846 , 41 , 'Seattle'  , 'WA' , 98105, '1988-03-24', 'Female' , 'Beth_Bigidea'    , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'SJ123456789' )))


INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2322, 110, 'Crystal' , 'Codebase' ,   'crystal@example.com' , 206-290-8836 , 67 , 'Bothell'  , 'WA' , 98124, '1968-07-16', 'Female' , 'Crystal_Codebase', EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'TK123456789' )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2323, 111, 'Harry'   , 'Helpsalot',   'harry@example.com'   , 206-290-8837 , 23 , 'Tacoma'   , 'WA' , 98131, '1975-12-05', 'Male'   , 'Harry_Helpsalot' , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'JM123456789' )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2324, 112, 'Peter'   , 'Perfcycle',   'peter@example.com'   , 206-290-8838 , 45 , 'Seattle'  , 'WA' , 98126, '1994-03-14', 'Male'   , 'Peter_Perfcycle' , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'LJ987654321' )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2325, 113, 'Halley'  , 'Heroine'  ,   'halley@example.com'  , 206-290-8839 , 66 , 'Bellevue' , 'WA' , 98106, '2008-01-15', 'Female' , 'Halley_Heroine'  , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'JS987654321' )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2326, 114, 'Roger'   , 'Reports'  ,   'roger@example.com'   , 206-290-8840 , 21 , 'Seattle'  , 'WA' , 98117, '1984-09-04', 'Male'   , 'Roger_Reports'   , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'BW987654321' )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2327, 115, 'Sara'    , 'Salesleader', 'sara@example.com'    , 206-290-8841 , 76 , 'Millcreek', 'WA' , 98059, '1983-09-05', 'Female' , 'Sara_Salesleader', EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'EW33234432'  )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2328, 116, 'Tamara'  , 'Trust'    ,   'tamara@example.com'  , 206-290-8842 , 55 , 'Richmond' , 'WA' , 98138, '1989-03-25', 'Female' , 'Tamara_Trust'    , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'ED13233234'  )))


INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2329, 117, 'Rich'    , 'Rainmaker',   'rich@example.com'    , 206-290-8843 , 43 , 'Redmond'  , 'WA' , 98146, '2006-08-20', 'Male'   , 'Rich_Rainmaker'  , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'AS21221132'  )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2330, 118, 'Patty'   , 'Presenter',   'patty@example.com'   , 206-290-8842 , 55 , 'Richmond' , 'WA' , 98138, '1979-12-04', 'Female' , 'Patty_Presenter' , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'WE0O223212'  )))

INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2331, 119, 'Marty'   , 'Mongo'    ,   'marty@example.com'   , 206-290-8845 , 23 , 'Bellevue' , 'WA' , 98122, '1970-05-06', 'Male'   , 'Marty_Mongo'     , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'oo32123322'  )))

/* wrong email format will not visible in customer table entries*/
INSERT INTO	
Customer(Customer_Id, SalesPerson_Id , FirstName, LastName, Email, Phone, Street_No, City, State, Zip_Code, Birthday, Gender, Username, Password )	
VALUES
(2881, 119, 'Anuya'   , 'Somani'    ,   'martyexample.com'   , 206-290-8845 , 23 , 'Bellevue' , 'WA' , 98122, '1970-05-06', 'Male'   , 'Marty_Mongo'     , EncryptByKey(Key_GUID(N'Group5_SymmetricKey'), convert(varbinary, 'oo32123322'  )))

SELECT * FROM Customer 


/* For Decrypt Password */

SELECT DecryptByKey(Password) 
FROM Customer

INSERT INTO										
Event(Event_id, Event_type)										
VALUES										
(699, 'Wedding'       ),										
(420, 'Music Festival'),										
(421, 'Birthday'      ),										
(369, 'Conference'    ),										
(123, 'Bachelorette'  ),										
(741, 'Baby Shower'   ),										
(789, 'Graduation Party'),										
(147, 'VIP Events'    ),										
(852, 'Team Building' ),										
(521, 'Bachelors'     )	

SELECT * FROM Event e 

INSERT INTO  Customer_Feedback( Event_Id,Customer_Id,Feedback)
VALUES
(369    ,2326 ,   'Very Good' ),
(421    ,2327 ,   'Average'   ),
(369    ,2328 ,   'Average'   ),
(699    ,2326 ,   'Good'      ),
(699    ,2327 ,   'Good'      ),
(421    ,2328 ,   'Average'   ),
(369    ,2327 ,   'Average'   ),
(421    ,2328 ,   'Good'      ),
(699    ,2324 ,   'Very Good' ),
(420    ,2325 ,   'Very Good' ),
(421    ,2326 ,   'Very Good' )

SELECT * FROM Customer_Feedback cf 

INSERT INTO	
Package(Package_Id, Description , Amount )	
VALUES	
(1,  'Bronze'                   ,  10000 ),	
(2,  'Silver'                   ,  25000 ),	
(3,  'Gold'                     ,  45000 ),	
(4,  'Platinum'                 ,  70000 ),	
(5,  'Full Service'             ,  75000 ),	
(6,  'Partial Service'          ,  40000 ),	
(7,  'A La Carte Design'        ,  20000 ),	
(8,  'Day Of Event Coordination',  30000 ),
(9,  'Gold A'                   ,  50000 ),
(10, 'Platinum A'               ,  80000 )

SELECT * FROM Package p 

INSERT INTO        
Booking(Booking_id, Customer_id , Event_Id, Package_Id, Book_Date)        
VALUES        
(4000,    2323,    699,  2, 	'01/15/2019'),
(4001,    2324,    420,  3, 	'03/10/2022'),
(4002,    2325,    421,  3, 	'09/03/2021'),
(4003,    2326,    369,  4, 	'10/10/2022'),
(4004,    2327,    421,  1,     '11/20/2019'),
(4005,    2328,    369,  3,     '06/15/2020'),
(4006,    2326,    699,  6,     '07/30/2021'),
(4007,    2327,    699,  8,     '05/11/2020'),
(4008,    2328,    421,  2,	    '02/10/2022'),
(4009,    2327,    369,  2,     '10/10/2020'),
(4010,    2328,    421,  3,     '07/01/2021'),
(4011,    2324,    699,  3,     '11/01/2021'),
(4012,    2325,    420,  1,     '12/07/2019'),
(4013,    2326,    421,  5,     '10/12/2021'),
(4014,    2327,    369,  7,     '09/10/2020'),
(4015,    2323,    699,  8,     '02/05/2022')

SELECT * FROM Booking b 

INSERT INTO
Invoice (Invoice_Id, Booking_Id,  Customer_Id, Invoice_Date, Amount)					
VALUES 
(1221, 4000, 2323 ,  '01-16-2019' , 250000  ),					
(1222, 4001 ,2324 ,  '03/11/2022' , 45000  ),					
(1223 ,4002 ,2325 ,  '09/04/2021' , 45000  ),					
(1224 ,4003 ,2326 ,  '10/11/2022' , 70000  ),					
(1225 ,4004 ,2327 ,  '11/21/2019' , 10000  ),					
(1226 ,4005 ,2328 ,  '06/16/2020' , 450000 ),					
(1227 ,4006 ,2326 ,  '07/31/2021' , 40000  ),					
(1228 ,4007 ,2327 ,  '05/12/2020' , 30000  ),					
(1229 ,4008 ,2328 ,  '02/11/2022' , 250000 ),					
(1230 ,4009 ,2327 ,  '10/11/2020' , 25000  ),					
(1231 ,4010 ,2328 ,  '07/02/2021' , 450000 ),					
(1232 ,4011 ,2324 ,  '11/02/2021' , 45000  ),					
(1233 ,4012 ,2325 ,  '07/13/2019' , 10000  ),					
(1234 ,4013 ,2326 ,  '11/12/2021' , 75000  ),					
(1235 ,4014 ,2327 ,  '10/10/2020' , 20000  ),					
(1236 ,4015 ,2323 ,  '03/05/2022' , 300000  )

SELECT * FROM Invoice i 
					


INSERT INTO 
Payment(Payment_Id, Invoice_Id, Event_Id, Pay_date, Mode_of_Payment)					
VALUES
(11022, 1221,  699,    '01/20/2019',  'Cash' ),					
(11033, 1222,  420,   '03/19/2022',  'Card'),					
(11044, 1223,  421,   '09/09/2021',  'Applepay'),					
(11055, 1224,  369,   '10/19/2022',  'Googlepay'),					
(11066, 1225,  421,   '11/29/2019',  'Cash'),					
(11077, 1226,  369,   '06/22/2020',  'Paypal'),					
(11088, 1227,  699,   '08/06/2021',  'Paypal'),					
(11099, 1228,  699,   '05/17/2020',  'Applepay'),					
(11021, 1229,  421,   '02/18/2022',  'Googlepay'),					
(11031, 1230,  369,   '10/21/2020',  'Cash')					

SELECT * FROM Payment p 
					

INSERT INTO Vendor(Vendor_id , Vendor_type, FirstName, LastName, Phone, Email )
VALUES
(401 , 'Decorator'        ,  'Tom'     ,   'Brown'     ,   8934026447    , 'brown@example.com'    ),
(402 , 'Decorator'        ,  'Brian'   ,   'Russell'   ,   4790457324    , 'brian@example.com'    ),
(403 , 'Decorator'        ,  'Ryan'    ,   'Terry'     ,   5132575693    , 'terry@example.com'    ),
(404 , 'Decorator'        ,  'Ruba'    ,   'Tucker'    ,   3679457390    , 'ruba@example.com'     ),
(405 , 'Decorator'        ,  'Sam'     ,   'Baker'     ,   2106904697    , 'baker@example.com'    ),
(406 , 'Venue'            ,  'Simon'   ,   'Taylor'    ,   4578058004    , 'simon@example.com'    ),
(407 , 'Venue'            ,  'Adam'    ,   'Sutherland',   7843280755    , 'adam@example.com'     ),
(408 , 'Venue'            ,  'Ole'     ,   'Ole'        ,  673438341     , 'ole@example.com'      ),
(409 , 'Venue'            ,  'Obis'    ,   'Bower'      ,  3738532699    , 'bower@example.com'    ),
(410 , 'Performer'        ,  'Panny'   ,   'Campbell'   ,  7328903563    , 'panny@example.com'    ),
(411 , 'Performer'        ,  'Mason'   ,   'Tucker'     ,  8394469903    , 'mason@example.com'    ),
(412 , 'Performer'        ,  'Crisandra',  'Simpson'    ,  7839093467    , 'simpson@example.com'  ),
(413 , 'Makeup_Artist'    ,  'Soketu'  ,   'Baker'      ,  3678934789    , 'soketu@example.com'   ),
(414 , 'Makeup_Artist'    ,  'Alison'  ,   'Robertson'   ,  3890735277    , 'alison@example.com'   ),
(415 , 'Makeup_Artist'    ,  'Audrey'  ,   'Campbell'    ,  9033228788    , 'campbell@example.com' ),
(416 , 'Makeup_Artist'    ,  'Carol'   ,   'Randal'      ,  9076345789    , 'carol@example.com'    ),
(417 , 'Equipment'        ,  'Diana'   ,   'Taylor'      ,  9073289434    , 'diana@example.com'    ),
(418 , 'Equipment'        ,  'Jessica' ,   'Terry'       ,  7352678923    , 'jessica@example.com'  ),
(419 , 'Equipment'        ,  'Maria'   ,   'Brown'       ,  6237892034    , 'maria@example.com'    ),
(420 , 'Equipment'        ,  'Penelope',   'Wilson'      ,  7234389000    , 'wilson@example.com'   ),
(421 , 'Transportation'   ,  'Rebecca' ,   'Young'       ,  2341221378    , 'young@example.com'    ),
(422 , 'Transportation'   ,  'Molly'   ,   'Meth'        ,  6278398263    , 'meth@example.com'      ),
(423 , 'Transportation'   ,  'Benjamin',   'Russell'      , 3827392018    , 'benjamin@example.com' ),
(424 , 'Photographer'     ,  'Christopher','Sutherland' ,  5236271238     , 'sutherland@example.com' ),
(425 , 'Photographer'     ,  'Gordon'     , 'Young'     ,  43273892022    , 'gordon@example.com'    ),
(426 , 'Photographer'     ,  'Isaac'      , 'Taylor'    ,  2372403763     , 'issac@example.com'     ),
(427 , 'Photographer'     ,  'Natalie'    , 'Baker'     ,  2937037207     , 'natalie@example.com'   ),
(428 , 'Caterer'          ,  'Samantha'   , 'Terry'     ,  2638203328     , 'samantha@example.com'  ),
(429 , 'Caterer'          ,  'Sarah'      , 'Brown'     ,  9212678902     , 'sarah@example.com'     ),
(430 , 'Caterer'          ,  'Tracey'     , 'Wilson'    ,  5127859073     , 'tracey@example.com'    )

SELECT * FROM Vendor v 



INSERT INTO
Equipment(Equipment_id, Vendor_id , Name )
VALUES 
	(111, 417 ,'Speedlights'        ),
	(112, 418 ,'Speaker'            ),
	(113, 417 ,'Dancer Floor Lights'),
	(114, 419 ,'Cables'				),
	(115, 419 ,'Light Stand'		),
	(116, 417 ,'DJ Facade'			),
	(117, 420 ,'Speaker'			),
	(118, 420 ,'Lights'				),
	(119, 420 ,'Tripod and Light Stand'),
	(120, 417 ,'Cables'				)
	
	

SELECT * FROM Equipment e 
	
INSERT INTO
Performer(Performer_id, Vendor_id ,Category, FirstName , LastName , Email  )
VALUES 
	(181, 410 ,'Musicians', 'Olive' , 'Taylor' , 'olive@example.com' ),
	(182, 410 ,'Singer'   , 'James' , 'Lopez'  , 'Lopez@example.com' ),
	(183, 411 ,'Comedian' , 'Amir'  , 'Moore'  , 'amir@example.com'  ),
	(184, 411 ,'Magician' , 'Marry' , 'Jackson', 'marry@example.com' ),
	(185, 412 ,'Dancer'   , 'Mia'   , 'Brown'  , 'mia@example.com'   ),
	(186, 412 ,'SInger'   , 'Sophia', 'Brown'  , 'sophia@example.com'),
	(187, 410 ,'Musicians', 'Ivan'  , 'Davis'  , 'ivan@example.com'  ),
	(188, 410 ,'Dancer'   , 'Harley', 'Willams', 'lee@example.com'   ),
	(189, 412 ,'Singer'   , 'Ruby'  , 'Lee'    , 'ruby@example.com'  ),
	(190, 410 ,'clown'    , 'Isla'  , 'Willams', 'isla@example.com'  )

SELECT * FROM Performer p 

	
INSERT 
INTO Makeup_Artist(Artist_id, Vendor_id , FirstName, LastName, phone, Email )
VALUES
(251, 413 ,'Borris', 'Brejcha' , 6127859073 , 'borris07@techno.com'   ),
(252, 415 ,'Ben'   , 'Bohmer'  , 1127859073 , 'bohmer420@rave.com'    ),
(253, 414 ,'Atif'  , 'Shaikh'  , 5127445907 , 'atif.aslam@asuw.com'   ),
(254, 413 ,'Joe'   , 'Biden'   , 8127859073 , 'bidenthepresident@fckad.com' ),
(255, 416 ,'Kamla' , 'Harris'  , 6127859073 , 'kamlathevp@indian.com' ),
(256, 414 ,'Barak' , 'Obama'   , 7127859063 , 'Obama69@skad.com'      ),
(257, 416 ,'Tom'   , 'Holland' , 5127669073 , 'holland@53spider.com'  ),
(258, 415 ,'Will'  , 'Smith'   , 1227859073 , 'smith4@slap.com'      ),
(259, 413 ,'Chris' , 'Rock'    , 9127859073 , 'chrisrock@nottherock.com'),
(260, 415 ,'Kevin' , 'Hart'    , 6127859073 , 'Kevinhart@funny.com'   )

SELECT * FROM Makeup_Artist ma 

INSERT INTO
Transportation(Tranportation_id, Vendor_id , Cost_per_km, No_of_seats,  Vehicle_type, License_type )
VALUES
(161, 421, 14, 4 ,'Sedan'    ,  'JA45KO' ),
(162, 421, 16, 4 ,'Sedan'    ,  'E3LO4E' ),
(163, 423, 24, 2 ,'Roadster' ,  'WE4L05' ),
(164, 422, 21, 6 ,'SUV'      ,  'RL94LF' ),
(165, 422, 18, 4 ,'Sedan'    ,  'DIF37C' ),
(166, 423, 25, 2 ,'Roadster' ,  'KP8XK3' ),
(167, 421, 19, 4 ,'Sedan'    ,  'IFLS73' ),
(168, 422, 18, 6 ,'SUV'      ,  'ID39D5' ),
(169, 421, 17, 4 ,'Sedan'    ,  '8DU73K' ),
(170, 423, 15, 4 ,'Sedan'    ,  'KD80A4' )

SELECT * FROM Transportation t 


INSERT INTO										
Caterer(Cat_id, Vendor_id , Charges )										
VALUES										
(171, 428 , 1000),										
(172, 428 , 1500),										
(173, 428 , 2000),										
(174, 429 , 1500),										
(175, 429 , 1750),										
(176, 429 , 2000),										
(177, 430 , 1600),										
(178, 430 , 2000),										
(179, 430 , 3000),										
(480, 430 , 5000)	

INSERT INTO										
Venue(Venue_id, Vendor_id , Name, Capacity, Street_No, City, State, Zipcode, Rent, Phone )										
VALUES										
(1111,  406,  'Chomu Palace' 		 ,      2500 ,	'12 western'         ,   'Seattle'   ,	'Washington'  ,	98132,	20000,	987653210),					
(2222,	406,  'Le Meridien'	 		 ,	    3000 ,	'16 eastern'         ,	 'Bothell'	 ,  'Washington'  ,	48614,	25000,	654983214),	
(3333,	408,  'Umaid Bhawan'  		 ,	    2000 ,	'19 Village Road'    ,	 'New Jersey',	'New York'    ,	36511,	60000,	456318974),	
(4444,	407,  'Indana Palace'        ,  	3000 ,	' 128 Hoax Road'     ,	 'LA'        ,	'California'  ,	65432,	50000,	321843423),	
(5555,	409,  'Riva beach Resort'    ,	    4000 ,	'Illusion Ways'      ,   'Chicago'   ,	'Illonios'    ,	31581,	25000,	896465461),	
(6666,	407,  'Cidade De Goa'        ,	    2500 ,	'256 candolim'       ,	 'LA'        ,	'California'  , 35146,	30000,	676464212),		
(7777,	409,  'Vivanta Taj'          ,	    1200 ,	'Andheri West'	     ,   'Miami'     ,	'Florida'     ,	86714,	40000,	231412561),	
(8888,	409,  'Mariiot'              ,	    1500 ,  'Santacruz East'	 ,   'Miami'     ,	'Florida'     ,	87648,	45000,	123532412),		
(9999,	408,  'American Natural Museum',	3000 ,	'1500 North'         ,	 'New York'  ,	'New York'    ,	65546,	80000,	331483148),	
(6969,	408,  'The Plaza Hotel'       ,	    1000 ,	'Central Park South' ,	 'New York'  ,	'New York'    ,	65434,	100000, 318564362)	
		
																																			
INSERT INTO 
Decoration(Decor_Id, Vendor_Id, Charge)	
VALUES
(511, 401, 1000),			
(512, 402, 1200),			
(513, 401, 1150),			
(514, 404 , 2000),			
(515, 403, 3000),			
(516, 405, 4000),			
(517, 402, 5000),			
(518, 401, 2500),			
(519, 404, 3500),			
(520, 403, 4500)	


------------------------------------------------Function & Computed Column--------------------------------------------------------------

/* FUNCTION TO CALCULATE NoOfBooking per Customer */

CREATE FUNCTION dbo.numOfBooking
(@customerID int)
RETURNS int 
AS 
BEGIN
	DECLARE @counter int
	SELECT @counter = COUNT(*) FROM 
		(SELECT * FROM Booking b 
		 WHERE  b.Customer_Id = @customerID) t
	RETURN @counter
END
 
SELECT dbo.numOfBooking(2327)   /* return count */




/* FUNCTION TO CALCULATE Age of Customer */
DROP FUNCTION dbo.Calculate_Age

CREATE FUNCTION dbo.Calculate_Age(@Date Date)
RETURNS INT
AS
BEGIN
RETURN (DATEDIFF(hour, @Date, GETDATE())/8766)
END


ALTER TABLE Customer
ADD AGE AS (dbo.Calculate_Age(Birthday))

SELECT * FROM Customer c 


/* FUNCTION TO CALCULATE Salary per year */
DROP FUNCTION dbo.UDF_YearlyIncome

CREATE FUNCTION dbo.UDF_YearlyIncome(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN 14.15* @Salary
END

ALTER TABLE Employee 
ADD Yearly_salary AS (dbo.UDF_YearlyIncome(Salary))

Select * FROM Employee e 



/* FUNCTION TO Check Email Address valid */
DROP FUNCTION IsValidEmail

CREATE FUNCTION IsValidEmail ( @Email varchar(50) )
RETURNS int
BEGIN
    DECLARE @IsValidEmail as int
    IF  (@Email <> '' And @Email NOT LIKE '_%@__%.__%')
        SET @IsValidEmail = 0    --Invalid
    ELSE
        SET @IsValidEmail = 1  --Valid
    RETURN @IsValidEmail
END

ALTER TABLE Customer ADD CONSTRAINT ckemail CHECK(dbo.IsValidEmail(Email) = 1)

---------------------------------------------- Views ---------------------------------------------------------------------

/*View to Calculate total sales by customer */
DROP VIEW  Sales_by_customer 

CREATE VIEW Sales_by_Customer AS
SELECT  c.customer_id, Firstname+ ' '+Lastname as FullName, sum(Amount) AS sales
FROM customer c JOIN Invoice i
ON   c.customer_id = i.customer_id
GROUP BY c.customer_id, Firstname, Lastname

/*Test Run*/

SELECT * FROM Sales_by_Customer



/*View to see top 5 customers  */
DROP VIEW  Top5_Customers

CREATE VIEW Top5_Customers as
SELECT * FROM
(SELECT  c.customer_id, Firstname+ ' '+Lastname as FullName, sum(Amount) AS sales,
DENSE_RANK() OVER(ORDER BY SUM(Amount)DESC) AS TopCustomer
FROM customer c JOIN Invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, Firstname, Lastname) x
WHERE TopCustomer in (1,2,3,4,5)

/*Test Run*/
SELECT * FROM Top5_Customers

/*View to see customers with pending payments  */

DROP VIEW Customers_WithpendingPayments

CREATE VIEW Customers_WithpendingPayments AS
SELECT i.customer_id, Sum(Amount) AS OutsatndingPayments
FROM invoice i
WHERE invoice_id NOT IN (SELECT invoice_id FROM payment)
GROUP BY i.customer_id

/*Test Run*/
SELECT  * FROM Customers_WithpendingPayments







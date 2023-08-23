 drop schema test;
 create schema test;
 use test;
 
 CREATE TABLE Persons (
medicareNumber INT PRIMARY KEY,
medicareExpiryDate DATE NOT NULL,
firstName VARCHAR(255) NOT NULL,
lastName VARCHAR(255) NOT NULL,
dateOfBirth DATE NOT NULL,
phone BIGINT UNSIGNED NOT NULL,
citizenship VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL
);
 

CREATE TABLE Employees (
employeeID INT AUTO_INCREMENT PRIMARY KEY,
medicareNumber INT,
FOREIGN KEY (medicareNumber) REFERENCES Persons(medicareNumber) ON DELETE CASCADE
);
 
CREATE TABLE Students (
studentID INT AUTO_INCREMENT PRIMARY KEY,
medicareNumber INT,
FOREIGN KEY (medicareNumber) REFERENCES Persons(medicareNumber) ON DELETE CASCADE
);
 
CREATE TABLE Vaccinations (
doseNumber INT NOT NULL,
medicareNumber INT,
date DATE NOT NULL,
type VARCHAR(255) NOT NULL,
FOREIGN KEY (medicareNumber) REFERENCES Persons(medicareNumber) ON DELETE CASCADE,
PRIMARY KEY (doseNumber, medicareNumber)
);
 
CREATE TABLE Infections (
infectionID INT AUTO_INCREMENT PRIMARY KEY,
infectionNumber INT NOT NULL,
medicareNumber INT,
date DATE NOT NULL,
type VARCHAR(255) NOT NULL,
FOREIGN KEY (medicareNumber) REFERENCES Persons(medicareNumber) ON DELETE CASCADE
);
 
CREATE TABLE Ministries (
  ministryID INT PRIMARY KEY,
  sector VARCHAR(255)
);
 
CREATE TABLE Facilities (
  facilityID INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  phone BIGINT UNSIGNED NOT NULL,
  webAddress VARCHAR(255) NOT NULL,
  capacity INT UNSIGNED NOT NULL
);
 
CREATE TABLE Operation (
ministryID INT,
facilityID INT,
FOREIGN KEY (facilityID) REFERENCES Facilities(facilityID) ON DELETE CASCADE,
FOREIGN KEY (ministryID) REFERENCES Ministries(ministryID) ON DELETE CASCADE,
PRIMARY KEY (facilityID)
);
 
CREATE TABLE ManagementFacility (
  managementFacilityID INT AUTO_INCREMENT PRIMARY KEY,
  facilityID INT,
  president INT NOT NULL,
  FOREIGN KEY (facilityID) REFERENCES Facilities(facilityID) ON DELETE CASCADE,
  FOREIGN KEY (president) REFERENCES Employees(employeeID) ON DELETE CASCADE
);
 
CREATE TABLE GeneralManagementFacility (
generalManagementFacilityID INT AUTO_INCREMENT PRIMARY KEY,
managementFacilityID INT,
FOREIGN KEY (managementFacilityID) REFERENCES ManagementFacility(managementFacilityID) ON DELETE CASCADE
          	);
 
CREATE TABLE HeadOffice (
headOfficeID INT UNIQUE NOT NULL,
managementFacilityID INT PRIMARY KEY,
ministryID INT,
FOREIGN KEY (managementFacilityID) REFERENCES ManagementFacility(managementFacilityID) ON DELETE CASCADE,
FOREIGN KEY (ministryID) REFERENCES Ministries(ministryID) ON DELETE CASCADE
);
 
CREATE TABLE EducationalFacility (
  educationalFacilityID INT AUTO_INCREMENT PRIMARY KEY,
  facilityID INT,
  schoolType ENUM ('Primary', 'Middle', 'High', 'Combo'),
  FOREIGN KEY (facilityID) REFERENCES Facilities(facilityID) ON DELETE CASCADE
);
 
CREATE TABLE Registration (
studentID INT,
facilityID INT,
startDate DATE NOT NULL,
endDate DATE,
level VARCHAR(255) NOT NULL,
FOREIGN KEY (studentID) REFERENCES Students(studentID) ON DELETE CASCADE,
FOREIGN KEY (facilityID) REFERENCES Facilities(facilityID) ON DELETE CASCADE,
PRIMARY KEY (studentID, facilityID, startDate)
);
 
 
CREATE TABLE Teachers (
teacherID INT AUTO_INCREMENT PRIMARY KEY,
employeeID INT,
educationalFacilityID INT,
FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE,
FOREIGN KEY (educationalFacilityID) REFERENCES EducationalFacility(educationalFacilityID) ON DELETE CASCADE
);
 
CREATE TABLE ElementaryTeacher (
elementaryTeacherID INT AUTO_INCREMENT PRIMARY KEY,
teacherID INT,
FOREIGN KEY (teacherID) REFERENCES Teachers(teacherID) ON DELETE CASCADE
);
 
CREATE TABLE SecondaryTeacher (
secondaryTeacherID INT AUTO_INCREMENT PRIMARY KEY,
teacherID INT,
specialization VARCHAR(255) NOT NULL,
role ENUM('Counselor', 'Director', 'Administrator'),
FOREIGN KEY (teacherID) REFERENCES Teachers(teacherID) ON DELETE CASCADE
);
 
CREATE TABLE Location (
  addressID INT AUTO_INCREMENT PRIMARY KEY,
  address INT NOT NULL,
  city VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  postalCode VARCHAR(255) NOT NULL
);
 
CREATE TABLE Residence (
medicareNumber INT PRIMARY KEY,
addressID INT,
FOREIGN KEY (medicareNumber) REFERENCES Persons (medicareNumber) ON DELETE CASCADE,
FOREIGN KEY (addressID) REFERENCES Location (addressID) ON DELETE CASCADE
);
 
CREATE TABLE Situated (
facilityID INT PRIMARY KEY,
addressID INT,
FOREIGN KEY (facilityID) REFERENCES Facilities (facilityID) ON DELETE CASCADE,
FOREIGN KEY (addressID) REFERENCES Location (addressID) ON DELETE CASCADE
);
 
CREATE TABLE EmailLog (
	emailID INT AUTO_INCREMENT PRIMARY KEY,
	date DATE NOT NULL,
          	facilityID INT,
          	employeeID INT,
	sender VARCHAR(255) NOT NULL,
	receiverFirstName VARCHAR(255) NOT NULL,
          	receiverLastName VARCHAR(255) NOT NULL,
	subject VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,
FOREIGN KEY (facilityID) REFERENCES Facilities (facilityID) ON DELETE CASCADE,
FOREIGN KEY (employeeID) REFERENCES Employees (employeeID) ON DELETE CASCADE
);
 
CREATE TABLE Schedule (
    employeeID INT,
    scheduleDate DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    facilityID int,
     FOREIGN KEY (facilityID)
        REFERENCES Facilities (facilityID),
    FOREIGN KEY (employeeID)
        REFERENCES Employees (employeeID),
    UNIQUE (employeeID , scheduleDate , endTime),
    PRIMARY KEY (employeeID , scheduleDate , startTime)
);

CREATE TABLE Contract (
employeeID INT,
facilityID INT,
startDate DATE NOT NULL,
endDate DATE,
role VARCHAR(255) NOT NULL,
FOREIGN KEY (employeeID) REFERENCES Employees(employeeID) ON DELETE CASCADE,
FOREIGN KEY (facilityID) REFERENCES Facilities(facilityID) ON DELETE CASCADE,
 PRIMARY KEY (employeeID,facilityID,startDate)
 );

 
INSERT INTO Persons (medicareNumber, medicareExpiryDate, firstName, lastName, dateOfBirth, phone, citizenship, email)
VALUES
(5048, '2023-09-26', 'Tom', 'Phillips', '2002-11-04', 218038875, 'Canadian', 'person1@example.com'),
(7633, '2022-10-07', 'Nayeli', 'Harris', '1976-05-07', 914546857, 'German', 'person2@example.com'),
(3792, '2022-01-26', 'Steven', 'James', '1995-10-23', 417204837, 'American', 'person3@example.com'),
(3295, '2025-06-12', 'Natali', 'White', '1990-10-16', 303711351, 'French', 'person4@example.com'),
(9508, '2022-07-15', 'Michael', 'Martin', '2003-06-11', 856895891, 'Australian', 'person5@example.com'),
(1805, '2022-09-19', 'Maria', 'Evans', '1962-06-19', 958736466, 'French', 'person6@example.com'),
(6349, '2024-11-05', 'Nicole', 'Jackson', '1988-09-14', 777745522, 'Canadian', 'person7@example.com'),
(2068, '2023-03-24', 'Natalya', 'Baker', '1967-07-05', 962355955, 'German', 'person8@example.com'),
(6013, '2024-08-22', 'Joe', 'Miller', '1988-09-16', 295279935, 'Canadian', 'person9@example.com'),
(9671, '2022-08-22', 'John', 'Wright', '1976-01-11', 164511484, 'French', 'person10@example.com'),
(5721, '2023-03-23', 'Tom', 'Martinez', '1974-09-01', 639881652, 'German', 'person11@example.com'),
(2941, '2023-09-28', 'Steven', 'Murphy', '1960-09-22', 736149025, 'French', 'person12@example.com'),
(6736, '2025-06-12', 'Joe', 'Flores', '1991-07-11', 626373293, 'French', 'person13@example.com'),
(6185, '2025-07-08', 'Nancy', 'Cook', '1998-04-11', 335217668, 'Australian', 'person14@example.com'),
(6760, '2022-06-04', 'Steven', 'Bell', '2002-02-14', 751558232, 'Australian', 'person15@example.com'),
(3837, '2023-07-03', 'Maria', 'Russell', '1996-08-23', 957211208, 'Canadian', 'person16@example.com'),
(4997, '2023-06-26', 'Jack', 'Robinson', '1992-01-08', 581147180, 'French', 'person17@example.com'),
(2165, '2024-08-14', 'Jack', 'Roberts', '1998-04-14', 648481342, 'American', 'person18@example.com'),
(6560, '2023-10-08', 'John', 'Gonzalez', '1962-03-18', 143748391, 'Australian', 'person19@example.com'),
(6661, '2025-04-17', 'Nia', 'Murphy', '1967-02-27', 912851240, 'German', 'person20@example.com'),
(4874, '2024-07-21', 'Nathalie', 'Walker', '1998-06-18', 783500106, 'German', 'person21@example.com'),
(4233, '2025-09-09', 'Nora', 'White', '1994-01-09', 785019153, 'British', 'person22@example.com'),
(2506, '2023-02-10', 'Nathaly', 'Howard', '1977-02-19', 945519013, 'Canadian', 'person23@example.com'),
(2515, '2022-03-05', 'Nathan', 'Kelly', '1976-03-09', 278047016, 'American', 'person24@example.com'),
(4628, '2023-02-02', 'Nancy', 'Rogers', '1984-06-22', 720769265, 'French', 'person25@example.com'),
(9388, '2022-11-25', 'Steven', 'Washington', '1998-09-11', 127109103, 'French', 'person26@example.com'),
(6706, '2022-09-13', 'Nora', 'Scott', '1971-07-06', 426885138, 'German', 'person27@example.com'),
(9830, '2024-03-06', 'Nathalia', 'Sanders', '1976-10-13', 412807743, 'Canadian', 'person28@example.com'),
(1799, '2025-11-19', 'Natalya', 'Carter', '1964-11-20', 859210472, 'German', 'person29@example.com'),
(3667, '2024-06-15', 'Julia', 'Kelly', '1979-07-19', 122821961, 'Australian', 'person30@example.com'),
(9801, '2024-10-03', 'Natalya', 'Adams', '1972-12-20', 100886725, 'French', 'person31@example.com'),
(1132, '2024-10-27', 'Jack', 'Alexander', '2001-02-07', 997905683, 'American', 'person32@example.com'),
(1556, '2023-05-28', 'Mary', 'Rogers', '1985-05-14', 581046349, 'American', 'person33@example.com'),
(5728, '2024-07-11', 'Nia', 'Cook', '1975-04-26', 681659378, 'American', 'person34@example.com'),
(3682, '2024-11-13', 'Nevaeh', 'Johnson', '1995-06-11', 938775297, 'Canadian', 'person35@example.com'),
(5860, '2022-03-07', 'Nathan', 'Diaz', '2003-08-12', 692850501, 'British', 'person36@example.com'),
(6640, '2024-12-27', 'Natalia', 'Lewis', '2003-04-05', 373676914, 'French', 'person37@example.com'),
(8456, '2025-12-14', 'Joe', 'Phillips', '1978-10-11', 496423866, 'Canadian', 'person38@example.com'),
(8179, '2025-03-28', 'Noah', 'Powell', '1961-09-18', 341125934, 'Canadian', 'person39@example.com'),
(1947, '2024-03-13', 'Natalie', 'Williams', '1978-04-25', 821922687, 'Australian', 'person40@example.com'),
(9620, '2022-01-01', 'Natali', 'Carter', '1986-04-23', 101158407, 'Australian', 'person41@example.com'),
(5400, '2024-02-20', 'Nathan', 'Carter', '1996-05-12', 781192683, 'Canadian', 'person42@example.com'),
(6011, '2025-11-24', 'Tom', 'Price', '2000-11-27', 596009224, 'Australian', 'person43@example.com'),
(8280, '2023-10-11', 'Nina', 'Williams', '1996-05-05', 274731623, 'British', 'person44@example.com'),
(5905, '2023-04-10', 'Nathalie', 'Cooper', '1964-02-18', 974005556, 'Canadian', 'person45@example.com');
 
INSERT INTO Employees (employeeID, medicareNumber)
VALUES
(1001, 1132),
(1002, 1556),
(1003, 1799),
(1004, 1805),
(1005, 1947),
(1006, 2068),
(1007, 2165),
(1008, 2506),
(1009, 2515),
(1010, 2941),
(1011, 3295),
(1012, 3667),
(1013, 3682),
(1014, 3792),
(1015, 3837),
(1016, 4233),
(1017, 4628),
(1018, 4874),
(1019, 4997),
(1020, 5048),
(1021, 5400),
(1022, 5721),
(1023, 5728),
(1024, 5860),
(1025, 5905),
(1026, 6011),
(1027, 6013),
(1028, 6185);
 
 
INSERT INTO Students (studentID, medicareNumber)
VALUES
(2001, 6349),
(2002, 6560),
(2003, 6640),
(2004, 6661),
(2005, 6706),
(2006, 6736),
(2007, 6760),
(2008, 7633),
(2009, 8179),
(2010, 8280),
(2011, 8456),
(2012, 9388),
(2013, 9508),
(2014, 9620),
(2015, 9671),
(2016, 9801),
(2017, 9830);
 
INSERT INTO Infections (infectionNumber, medicareNumber, date, type)
VALUES
(1, 9830, '2022-12-17', 'Other'),
(1, 9801, '2023-01-28', 'SARS-Cov-2 Variant'),
(1, 5400, '2021-11-08', 'Other'),
(1, 5860, '2023-03-26', 'Other'),
(3, 4874, '2023-07-14', 'COVID-19'),
(1, 6349, '2023-03-09', 'COVID-19'),
(1, 1947, '2023-01-04', 'COVID-19'),
(1, 4233, '2022-11-17', 'COVID-19'),
(1, 6706, '2022-03-22', 'COVID-19'),
(1, 6736, '2022-08-15', 'SARS-Cov-2 Variant'),
(3, 6011, '2023-06-24', 'Other'),
(2, 8179, '2023-01-03', 'SARS-Cov-2 Variant'),
(1, 4874, '2022-05-03', 'COVID-19'),
(2, 1947, '2023-05-26', 'SARS-Cov-2 Variant'),
(1, 8179, '2022-08-22', 'SARS-Cov-2 Variant'),
(2, 1799, '2023-05-26', 'Other'),
(1, 8280, '2022-06-19', 'SARS-Cov-2 Variant'),
(1, 9508, '2021-03-04', 'COVID-19'),
(2, 2506, '2023-06-10', 'SARS-Cov-2 Variant'),
(2, 2515, '2023-01-22', 'COVID-19'),
(1, 2506, '2022-08-14', 'SARS-Cov-2 Variant'),
(1, 1805, '2022-05-21', 'SARS-Cov-2 Variant'),
(3, 8280, '2023-07-17', 'SARS-Cov-2 Variant'),
(1, 3295, '2023-01-21', 'SARS-Cov-2 Variant'),
(1, 4628, '2023-02-17', 'SARS-Cov-2 Variant'),
(1, 6011, '2022-01-13', 'Other'),
(2, 4874, '2023-06-19', 'COVID-19'),
(1, 3667, '2023-03-02', 'SARS-Cov-2 Variant'),
(1, 9671, '2022-08-05', 'Other'),
(2, 6736, '2023-03-06', 'COVID-19'),
(1, 1556, '2022-07-09', 'COVID-19'),
(2, 1556, '2023-01-01', 'COVID-19'),
(3, 1556, '2023-03-09', 'COVID-19'),
(2, 9508, '2022-01-27', 'Other'),
(1, 6013, '2022-01-01', 'SARS-Cov-2 Variant'),
(1, 8456, '2023-03-19', 'SARS-Cov-2 Variant'),
(1, 1799, '2023-08-01', 'COVID-19'),
(3, 9508, '2023-01-12', 'Other'),
(1, 6640, '2022-01-24', 'SARS-Cov-2 Variant'),
(2, 6013, '2023-03-07', 'COVID-19'),
(1, 5728, '2023-04-13', 'Other'),
(1, 2515, '2022-11-24', 'SARS-Cov-2 Variant'),
(1, 3792, '2022-11-01', 'Other'),
(1, 9620, '2023-07-13', 'SARS-Cov-2 Variant'),
(1, 7633, '2022-09-02', 'Other'),
(1, 1132, '2023-04-13', 'Other'),
(2, 6011, '2023-05-17', 'COVID-19'),
(2, 9671, '2022-12-22', 'COVID-19'),
(2, 6640, '2023-03-28', 'Other'),
(2, 5400, '2023-05-21', 'COVID-19'),
(2, 8280, '2023-02-03', 'Other'),
(2, 4233, '2023-01-09', 'SARS-Cov-2 Variant'),
(2, 4628, '2023-06-17', 'Other'),
(1, 5721, '2022-02-05', 'COVID-19'),
(2, 5721, '2023-06-24', 'Other'),
(1, 3837, '2022-02-18', 'SARS-Cov-2 Variant'),
(2, 1132, '2023-08-01', 'COVID-19'),
(2, 3792, '2023-01-09', 'COVID-19'),
(3, 5721, '2023-08-02', 'Other'),
(3, 9671, '2023-07-25', 'COVID-19');
 
INSERT INTO Vaccinations (doseNumber, medicareNumber, date, type)
VALUES
(1, 6013, '2021-10-14', 'AstraZeneca'),
(1, 3667, '2022-02-18', 'Sinovac'),
(1, 3682, '2021-04-22', 'Novavax'),
(1, 9671, '2022-08-05', 'Novavax'),
(1, 1556, '2023-07-13', 'Sinovac'),
(1, 9830, '2022-10-28', 'AstraZeneca'),
(1, 6560, '2022-05-22', 'Novavax'),
(2, 6560, '2023-01-05', 'Johnson & Johnson'),
(1, 4628, '2023-05-18', 'Sinovac'),
(1, 8456, '2022-03-26', 'Pfizer'),
(1, 9801, '2022-04-01', 'Sinovac'),
(1, 6011, '2022-02-12', 'Johnson & Johnson'),
(1, 6736, '2022-11-03', 'Moderna'),
(1, 6640, '2022-07-11', 'Johnson & Johnson'),
(1, 6661, '2022-09-17', 'Novavax'),
(1, 2515, '2021-09-13', 'Johnson & Johnson'),
(1, 9508, '2022-02-26', 'Johnson & Johnson'),
(1, 2941, '2021-01-03', 'Novavax'),
(1, 2068, '2022-09-03', 'Novavax'),
(2, 6640, '2023-07-24', 'Pfizer'),
(1, 7633, '2022-01-07', 'Johnson & Johnson'),
(1, 3837, '2022-10-17', 'AstraZeneca'),
(1, 1805, '2022-10-08', 'Moderna'),
(1, 6760, '2021-02-03', 'Novavax'),
(1, 5048, '2022-11-03', 'Novavax'),
(2, 5728, '2022-10-02', 'Moderna'),
(1, 3295, '2021-03-12', 'Moderna'),
(1, 6349, '2021-12-03', 'Johnson & Johnson'),
(2, 9830, '2022-08-26', 'AstraZeneca'),
(1, 5721, '2022-09-27', 'Moderna'),
(2, 8179, '2023-02-26', 'AstraZeneca'),
(3, 6560, '2023-03-22', 'Moderna'),
(2, 6011, '2023-01-25', 'Moderna'),
(2, 2515, '2022-07-07', 'Novavax'),
(2, 2068, '2023-05-06', 'Moderna'),
(3, 6011, '2022-08-28', 'Sinovac'),
(2, 9671, '2022-05-03', 'AstraZeneca'),
(2, 3837, '2022-11-10', 'Moderna'),
(2, 3295, '2023-07-24', 'Sinovac'),
(3, 3837, '2022-11-21', 'Moderna'),
(2, 6013, '2023-07-18', 'Pfizer'),
(2, 5905, '2022-11-22', 'Novavax'),
(1, 2506, '2022-11-10', 'Sinovac'),
(4, 3837, '2023-02-26', 'Sinovac'),
(2, 6760, '2023-02-10', 'Novavax'),
(1, 6185, '2022-04-03', 'Johnson & Johnson'),
(2, 9801, '2023-06-28', 'AstraZeneca'),
(1, 5905, '2022-01-17', 'Sinovac'),
(1, 8280, '2022-04-02', 'Pfizer'),
(1, 4874, '2023-02-27', 'Moderna'),
(1, 8179, '2023-08-02', 'Johnson & Johnson'),
(1, 5728, '2022-09-24', 'Moderna'),
(1, 4997, '2022-10-09', 'Sinovac'),
(2, 3682, '2023-07-17', 'Novavax'),
(2, 6349, '2023-07-09', 'Sinovac'),
(2, 5048, '2023-07-13', 'Sinovac'),
(2, 3667, '2023-05-21', 'Johnson & Johnson'),
(1, 1799, '2023-07-15', 'Johnson & Johnson'),
(1, 4233, '2022-03-02', 'AstraZeneca'),
(3, 6013, '2023-06-15', 'Pfizer');
 
INSERT INTO Ministries (ministryID, sector)
VALUES
(1, 'Agriculture'),
(2, 'Health'),
(3, 'Energy');
  
INSERT INTO Facilities (facilityID, name, phone, webAddress, capacity)
VALUES
(1, 'Base', 930727010, 'www.facility1.com', 152),
(2, 'Head', 542731214, 'www.facility2.com', 108),
(3, 'Knox', 699068911, 'www.facility3.com', 185),
(4, 'Jackson', 306677544, 'www.facility4.com', 462),
(5, 'Levi', 510938734, 'www.facility5.com', 72),
(6, 'Home', 456290238, 'www.facility6.com', 38),
(7, 'Tree', 497364493, 'www.facility7.com', 49),
(8, 'Sea', 585972116, 'www.facility8.com', 310),
(9, 'Ship', 513477902, 'www.facility9.com', 163);
 
INSERT INTO Operation (ministryID, facilityID)
VALUES
(1, 1),
(1, 4),
(1, 5),
(2, 2),
(2, 6),
(2, 7),
(3, 3),
(3, 8),
(3, 9);
 
INSERT INTO ManagementFacility (managementFacilityID, facilityID, president)
VALUES
(1, 4, 1004),
(2, 5, 1005),
(3, 6, 1006),
(4, 7, 1007),
(5, 8, 1008),
(6, 9, 1009);
 
INSERT INTO GeneralManagementFacility (generalManagementFacilityID, managementFacilityID)
VALUES
(1, 4),
(2, 5),
(3, 6);
 
INSERT INTO HeadOffice (headOfficeID, managementFacilityID, ministryID)
VALUES
(1, 1, 1),
(2, 5, 2),
(3, 3, 3);
 
INSERT INTO EducationalFacility (educationalFacilityID, facilityID, schoolType)
VALUES
(1, 1, 'Primary'),
(2, 2, 'Middle'),
(3, 3, 'High');
 
INSERT INTO Teachers (teacherID, employeeID, educationalFacilityID)
VALUES
(1, 1001, 1),
(2, 1002, 2),
(3, 1003, 3);
 
INSERT INTO ElementaryTeacher (elementaryTeacherID, teacherID)
VALUES
(1, 1);
 
INSERT INTO SecondaryTeacher (secondaryTeacherID, teacherID, specialization, role)
VALUES
(2, 2, 'Math', 'Counselor'),
(3, 3, 'Geography', 'Director');
 
 
INSERT INTO Registration (studentID, facilityID, startDate, endDate, level)
VALUES
(2001, 1, '2023-11-23', '2024-12-15', 5),
(2002, 1, '2022-07-16', NULL, 12),
(2003, 3, '2022-12-28', NULL, 6),
(2004, 1, '2023-05-14', NULL, 10),
(2005, 3, '2022-10-06', '2024-01-27', 2),
(2006, 3, '2022-01-17', '2024-04-23', 8),
(2007, 1, '2022-02-14', '2023-05-01', 6),
(2008, 1, '2022-04-08', '2024-09-15', 9),
(2009, 2, '2022-08-21', '2023-05-05', 5),
(2010, 2, '2023-08-06', '2023-07-24', 2),
(2011, 2, '2023-09-09', '2023-05-16', 12),
(2012, 3, '2023-03-17', '2023-04-23', 1),
(2013, 2, '2023-06-03', '2024-07-11', 8),
(2014, 1, '2022-11-03', '2023-08-01', 1),
(2015, 2, '2022-11-21', '2024-06-06', 4),
(2016, 1, '2022-04-05', NULL, 1),
(2017, 1, '2022-11-10', '2024-05-05', 12);
 
INSERT INTO Location (addressID, address, city, province, postalCode)
          	VALUES
          	(1, 301, 'Montreal', 'Quebec', 'H0KG0L'),
(2, 659, 'Laval', 'Quebec', 'H2KG3L'),
(3, 772, 'Laval', 'Quebec', 'H4KG6L'),
(4, 374, 'Toronto', 'Ontario', 'H5KG2L'),
          	(5, 659, 'Toronto', 'Ontario', 'H3KG4L'),
(6, 611, 'Montreal', 'Quebec', 'H1KG3L'),
(7, 124, 'Montreal', 'Quebec', 'H8KG0L'),
(8, 973, 'Toronto', 'Ontario', 'H4KG8L'),
(9, 228, 'Toronto', 'Ontario', 'H7KG5L'),
(10, 842, 'Montreal', 'Quebec', 'H6KG8L'),
(11, 717, 'Laval', 'Quebec', 'H8KG0L'),
(12, 852, 'Ottawa', 'Ontario', 'H4KG4L'),
(13, 462, 'Montreal', 'Quebec', 'H2KG2L'),
(14, 753, 'Montreal', 'Quebec', 'H5KG6L'),
(15, 369, 'Montreal', 'Quebec', 'H1KG7L'),
(16, 959, 'Montreal', 'Quebec', 'H1KG9L'),
(17, 411, 'Laval', 'Quebec', 'H8KG3L'),
(18, 587, 'Toronto', 'Ontario', 'H1KG1L'),
(19, 228, 'Toronto', 'Ontario', 'H4KG5L'),
(20, 395, 'Toronto', 'Ontario', 'H5KG0L'),
(21, 920, 'Montreal', 'Quebec', 'H7KG2L'),
(22, 299, 'Laval', 'Quebec', 'H3KG3L'),
(23, 588, 'Laval', 'Quebec', 'H1KG4L'),
(24, 284, 'Toronto', 'Ontario', 'H2KG4L'),
(25, 736, 'Laval', 'Quebec', 'H4KG6L'),
(26, 585, 'Montreal', 'Quebec', 'H9KG8L'),
(27, 825, 'Ottawa', 'Ontario', 'H8KG3L'),
(28, 341, 'Montreal', 'Quebec', 'H8KG6L'),
(29, 930, 'Montreal', 'Quebec', 'H1KG1L'),
(30, 233, 'Montreal', 'Quebec', 'H5KG8L'),
(31, 106, 'Ottawa', 'Ontario', 'H3KG9L'),
(32, 228, 'Ottawa', 'Ontario', 'H4KG8L'),
(33, 514, 'Laval', 'Quebec', 'H0KG4L'),
(34, 246, 'Ottawa', 'Ontario', 'H3KG7L'),
(35, 707, 'Montreal', 'Quebec', 'H7KG1L'),
(36, 904, 'Montreal', 'Quebec', 'H9KG8L'),
(37, 327, 'Laval', 'Quebec', 'H3KG5L'),
(38, 905, 'Laval', 'Quebec', 'H8KG7L'),
(39, 876, 'Ottawa', 'Ontario', 'H9KG7L'),
(40, 673, 'Laval', 'Quebec', 'H4KG3L'),
(41, 970, 'Montreal', 'Quebec', 'H3KG8L'),
(42, 943, 'Montreal', 'Quebec', 'H9KG5L'),
(43, 829, 'Ottawa', 'Ontario', 'H7KG4L'),
(44, 349, 'Montreal', 'Quebec', 'H0KG7L'),
(45, 452, 'Montreal', 'Quebec', 'H6KG5L'),
(46, 462, 'Laval', 'Quebec', 'H3K9L4'),
(47, 714, 'Laval', 'Quebec', 'H2K5L1'),
(48, 937, 'Toronto', 'Ontario', 'H2K8L7'),
(49, 118, 'Laval', 'Quebec', 'H1K5L1'),
(50, 253, 'Laval', 'Quebec', 'H1K3L1'),
(51, 424, 'Montreal', 'Quebec', 'H9K9L2'),
(52, 429, 'Toronto', 'Ontario', 'H0K0L2'),
(53, 391, 'Montreal', 'Quebec', 'H5K5L9'),
(54, 216, 'Ottawa', 'Ontario', 'H7K6L9');

INSERT INTO Situated (facilityID, addressID)
VALUES
(1, 46),
(2, 47),
(3, 48),
(4, 49),
(5, 50),
(6, 51),
(7, 52),
(8, 53),
(9, 54);
 
          	INSERT INTO Residence (medicareNumber, addressID)
          	VALUES
          	(5048, 1),
(7633, 2),
(3792, 3),
(3295, 4),
(9508, 5),
(1805, 6),
(6349, 7),
(2068, 8),
(6013, 9),
(9671, 10),
(5721, 11),
(2941, 12),
(6736, 13),
(6185, 14),
(6760, 15),
(3837, 16),
(4997, 17),
(2165, 18),
(6560, 19),
(6661, 20),
(4874, 21),
(4233, 22),
(2506, 23),
(2515, 24),
(4628, 25),
(9388, 26),
(6706, 27),
(9830, 28),
(1799, 29),
(3667, 30),
(9801, 31),
(1132, 32),
(1556, 33),
(5728, 34),
(3682, 35),
(5860, 36),
(6640, 37),
(8456, 38),
(8179, 39),
(1947, 40),
(9620, 41),
(5400, 42),
(6011, 43),
(8280, 44),
(5905, 45);
  
INSERT INTO Contract (employeeID, facilityID, startDate, endDate, role)
VALUES
(1001, 1, '2023-01-01', '2023-03-01', 'Teacher'),
(1001, 2, '2023-01-03', NULL, 'Teacher'),
(1002, 2, '2023-01-01', '2023-03-01', 'Teacher'),
(1002, 3, '2023-03-02', NULL, 'Teacher'),
(1003, 3, '2023-01-03', NULL, 'Teacher'),
(1004, 4, '2023-01-01', '2023-03-01', 'President'),
(1005, 5, '2023-01-01', '2023-03-01', 'President'),
(1006, 6, '2023-01-01', '2023-03-01', 'President'),
(1007, 7, '2023-01-01', '2023-03-01', 'President'),
(1008, 8, '2023-01-01', '2023-03-01', 'President'),
(1009, 9, '2023-01-01', '2023-03-01', 'President'),
(1010, 1, '2023-01-01', '2023-03-01', 'Principal'),
(1011, 2, '2023-01-01', '2023-03-01', 'Principal'),
(1012, 3, '2023-01-01', '2023-03-01', 'Principal'),
(1013, 4, '2023-01-01', NULL, 'Secretary'),
(1014, 4, '2023-01-02', '2023-03-01', 'Secretary'),
(1015, 5, '2023-01-03', '2023-03-01', 'Secretary'),
(1016, 5, '2023-01-04', '2023-03-01', 'Secretary'),
(1017, 6, '2023-01-05', NULL, 'Secretary'),
(1018, 7, '2023-01-01', NULL, 'Secretary'),
(1019, 8, '2023-01-02', NULL, 'Secretary'),
(1020, 9, '2023-01-03', '2023-03-01', 'Secretary'),
(1021, 4, '2023-01-01', '2023-03-01', 'Security'),
(1022, 5, '2023-01-02', '2023-03-01', 'Security'),
(1023, 6, '2023-01-03', '2023-03-01', 'Security'),
(1024, 7, '2023-01-04', '2023-03-01', 'Security'),
(1025, 8, '2023-01-05', '2023-03-01', 'Security'),
(1026, 9, '2023-01-06', '2023-03-01', 'Security'),
(1027, 9, '2023-01-01', '2023-03-01', 'other'),
(1028, 9, '2023-01-02', '2023-03-01', 'other');
 
 INSERT INTO Schedule (employeeID, scheduleDate, startTime, endTime )
  VALUES
(1013,'2023-08-11','13:00:00','15:00:00'),
  (1013,'2023-08-11','10:00:00','12:00:00'),
 (1017,'2023-08-20','8:00:00','11:00:00'),
  (1002, '2023-08-10', '11:00:00','13:00:00'),
  (1002, '2023-08-13','08:00:00','09:00:00'),
  (1002, '2023-08-14','11:00:00','13:00:00');

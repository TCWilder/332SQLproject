DROP DATABASE IF EXISTS docOffice;
CREATE DATABASE docOffice;

create table Person
(
	PersonID int(10) UNIQUE NOT NULL,
    FirstName varchar(20),
    LastName varchar(20),
    StreetAddress varchar(30),
    City varchar(20),
    State varchar(20),
    Zip int(5),
    PhoneNumber varchar(12),
    SSN int(9) UNIQUE NOT NULL,
	PRIMARY KEY (SSN),
	KEY (PersonID)
);

create table Patient
(
	PatientID int(10) UNIQUE NOT NULL,
	PersonID int(10) UNIQUE NOT NULL,
    PatientPhoneNumber varchar(12),
    DOB varchar(10),
	PRIMARY KEY (PatientID),
    foreign key(PersonID) references Person(PersonID) on delete cascade
);

create table Doctor
(
	DoctorID varchar(20)UNIQUE NOT NULL,
	PersonID int(10) UNIQUE NOT NULL,
    MedicalDegrees varchar(100),
	PRIMARY KEY (DoctorID),
    foreign key(PersonID) references Person(PersonID) on delete cascade
);

create table Specialty
(
	SpecialtyID int(10)UNIQUE NOT NULL,
    SpecialtyName varchar(30),
	PRIMARY KEY (SpecialtyID)
);

create table DoctorSpecialty
(
	DoctorID varchar(20)UNIQUE NOT NULL,
	SpecialtyID int(10)NOT NULL,
	foreign key(DoctorID) references Doctor(DoctorID) on delete cascade,
    foreign key(SpecialtyID) references Specialty(SpecialtyID) on delete cascade
);

create table PatientVisit
(
	VisitID int(10)UNIQUE NOT NULL,
	PatientID int(10)NOT NULL,
	DoctorID varchar(20)NOT NULL,
	VisitDate date,
    DocNote varchar(1000),
    PRIMARY KEY(VisitID),
    foreign key(PatientID) references Patient(PatientID),
    foreign key(DoctorID) references Doctor(DoctorID)
);

create table Prescription
(
	PrescriptionName varchar(30),
	PrescriptionID int(10)UNIQUE NOT NULL,
	PRIMARY KEY(PrescriptionID)
);

create table PVisitPrescription
(
	VisitID int(10)UNIQUE NOT NULL,
    PrescriptionID int(10),
	PRIMARY KEY (VisitID),
	FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
	foreign key(VisitID) references PatientVisit(VisitID)
);

create table Test
(
	TestName varchar(50),
	TestID int(10)UNIQUE NOT NULL,
    PRIMARY KEY (TestID)
);

create table PVisitTest
(
	TestID int(10)NOT NULL,
	VisitID int(10)UNIQUE NOT NULL,
    foreign key(VisitID) references PatientVisit(VisitID),
	foreign key(TestID) references Test(TestID)
);

INSERT INTO Person (PersonID, FirstName, LastName, StreetAddress, City, State, Zip, PhoneNumber, SSN) VALUES
	(12345, 'Rob', 'Belkin', '12345 Road', 'Fullerton', 'CA', 12345, '111-222-3333', 123456789),
	(22222, 'Jane', 'Doe', '22 West St.', 'Anaheim', 'CA', 22222, '222-333-4444', 987654321),
	(54321, 'Steve', 'Rogers', '654 Grand Ave.', 'Glendora', 'CA', 91324, '123-121-1234', 123987654),
	(33333, 'Tom', 'Clark', '333 Blvd.', 'Chino Hills', 'CA', 33333, '333-444-5555', 333224444),
	(44444, 'Bijan', 'Kavoosi', '4444 Town Ln.', 'Fullerton', 'CA', 12354, '444-555-6565', 444223333),
	(55555, 'Heidar', 'Rahmanian', '55555 Pkwy.', 'Brea', 'CA', 12334, '555-666-7890', 222334444);
	
INSERT INTO Patient (PatientID, PatientPhoneNumber, DOB, PersonID) VALUES
	(10, '333-444-5555', '1-1-1990', 33333),
	(20, '444-555-6565', '2-2-1991', 44444),
	(30, '555-666-7890', '3-3-1992', 55555);
	
INSERT INTO Doctor (DoctorID, MedicalDegrees, PersonID) VALUES
	('BE1000', 'Dentistry', 12345),
	('DO2000', 'Psychology', 22222),
	('RO1234', 'Medicine', 54321);

INSERT INTO Specialty (SpecialtyID, SpecialtyName) VALUES
	(1000, 'Dental Surgery'),
	(2000, 'Therapy'),
	(3000, 'General Practitioner');

INSERT INTO DoctorSpecialty (DoctorID, SpecialtyID) VALUES
	('BE1000', 1000),
	('DO2000', 2000);	

INSERT INTO Prescription (PrescriptionName, PrescriptionID) VALUES
	('Alcohol', 1),
	('Asprin', 2),
	('Panadol', 3);

INSERT INTO PatientVisit (VisitID, PatientID, DoctorID, VisitDate, DocNote) VALUES
	(1010, 10, 'BE1000', '20190101', 'Nothing Wrong; General Stress'),
	(2020, 20, 'DO2000', '20190202', 'General Visitation'),
	(3030, 30, 'BE1000', '20191208', 'Perscribed Panadol');
	
INSERT INTO Test (TestName, TestID) VALUES
	('Complete Blood Count', 1),
	('Urinalysis', 2),
	('Blood Pressure', 3);
	
INSERT INTO PVisitTest (VisitID, TestID) VALUES
	(1010, 3),
	(3030, 1);
	
INSERT INTO PVisitPrescription(VisitID, PrescriptionID) VALUES
	(1010, 3),
	(2020, NULL),
	(3030, 3);
	
DROP TABLE IF EXISTS AutidTrig;
CREATE TABLE IF NOT EXISTS AuditTrig(DocFirstName varchar(20), InsUp varchar(10), specialtyu varchar(20), DateMod date);

DROP TRIGGER IF EXISTS docoffice.AuditI;
CREATE TRIGGER docoffice.AuditI 
AFTER INSERT ON docoffice.doctorspecialty FOR EACH ROW
INSERT INTO AuditTrig(DocFirstName, InsUp, specialtyu, DateMod) VALUES
((SELECT FirstName FROM doctorspecialty JOIN doctor USING (doctorID) JOIN person USING (PersonID)), 'INSERT', (SELECT specialtyName FROM specialty JOIN doctorspecialty USING (SpecialtyId)), CURRENT_TIMESTAMP);

DROP TRIGGER IF EXISTS docoffice.AuditU;
CREATE TRIGGER docoffice.AuditU 
AFTER UPDATE ON docoffice.doctorspecialty FOR EACH ROW
INSERT INTO AuditTrig(DocFirstName, InsUp, specialtyu, DateMod) VALUES
((SELECT FirstName FROM doctorspecialty JOIN doctor USING (doctorID) JOIN person using (PersonId)), 'UPDATE', (SELECT specialtyName FROM specialty JOIN doctorspecialty USING (SpecialtyId)), CURRENT_TIMESTAMP);
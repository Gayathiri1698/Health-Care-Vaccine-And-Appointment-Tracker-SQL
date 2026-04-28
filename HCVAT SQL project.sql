create database hcvat;
use hcvat;

-- 1. PATIENT PROFILE TABLE (The Master Table)
CREATE TABLE Patient_Profile (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Full_Name VARCHAR(50),
    Date_of_Birth DATE,
    Blood_Type VARCHAR(5),
    Primary_Language VARCHAR(20),
    Known_Allergies VARCHAR(100)
);

INSERT INTO Patient_Profile(Patient_ID,Full_Name,Date_Of_Birth,Blood_Type,Primary_Language,Known_Allergies)
 VALUES 
('P-101', 'Alex Johnson', '1992-05-14', 'O+', 'English', 'Penicillin'),
('P-102', 'Sam Rivera', '1985-11-23', 'A-', 'Spanish', 'Latex'),
('P-103', 'Jordan Lee', '2001-08-30', 'B+', 'English', 'None'),
('P-104', 'Maria Chen', '1978-03-12', 'AB+', 'Mandarin', 'Shellfish'),
('P-105', 'David Wilson', '1965-12-05', 'O-', 'English', 'Sulfa Drugs');


-- 2. PRIMARY APPOINTMENT TRACKER
CREATE TABLE Appointment_Tracker (
    Appt_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Patient_ID VARCHAR(10),
    Appt_Date DATE,
    Appt_Time TIME,
    Provider_Clinic VARCHAR(100),
    Purpose VARCHAR(100),
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Profile(Patient_ID)
);

INSERT INTO Appointment_Tracker (Patient_ID, Appt_Date, Appt_Time, Provider_Clinic, Purpose, Status) VALUES 
('P-101', '2026-02-15', '09:00:00', 'City General', 'Wellness Exam', 'Confirmed'),
('P-103', '2026-02-20', '10:30:00', 'Vision Center', 'Eye Exam', 'Scheduled'),
('P-104', '2026-02-25', '14:00:00', 'City Cardiology', 'Heart Check-up', 'Confirmed'),
('P-102', '2026-03-10', '11:30:00', 'Sunrise Dental', 'Cleaning', 'Pending'),
('P-105', '2026-03-05', '08:45:00', 'Ortho Clinic', 'Knee Consultation', 'Scheduled');


-- 3. VACCINE & IMMUNIZATION RECORD
CREATE TABLE Vaccine_Record (
    Vac_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Patient_ID VARCHAR(10),
    Vaccine_Name VARCHAR(50),
    Admin_Date DATE,
    Dose_Number VARCHAR(20),
    Manufacturer VARCHAR(50),
    Lot_Number VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Profile(Patient_ID)
);

INSERT INTO Vaccine_Record (Patient_ID, Vaccine_Name, Admin_Date, Dose_Number, Manufacturer, Lot_Number) VALUES 
('P-101', 'COVID-19 Booster', '2026-01-20', '4', 'Pfizer', 'EW0192'),
('P-101', 'Hepatitis B', '2026-02-01', '1 of 3', 'GSK', 'B2245XP'),
('P-103', 'HPV Vaccine', '2026-01-15', '2 of 2', 'Merck', 'MRK882'),
('P-104', 'Tetanus (Tdap)', '2026-02-10', 'Booster', 'Sanofi', 'SNF001'),
('P-105', 'Shingles', '2025-11-12', '1 of 2', 'GSK', 'GSK993');


-- 4. POST-VACCINE & HEALTH SYMPTOM LOG
CREATE TABLE Symptom_Log (
    Log_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Patient_ID VARCHAR(10),
    Log_Date DATE,
    Symptom VARCHAR(100),
    Severity_Score INTEGER, -- Scale 1-10
    Duration VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Profile(Patient_ID)
);

INSERT INTO Symptom_Log (Patient_ID, Log_Date, Symptom, Severity_Score, Duration, Notes) VALUES 
('P-101', '2026-01-20', 'Sore arm, fatigue', 3, '24 Hours', 'Took Ibuprofen'),
('P-104', '2026-02-10', 'Mild Fever', 2, '12 Hours', 'Rested at home'),
('P-105', '2025-11-12', 'Injection site redness', 1, '48 Hours', 'No medication'),
('P-101', '2026-02-15', 'High Blood Pressure', 4, 'Chronic', 'Monitor sodium intake');


-- 5. HEALTH EXPENSES & INSURANCE TRACKER
CREATE TABLE Expense_Tracker (
    Bill_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Patient_ID VARCHAR(10),
    Service_Provider VARCHAR(100),
    Total_Cost DECIMAL(10, 2),
    Insurance_Paid DECIMAL(10, 2),
    Personal_Balance DECIMAL(10, 2),
    Payment_Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Profile(Patient_ID)
);

INSERT INTO Expense_Tracker (Patient_ID, Service_Provider, Total_Cost, Insurance_Paid, Personal_Balance, Payment_Status) VALUES 
('P-101', 'City General', 250.00, 200.00, 50.00, 'Paid'),
('P-103', 'Vision Center', 150.00, 100.00, 50.00, 'Paid'),
('P-104', 'City Cardiology', 450.00, 350.00, 100.00, 'Invoiced'),
('P-102', 'Sunrise Dental', 180.00, 150.00, 30.00, 'Pending');

select * from Patient_Profile;
select * from appointment_tracker;
select * from vaccine_record;
select * from symptom_log;
select * from expense_tracker;


-- 1.​List the Full Names of all patients who have O+ or O- blood types.

select Full_Name from Patient_Profile where Blood_Type="O+" or Blood_Type="O-";


-- ​2.Which patient (ID only) is allergic to Latex?

select Patient_ID from Patient_Profile where Known_Allergies='Latex';

--  3.Find all appointments that are currently marked as 'Pending'.

select * from Appointment_Tracker where Status='Pending';

-- 4.List all vaccines manufactured by 'GSK'.

select * from Vaccine_Record where Manufacturer="GSK";

-- 5.What was the Total Cost for the appointment at 'City Cardiology'?

select Total_Cost from Expense_Tracker where Service_Provider="City Cardiology";

-- 6.Find the Date of Birth for patient P-103.

select Date_Of_Birth from Patient_Profile where Patient_ID="P-103";

--  7.List the Symptom and Severity for all logs where severity is 3 or higher.

select Symptom ,Severity_Score from Symptom_Log where Severity_Score>=3;

--  8.Which patients (IDs) have a primary language other than English?

select Patient_ID from Patient_Profile where Primary_Language!="English";


-- 9.Find the Lot Number for the Tetanus (Tdap) vaccine.

select Lot_Number from Vaccine_Record where Vaccine_Name='Tetanus (Tdap)';

-- 10.List all unique Service Providers from the Expense Tracker.

select distinct(Service_Provider) from Expense_Tracker;

-- 11.Show the Full Name of the patient who visited the 'Vision Center'.

select p.Full_Name from Patient_Profile p join Expense_Tracker e on 
p.Patient_ID=e.Patient_ID
where Service_Provider="Vision Center";

-- 12​.List the Vaccine Name and Admin Date for Maria Chen.

select v.Vaccine_Name,v.Admin_Date from Patient_Profile p  join Vaccine_Record v on
p.Patient_ID=v.Patient_ID
where Full_Name="Maria Chen";

-- 13.Find the Emergency Contact (or Language) for the patient who had a 'Mild Fever'.

select p.Primary_Language from Patient_Profile p join Symptom_Log s on
p.Patient_ID=s.Patient_ID
where Symptom="Mild Fever";

-- 14.What is the Full Name of the patient who owes a Personal Balance of $100.00?

select p.Full_Name from Patient_Profile p join Expense_Tracker e on
p.Patient_ID=e.Patient_ID
where Personal_Balance="100";

-- 15.List all Symptoms reported by Alex Johnson.

select s.Symptom from Symptom_Log s join Patient_Profile p on
s.Patient_ID=p.Patient_ID 
where Full_Name="Alex Johnson";

-- 16.Show the Clinic Name and Status for Sam Rivera's appointment.

select a.Provider_Clinic ,a.Status from Appointment_Tracker a join Patient_Profile p on
a.Patient_ID=p.Patient_id
where Full_Name="Sam Rivera";

-- 17.Find the Full Name of the patient who received the 'Shingles' vaccine.

select p.Full_Name from Patient_Profile p join Vaccine_Record v on
p.Patient_ID=v.Patient_ID
where Vaccine_Name="Shingles";

--  18.List the Known Allergies for every patient who has a 'Confirmed' appointment.

select p.Full_Name,p.Known_Allergies From Patient_Profile p join Appointment_Tracker a on
p.Patient_ID=a.Patient_ID
where Status="Confirmed";

-- ​19.Which patient (Full Name) has a 'Chronic' duration listed in their symptom log?

select p.Full_Name from Patient_Profile p join Symptom_Log s on
p.Patient_ID=s.Patient_ID
where Duration="Chronic";

-- 20.Show the Insurance Paid amount for Jordan Lee’s eye exam.

select e.Insurance_Paid from Expense_Tracker e join Patient_Profile p on 
e.Patient_ID=p.Patient_ID
where Full_Name="Jordan Lee";

-- 21.List the names of all patients born before 1986.

select Full_Name,Date_Of_Birth from Patient_Profile 
where Date_Of_Birth< "1986-01-01";

 -- -22. Calculate the total Personal Balance owed by all patients combined. 
 
select sum(Personal_Balance) as Total_Balance from Expense_Tracker ;
 
 -- ​23.Does any patient with a Penicillin allergy have a vaccine recorded?
 
 select p.Full_Name ,v.Vaccine_Name from Patient_Profile p join Vaccine_Record v on
 p.Patient_ID=v.Patient_ID
 where Known_Allergies="Penicillin";
 
 -- ​ 24.Find the Provider and Purpose of the appointment that led to a Severity 4 symptom. 
 
 select a.Provider_Clinic,a.Purpose from Appointment_Tracker a join Symptom_Log s on
a.Patient_ID=s.Patient_ID
where Severity_Score="4";

 -- ​25.​ How many different vaccines in your table were made by Pfizer.?
 
 select Vaccine_Name from Vaccine_Record where Manufacturer='Pfizer';
 
 -- ​26.Which patient (Full Name) had the lowest percentage of their bill covered by insurance?

select p.Full_Name ,(e.Insurance_Paid/e.Total_Cost)*100 as Coverage_Percent 
from Patient_Profile p join Expense_Tracker e on
P.Patient_ID=e.Patient_ID
order by Coverage_Percent Asc Limit 1;

 -- ​27.​List any patient who has a vaccine marked as '1 of 2' or '1 of 3'.
 
 select p.Full_Name,v.Dose_Number from Patient_Profile p join Vaccine_Record v on
 P.Patient_ID=v.Patient_ID
 where Dose_Number="1 of 2"
 or
 Dose_Number="1 of 3";
 
 -- ​28.​Which Patient ID has more than one entry in the Symptom Log?

 select Patient_ID,count(*) as Entry_Count from Symptom_Log
 group by Patient_ID
 having count(*)>1;
 
 -- ​ ​​29.List the Full Names of patients whose payment status is 'Invoiced'.
 
select p.Full_Name,e.Payment_Status from Patient_Profile p join Expense_Tracker e on
p.Patient_ID=e.Patient_ID
where Payment_Status="Invoiced";

 -- ​30.Create a report showing Name, Vaccine Name, and Severity Score for everyone who had a reaction.

select p.Full_Name,v.Vaccine_Name,s.Severity_Score  from Patient_Profile p join Vaccine_Record v on
p.Patient_ID=v.Patient_ID
join Symptom_Log s  on
v.Patient_ID=s.Patient_ID;

-- 31.Find the Full Name and Primary Language of patients who had a Confirmed appointment but had to pay a Personal Balance of more than $50.00.

select p.Full_Name, p.Primary_Language, SUM(e.Personal_Balance) as Total_Amount from Patient_Profile p join Appointment_Tracker a on
 p.Patient_ID = a.Patient_ID
join Expense_Tracker e on 
p.Patient_ID = e.Patient_ID
where a.Status = 'Confirmed'
group by p.Full_Name, p.Primary_Language
having Total_Amount > 50
order by Total_Amount desc;

--  32.List the Full Name, Allergies, Vaccine Name, and Total Cost for any patient who had a "High Severity" reaction (Severity Score > 3).

select p.Full_Name, p.Known_Allergies, v.Vaccine_Name, e.Total_Cost
from Patient_Profile p
join Vaccine_Record v on p.Patient_ID = v.Patient_ID
join Symptom_Log s on p.Patient_ID = s.Patient_ID
join Expense_Tracker e on p.Patient_ID = e.Patient_ID
where s.Severity_Score > 3
order by e.Total_Cost desc;

-- 33.Create a single row for 'Alex Johnson' that shows his Blood Type, his next Appt_Date, his most recent Vaccine_Name, his worst Symptom, and his total Personal_Balance.

select p.Full_Name, p.Blood_Type, MIN(a.Appt_Date) AS Next_Appointment, MAX(s.Severity_Score) AS Worst_Reaction,SUM(e.Personal_Balance) AS Total_Balance_Due
from Patient_Profile p left join Appointment_Tracker a on 
p.Patient_ID = a.Patient_ID
left join Symptom_Log s on 
p.Patient_ID = s.Patient_ID
left join Expense_Tracker e on
p.Patient_ID = e.Patient_ID
where p.Full_Name = 'Alex Johnson'
group by p.Full_Name, p.Blood_Type;
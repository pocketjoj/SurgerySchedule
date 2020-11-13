-- This database will simulate a surgery schedule for a one week period in which up to 161 surgeries are to be scheduled.
-- Some of the requirements are done within the "auto-scheduler", and those line numbers are noted in the requirements comments at the end.
-- Requirement comments start on line 760.

CREATE DATABASE SurgerySchedule;
GO

Use SurgerySchedule;

-- REQ: Relational database has 7 tables, and five have over 4 columns. All
-- tables related to at least one other table with Foreign/Primary Keys.

-- REQ: Several tables have many-to-many relationships (e.g. ToBeScheduled with
-- Patients and Procedures); several table also have One-to-Many relationships
-- (e.g. Surgeons to SurgeonSchedule - one Surgeon to many available dates).

-- REQ: DateTime, int and varchar data types used many times throughout tables.

CREATE TABLE Patients (
  ID int PRIMARY KEY,
  [Name] varchar(50),
  Age int,
  PhoneNumber varchar(13),
  Gender varchar(1)
);

CREATE TABLE Surgeons (
  ID int PRIMARY KEY,
  [Name] varchar(50),
  Specialty varchar(20)
);

CREATE TABLE Hospitals (
  ID int PRIMARY KEY,
  [Name] varchar(50),
);

CREATE TABLE Procedures (
  ID int PRIMARY KEY,
  [Name] varchar(100),
  Specialty varchar (20),
  ProcTime Time (0),
  Implants varchar(1)
);

CREATE TABLE SurgeonSchedule (
  SurgeonID int FOREIGN KEY REFERENCES Surgeons(ID),
  StartTime DateTime,
  LastProcedureBy DateTime,
  WeekDay varchar(10),
  HospitalID int FOREIGN KEY REFERENCES Hospitals(ID)
  CONSTRAINT SurgeonLocationByDay PRIMARY KEY (SurgeonID, HospitalID, StartTime)
);

CREATE TABLE SurgerySchedule (
  ID int IDENTITY(1,1) PRIMARY KEY,
  PatientID int FOREIGN KEY REFERENCES Patients(ID) not null,
  SurgeonID int FOREIGN KEY REFERENCES Surgeons(ID) not null,
  ProcedureID int FOREIGN KEY REFERENCES Procedures(ID),
  HospitalID int FOREIGN KEY REFERENCES Hospitals(ID),
  SurgeryTime DateTime
);

CREATE TABLE ToBeScheduled (
  PatientID int FOREIGN KEY REFERENCES Patients(ID),
  ProcedureID int FOREIGN KEY REFERENCES Procedures(ID),
  Scheduled varchar(1),
  SurgeryID int FOREIGN KEY REFERENCES SurgerySchedule(ID)
);

GO

-- INSERT scripts to populate data (through line 465)

--Insert patient data from mockaroo (through line 220)
INSERT INTO Patients
VALUES
(1, 'Devin Lissimore', 46, '502-585-3296', 'M'),
(2, 'Anselm Warfield', 90, '502-973-6210', 'M'),
(3, 'Aharon Kretchmer', 59, '502-676-6877', 'M'),
(4, 'Chadd Gullick', 28, '502-634-3296', 'M'),
(5, 'Howard Laming', 37, '502-669-9586', 'M'),
(6, 'Goran Goodenough', 41, '502-407-4503', 'M'),
(7, 'Kattie Forri', 45, '502-222-4533', 'F'),
(8, 'Starr Calf', 42, '502-943-7113', 'F'),
(9, 'Callida Ciobutaru', 55, '502-114-7296', 'F'),
(10, 'Tiebold Machen', 43, '502-412-2094', 'M'),
(11, 'Prentiss Vernay', 60, '502-683-6708', 'M'),
(12, 'Deva Oxlade', 27, '502-509-5473', 'F'),
(13, 'Dael Stendell', 82, '502-271-6385', 'M'),
(14, 'Hubey Connelly', 31, '502-756-7732', 'M'),
(15, 'Nanine Josskowitz', 24, '502-198-9200', 'F'),
(16, 'Ethelind Quinet', 90, '502-836-3143', 'F'),
(17, 'Julie Kuna', 66, '502-464-6775', 'F'),
(18, 'Shoshana Soans', 33, '502-530-1202', 'F'),
(19, 'Mabelle Kepling', 27, '502-688-3699', 'F'),
(20, 'Cilka Hollebon', 74, '502-976-4676', 'F'),
(21, 'Symon Jelly', 22, '502-756-1915', 'M'),
(22, 'Julina Caldaro', 36, '864-100-7283', 'F'),
(23, 'Haskell Lerwill', 89, '864-745-7027', 'M'),
(24, 'Sigismund Dmitrovic', 60, '502-847-5097', 'M'),
(25, 'Roger Byrd', 40, '864-165-6968', 'M'),
(26, 'Ladonna Farreil', 44, '864-484-9120', 'F'),
(27, 'Gilligan Stiggles', 81, '303-548-8980', 'F'),
(28, 'Sal Matyugin', 75, '502-608-5225', 'M'),
(29, 'Cheri Hancorn', 35, '502-899-1572', 'F'),
(30, 'Arvy Crofthwaite', 67, '502-296-6800', 'M'),
(31, 'Evangelina Ferreira', 72, '502-803-6835', 'F'),
(32, 'Tansy Wardhough', 33, '864-439-1455', 'F'),
(33, 'Hayden Godley', 66, '864-841-0746', 'M'),
(34, 'Tamra Bull', 87, '864-933-5148', 'F'),
(35, 'Dalton Yeo', 59, '864-799-5039', 'M'),
(36, 'Consalve Obin', 33, '864-596-9811', 'M'),
(37, 'Sancho Oldfield', 30, '864-463-0446', 'M'),
(38, 'Sallyanne Coche', 73, '864-995-1676', 'F'),
(39, 'Chester Cattlemull', 62, '502-334-4748', 'M'),
(40, 'Claudian Goodridge', 18, '502-109-4684', 'M'),
(41, 'Lauryn Bellino', 23, '502-241-0972', 'F'),
(42, 'Bondy Byforth', 50, '502-935-3785', 'M'),
(43, 'Jerad Stawell', 57, '237-874-9747', 'M'),
(44, 'Bambie Basham', 89, '817-763-5826', 'F'),
(45, 'Cecile Awton', 79, '330-633-9822', 'F'),
(46, 'Shana Vedeniktov', 75, '502-949-3168', 'F'),
(47, 'Gerianne Leathley', 80, '864-106-6889', 'F'),
(48, 'Maynard McNeachtain', 82, '502-523-6576', 'M'),
(49, 'Jaynell Fishbourn', 55, '502-284-2429', 'F'),
(50, 'Greg Rozea', 62, '502-589-3202', 'M'),
(51, 'Maribel Figura', 57, '502-358-6549', 'F'),
(52, 'Matthaeus Jancik', 46, '502-511-2735', 'M'),
(53, 'Bondy Ravenscroftt', 63, '502-139-8824', 'M'),
(54, 'Pauletta Hindenburg', 53, '502-936-7491', 'F'),
(55, 'Nilson Wann', 83, '864-804-2741', 'M'),
(56, 'Ruperto Rhodef', 53, '817-852-8483', 'M'),
(57, 'Far Sigfrid', 46, '864-642-0932', 'M'),
(58, 'Coralyn Gash', 66, '502-920-4584', 'F'),
(59, 'Amitie Scotsbrook', 27, '502-963-2116', 'F'),
(60, 'Burty Escot', 62, '502-247-6250', 'M'),
(61, 'Isidora McAlinden', 33, '502-880-9283', 'F'),
(62, 'Dela Blacksell', 63, '502-928-2046', 'F'),
(63, 'Cherry Granger', 22, '864-416-1034', 'F'),
(64, 'Ivette Sircomb', 66, '864-908-5141', 'F'),
(65, 'Chastity Simmonds', 18, '864-843-3051', 'F'),
(66, 'Cris Berfoot', 80, '502-874-1456', 'F'),
(67, 'Lorena Este', 42, '864-408-1615', 'F'),
(68, 'Shanda Garnsey', 88, '502-524-0301', 'F'),
(69, 'Bentlee Stokes', 44, '502-410-1207', 'M'),
(70, 'Riki Peare', 21, '502-809-8523', 'F'),
(71, 'Vinson Houlison', 79, '502-226-3395', 'M'),
(72, 'Marika Burnsyde', 48, '694-793-0933', 'F'),
(73, 'Karoline Trim', 52, '502-725-1040', 'F'),
(74, 'Holly-anne Idiens', 23, '864-592-5617', 'F'),
(75, 'Robby Stopps', 22, '502-444-9065', 'M'),
(76, 'Harman Grigore', 67, '502-417-2552', 'M'),
(77, 'Drake Jurgensen', 44, '502-651-7010', 'M'),
(78, 'Horst Ower', 39, '502-431-8505', 'M'),
(79, 'Philipa Tiebe', 60, '502-292-5779', 'F'),
(80, 'Polly Lytle', 83, '502-964-8853', 'F'),
(81, 'Regine Beedham', 45, '502-670-7759', 'F'),
(82, 'Allis Humbert', 25, '502-416-7594', 'F'),
(83, 'Atlante Korlat', 32, '502-487-1700', 'F'),
(84, 'Lothario Gullefant', 18, '502-823-5344', 'M'),
(85, 'Burgess Blakebrough', 55, '502-756-3950', 'M'),
(86, 'Zabrina Rusbridge', 27, '864-434-9999', 'F'),
(87, 'Monti Milley', 51, '586-351-0701', 'M'),
(88, 'Rasia Tiltman', 39, '502-846-9238', 'F'),
(89, 'Rosaline Kynvin', 87, '502-852-4633', 'F'),
(90, 'Chery Shewan', 37, '502-375-4958', 'F'),
(91, 'Letta Prisley', 46, '502-167-6442', 'F'),
(92, 'Idaline Kennaway', 52, '864-804-3647', 'F'),
(93, 'Robina Barthrop', 59, '502-247-6222', 'F'),
(94, 'Andra Beare', 43, '864-196-9828', 'F'),
(95, 'Galvin Roscow', 86, '502-600-6321', 'M'),
(96, 'Clayson Webster', 49, '502-746-1667', 'M'),
(97, 'Arlina Ainsworth', 43, '502-641-7824', 'F'),
(98, 'Chicky Murrock', 79, '502-983-6286', 'F'),
(99, 'Faydra Rickasse', 33, '502-140-7891', 'F'),
(100, 'Nial Metzig', 47, '502-582-3548', 'M'),
(101, 'Arty Teare', 60, '502-409-4628', 'M'),
(102, 'Hammad Barter', 44, '864-698-7820', 'M'),
(103, 'Lorettalorna Pragnall', 23, '864-272-7674', 'F'),
(104, 'Vince Blanko', 20, '502-246-6195', 'M'),
(105, 'Briano Rogge', 63, '502-654-6851', 'M'),
(106, 'Abagael Bawcock', 66, '502-248-7297', 'F'),
(107, 'Baldwin Whittier', 89, '502-210-0202', 'M'),
(108, 'Dianne Clausson', 50, '502-488-5034', 'F'),
(109, 'Artemus Steventon', 66, '502-295-2313', 'M'),
(110, 'Rip Lamboll', 79, '302-922-4544', 'M'),
(111, 'Colby Traviss', 84, '502-754-2627', 'M'),
(112, 'Wright Loud', 23, '502-986-2505', 'M'),
(113, 'Murvyn Sheering', 40, '502-510-3997', 'M'),
(114, 'Pall Comberbach', 27, '502-156-4637', 'M'),
(115, 'Ardith Saggs', 59, '504-412-3871', 'F'),
(116, 'Olenolin Kamenar', 31, '502-796-6761', 'M'),
(117, 'Fawn Gabbitas', 39, '502-182-7162', 'F'),
(118, 'Talbot Willcott', 66, '502-670-6212', 'M'),
(119, 'Willem Amott', 77, '502-465-1339', 'M'),
(120, 'Staci Deans', 86, '502-476-3513', 'F'),
(121, 'Kort Flewan', 62, '502-752-5568', 'M'),
(122, 'Coraline McGinn', 41, '502-675-9391', 'F'),
(123, 'Debera Furnell', 72, '502-921-5072', 'F'),
(124, 'Patton Bridgen', 50, '502-157-2571', 'M'),
(125, 'Malissa Bachman', 39, '502-454-0061', 'F'),
(126, 'Carrissa Pavlov', 49, '502-154-2871', 'F'),
(127, 'Pierrette Toner', 62, '502-987-8997', 'F'),
(128, 'Vick Klasing', 29, '864-826-7175', 'M'),
(129, 'Rubia Widmore', 54, '330-249-8279', 'F'),
(130, 'Lorita Quinnette', 29, '502-373-4232', 'F'),
(131, 'Valerie Berka', 72, '502-850-4823', 'F'),
(132, 'Wilhelmina Toohey', 31, '502-519-9086', 'F'),
(133, 'Kendal Gilberthorpe', 81, '502-915-8795', 'M'),
(134, 'Jourdan Hadny', 19, '608-536-5125', 'F'),
(135, 'Gabbie Chalder', 48, '502-743-2567', 'M'),
(136, 'Cirilo Matchell', 46, '502-226-1483', 'M'),
(137, 'Godart MacGilrewy', 83, '502-261-2336', 'M'),
(138, 'Madella Ferreira', 74, '502-932-0249', 'F'),
(139, 'Levy Flemmich', 38, '502-768-7265', 'M'),
(140, 'Sigvard Passler', 79, '502-145-4256', 'M'),
(141, 'Bartolemo Dacey', 75, '688-762-3651', 'M'),
(142, 'Whitman Barstowk', 75, '864-225-3967', 'M'),
(143, 'Geno Pretorius', 85, '502-144-6308', 'M');

INSERT INTO Surgeons
VALUES
(1, 'Peter Malkani', 'Ortho'),
(2, 'Jennifer Ramsey', 'Ortho'),
(3, 'William Tillett', 'Ortho'),
(4, 'Benjamin Faulkner', 'Ortho'),
(5, 'Amy Peterson', 'Spine'),
(6, 'Quincy Jennings', 'Spine'),
(7, 'Suzette Quillo', 'Spine');

INSERT INTO Hospitals
VALUES
(1, 'Jewish Hospital'),
(2, 'University of Louisville Hospital'),
(3, 'Medical Center East'),
(4, 'Norton Audubon Hospital');

INSERT INTO Procedures
VALUES
(1, 'Anterior Lumbar Interbody Fusion', 'Spine', '06:00:00', 'Y'),
(2, 'Anterior Cervical Discectomy and Fusion', 'Spine', '04:00:00', 'Y'),
(3, 'Anterior Cervical Corpectomy', 'Spine', '05:00:00', 'Y'),
(4, 'Intradiscal Electrothermal Therapy', 'Spine', '03:00:00', 'N'),
(5, 'Kyphoplasty', 'Spine', '03:00:00', 'N'),
(6, 'Laminectomy', 'Spine', '03:00:00', 'N'),
(7, 'Lumbar Disc Microsurgery', 'Spine', '04:00:00', 'N'),
(8, 'Micro Endoscopic Discectomy', 'Spine', '03:00:00', 'N'),
(9, 'Spinal Cord Stimulator Implant', 'Spine', '04:00:00', 'Y'),
(10, 'Spinal Fusion', 'Spine', '06:00:00', 'Y'),
(11, 'Total Disc Replacement', 'Spine', '06:00:00', 'Y'),
(12, 'Vertebroplasty', 'Spine', '04:00:00', 'N'),
(13, 'Total Knee Replacement', 'Ortho', '03:00:00', 'Y'),
(14, 'Total Hip Replacement', 'Ortho', '05:00:00', 'Y'),
(15, 'Total Shoulder Replacement', 'Ortho', '04:00:00', 'Y'),
(16, 'Wrist Arthroscopy', 'Ortho', '02:00:00', 'N'),
(17, 'Knee Arthroscopy', 'Ortho', '02:00:00', 'N'),
(18, 'Shoulder Arthroscopy', 'Ortho', '02:00:00', 'N'),
(19, 'Hip Arthroscopy', 'Ortho', '03:00:00', 'N'),
(20, 'Ankle Open Reduction Internal Fixation', 'Ortho', '04:00:00', 'Y'),
(21, 'Wrist Open Reduction Internal Fixation', 'Ortho', '04:00:00', 'Y'),
(22, 'Hip Open Reduction Internal Fixation', 'Ortho', '06:00:00', 'Y'),
(23, 'Elbow Open Reduction Internal Fixation', 'Ortho', '04:00:00', 'Y'),
(24, 'Femur/Tibial Open Reduction Internal Fixation', 'Ortho', '05:00:00', 'Y');

-- 212 Surgeries to be scheduled (pulling random patient/procedure ID combos
-- from Mockaroo); ends at line 431.

INSERT INTO ToBeScheduled (PatientID, ProcedureID, Scheduled)
VALUES
(51, 5, 'N'),
(138, 20, 'N'),
(41, 24, 'N'),
(30, 17, 'N'),
(107, 19, 'N'),
(7, 14, 'N'),
(140, 14, 'N'),
(67, 3, 'N'),
(1, 3, 'N'),
(122, 23, 'N'),
(66, 18, 'N'),
(129, 4, 'N'),
(94, 3, 'N'),
(142, 20, 'N'),
(97, 24, 'N'),
(89, 3, 'N'),
(70, 13, 'N'),
(130, 9, 'N'),
(35, 15, 'N'),
(85, 15, 'N'),
(5, 24, 'N'),
(2, 9, 'N'),
(9, 24, 'N'),
(82, 7, 'N'),
(77, 20, 'N'),
(22, 18, 'N'),
(15, 12, 'N'),
(37, 13, 'N'),
(102, 20, 'N'),
(25, 13, 'N'),
(32, 18, 'N'),
(24, 18, 'N'),
(68, 20, 'N'),
(3, 24, 'N'),
(111, 14, 'N'),
(83, 17, 'N'),
(128, 15, 'N'),
(47, 21, 'N'),
(137, 8, 'N'),
(19, 11, 'N'),
(120, 15, 'N'),
(50, 2, 'N'),
(69, 6, 'N'),
(4, 17, 'N'),
(100, 23, 'N'),
(141, 5, 'N'),
(115, 21, 'N'),
(23, 22, 'N'),
(46, 16, 'N'),
(44, 14, 'N'),
(36, 2, 'N'),
(83, 19, 'N'),
(39, 5, 'N'),
(132, 2, 'N'),
(108, 19, 'N'),
(17, 16, 'N'),
(21, 24, 'N'),
(52, 4, 'N'),
(28, 19, 'N'),
(13, 24, 'N'),
(90, 15, 'N'),
(107, 20, 'N'),
(43, 20, 'N'),
(63, 18, 'N'),
(12, 10, 'N'),
(11, 23, 'N'),
(91, 11, 'N'),
(135, 12, 'N'),
(114, 8, 'N'),
(140, 17, 'N'),
(38, 13, 'N'),
(88, 11, 'N'),
(44, 17, 'N'),
(137, 16, 'N'),
(75, 15, 'N'),
(117, 14, 'N'),
(72, 24, 'N'),
(86, 16, 'N'),
(29, 4, 'N'),
(131, 1, 'N'),
(12, 9, 'N'),
(118, 5, 'N'),
(42, 11, 'N'),
(60, 7, 'N'),
(119, 14, 'N'),
(93, 4, 'N'),
(76, 13, 'N'),
(24, 18, 'N'),
(46, 23, 'N'),
(6, 21, 'N'),
(27, 16, 'N'),
(109, 1, 'N'),
(8, 5, 'N'),
(87, 23, 'N'),
(133, 10, 'N'),
(59, 19, 'N'),
(123, 22, 'N'),
(57, 10, 'N'),
(134, 11, 'N'),
(95, 16, 'N'),
(73, 14, 'N'),
(65, 12, 'N'),
(124, 8, 'N'),
(64, 18, 'N'),
(28, 14, 'N'),
(112, 12, 'N'),
(141, 11, 'N'),
(40, 21, 'N'),
(78, 20, 'N'),
(121, 22, 'N'),
(126, 23, 'N'),
(101, 21, 'N'),
(18, 5, 'N'),
(58, 24, 'N'),
(55, 16, 'N'),
(31, 6, 'N'),
(34, 7, 'N'),
(74, 11, 'N'),
(125, 10, 'N'),
(27, 4, 'N'),
(113, 6, 'N'),
(136, 14, 'N'),
(143, 8, 'N'),
(45, 5, 'N'),
(84, 10, 'N'),
(10, 9, 'N'),
(136, 1, 'N'),
(62, 20, 'N'),
(52, 18, 'N'),
(53, 14, 'N'),
(127, 2, 'N'),
(106, 15, 'N'),
(98, 19, 'N'),
(49, 8, 'N'),
(33, 16, 'N'),
(96, 7, 'N'),
(16, 6, 'N'),
(69, 6, 'N'),
(14, 24, 'N'),
(48, 14, 'N'),
(130, 19, 'N'),
(93, 24, 'N'),
(54, 10, 'N'),
(92, 2, 'N'),
(26, 4, 'N'),
(56, 18, 'N'),
(103, 8, 'N'),
(110, 9, 'N'),
(13, 24, 'N'),
(81, 21, 'N'),
(139, 7, 'N'),
(116, 2, 'N'),
(71, 24, 'N'),
(79, 11, 'N'),
(104, 13, 'N'),
(80, 17, 'N'),
(61, 3, 'N'),
(20, 14, 'N'),
(105, 5, 'N'),
(99, 4, 'N'),
(100, 12, 'N');

INSERT INTO SurgeonSchedule
VALUES
(1, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 1),
(2, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 2),
(3, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 2),
(4, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 4),
(5, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 3),
(6, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 1),
(7, '2020-12-04 07:00:00', '2020-12-04 15:00:00', 'Monday', 3),
(1, '2020-12-05 09:00:00', '2020-12-05 15:00:00', 'Tuesday', 4),
(2, '2020-12-05 07:00:00', '2020-12-05 15:00:00', 'Tuesday', 3),
(3, '2020-12-05 08:00:00', '2020-12-05 15:00:00', 'Tuesday', 1),
(4, '2020-12-05 09:00:00', '2020-12-05 15:00:00', 'Tuesday', 2),
(5, '2020-12-05 07:00:00', '2020-12-05 15:00:00', 'Tuesday', 1),
(6, '2020-12-05 07:00:00', '2020-12-05 15:00:00', 'Tuesday', 2),
(7, '2020-12-05 07:00:00', '2020-12-05 13:00:00', 'Tuesday', 4),
(1, '2020-12-06 07:00:00', '2020-12-06 15:00:00', 'Wednesday', 3),
(2, '2020-12-06 07:00:00', '2020-12-06 15:00:00', 'Wednesday', 1),
(3, '2020-12-06 07:00:00', '2020-12-06 15:00:00', 'Wednesday', 2),
(5, '2020-12-06 07:00:00', '2020-12-06 15:00:00', 'Wednesday', 4),
(6, '2020-12-06 07:00:00', '2020-12-06 13:00:00', 'Wednesday', 1),
(7, '2020-12-06 07:00:00', '2020-12-06 15:00:00', 'Wednesday', 4),
(1, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 1),
(2, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 3),
(3, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 2),
(4, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 4),
(5, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 3),
(6, '2020-12-07 07:00:00', '2020-12-07 15:00:00', 'Thursday', 2),
(2, '2020-12-08 07:00:00', '2020-12-08 12:00:00', 'Friday', 1),
(3, '2020-12-08 07:00:00', '2020-12-08 12:00:00', 'Friday', 2),
(4, '2020-12-08 07:00:00', '2020-12-08 15:00:00', 'Friday', 4),
(6, '2020-12-08 07:00:00', '2020-12-08 15:00:00', 'Friday', 3),
(7, '2020-12-08 07:00:00', '2020-12-08 15:00:00', 'Friday', 1);

--This statement will populate all first cases; it also sets any patients
-- already scheduled to a status of "P" (pending) on the ToBeScheduled, as a
-- patient should not be in two different first cases.

WHILE (SELECT Count(*) FROM SurgeonSchedule) > (SELECT Count(*) FROM SurgerySchedule)

BEGIN
  DECLARE @Pat as	int = (
  SELECT TOP 1 PatientID
  FROM ToBeScheduled
  WHERE Scheduled = 'N'
  Group BY PatientID
  ORDER BY Count(PatientID) DESC, PatientID
)
  DECLARE @Proc as int = (
    SELECT TOP 1 ProcedureID
    FROM ToBeScheduled
    WHERE Scheduled = 'N' AND PatientID = @Pat
  )
  DECLARE @Surgeon as int
  DECLARE @Hospital as int
  DECLARE @SurgeryTime as DateTime

  IF EXISTS (SELECT PatientID FROM SurgerySchedule WHERE PatientID = @Pat)
  BEGIN
	UPDATE ToBeScheduled
	SET scheduled = 'P'
	WHERE PatientID = @Pat AND ProcedureID = @Proc
  END

  ELSE
  BEGIN

	Select TOP 1 @Surgeon = s.ID, @Hospital = ss.HospitalID, @SurgeryTime = ss.StartTime
	FROM Surgeons s
	JOIN Procedures	p
	ON s.Specialty = p.Specialty
	JOIN SurgeonSchedule ss
	ON s.ID = ss.SurgeonID
	LEFT JOIN SurgerySchedule ssc
	ON ss.StartTime = ssc.SurgeryTime AND s.ID = ssc.SurgeonID
	WHERE p.ID = @Proc AND ssc.SurgeonID is null
	ORDER BY StartTime, s.ID

  BEGIN TRANSACTION
	INSERT INTO SurgerySchedule (PatientID, SurgeonID, ProcedureID, HospitalID, SurgeryTime)
	VALUES
	(@Pat, @Surgeon, @Proc, @Hospital, @SurgeryTime)

-- REQ: DML Statement UPDATES rows with a WHERE clause; the WHERE clause values are variables.
	UPDATE ToBeScheduled
	SET scheduled = 'Y', SurgeryID = (SELECT ID FROM SurgerySchedule WHERE PatientID = @Pat AND ProcedureID = @Proc)
	WHERE PatientID = @Pat AND ProcedureID = @Proc
  COMMIT
  END
END

-- Update to make sure all patients needing more than 1 surgery are marked "P".

Update ToBeScheduled
SET Scheduled = 'P'
From ToBeScheduled t
Join SurgerySchedule ss
ON t.PatientID = ss.PatientID
WHERE t.SurgeryID IS NULL AND t.Scheduled = 'N'

-- Adding ToFollow column to help track if more surgeries can be scheduled after
-- first cases.

ALTER TABLE SurgerySchedule
ADD ToFollow varchar(1) NOT NULL DEFAULT 'N'
GO

-- This Stored Procedure will calculate all possible To-Follow times for
-- surgeries currently on the schedule. If the procedure length does not go past
-- the Surgeon's Last Procedure By time for that date, it will set To-Follow
-- value as 'Y' (Yes).

CREATE PROCEDURE CalcToFollow
AS
DECLARE @Count as int = 0

WHILE (@Count < 1)
BEGIN
	DECLARE @SurgeryID as int = NULL

	SELECT TOP 1 @SurgeryID = ss.ID
	FROM SurgerySchedule ss
	JOIN Procedures p
	ON ss.ProcedureID = p.ID
	JOIN SurgeonSchedule ssc
	ON ss.SurgeonID = ssc.SurgeonID AND DatePart(day, ss.SurgeryTime) = DatePart(day, ssc.StartTime)
	WHERE ssc.LastProcedureBy > (ss.SurgeryTime + CAST(p.ProcTime AS DateTime)) AND ss.ToFollow = 'N'

	IF @SurgeryID IS NULL
	BEGIN
	SET @Count = 1
	END

	ELSE
	BEGIN
	UPDATE SurgerySchedule
	SET ToFollow = 'Y'
	WHERE ID = @SurgeryID
	END
END
GO

Exec CalcToFollow

-- Checks to see if patients with more than one procedure can be scheduled for
-- same room and doctor to do both procedures back to back. Update statement
-- below that sets the newly scheduled procedures as Scheduled with a Surgery ID
-- in the ToBeScheduled tabe.

INSERT INTO SurgerySchedule (PatientID, SurgeonID, ProcedureID, HospitalID,SurgeryTime)
Select ss.PatientID, ss.SurgeonID, tb.ProcedureID, ss.HospitalID, ss.SurgeryTime + CAST(pr.ProcTime AS DateTime) AS 'SurgeryTime'
FROM ToBeScheduled tb
JOIN Procedures p
ON tb.ProcedureID = p.ID
JOIN SurgerySchedule ss
ON tb.PatientID = ss.PatientID
JOIN Surgeons s
ON ss.SurgeonID = s.ID
JOIN SurgeonSchedule sus
ON ss.SurgeonID = sus.SurgeonID AND ss.SurgeryTime = sus.StartTime
JOIN Procedures pr
ON ss.ProcedureID = pr.ID
WHERE tb.Scheduled = 'P' AND p.Specialty = s.Specialty AND ToFollow = 'Y'

GO

Exec CalcToFollow

UPDATE ToBeScheduled
SET SurgeryID = ss.ID, Scheduled = 'Y'
FROM ToBeScheduled tb
JOIN SurgerySchedule ss
ON tb.PatientID = ss.PatientID AND tb.ProcedureID = ss.ProcedureID
WHERE tb.Scheduled = 'P'

GO

-- This will check for any later surgeries so the ToFollow value can be changed
-- to 'S' (scheduled) for any surgeries that have a case already scheduled after
-- their start time (to avoid duplicates).

DECLARE @List TABLE (SurgeryID int)

INSERT INTO @List
SELECT ss2.ID
FROM SurgerySchedule ss
Join SurgerySchedule ss2
ON ss.SurgeonID = ss2.SurgeonID
AND DatePart(Day, ss.SurgeryTime) = DatePart(Day, ss2.SurgeryTime)
AND DatePart(Hour, ss.SurgeryTime) > DatePart(Hour, ss2.SurgeryTime)

UPDATE SurgerySchedule
SET ToFollow = 'S'
FROM SurgerySchedule ss
Join @List l
ON ss.ID = l.SurgeryID

GO

-- WHILE loop to schedule rest of patients based off "ToFollow" column in
-- Surgery Schedule. Once all first cases are scheduled (by patient), the rest
-- can be scheduled based off the schedule itself.

WHILE (SELECT COUNT(*) FROM SurgerySchedule WHERE ToFollow = 'Y') > 0
AND (SELECT COUNT(*) FROM ToBeScheduled WHERE Scheduled = 'N') > 0

BEGIN
  DECLARE @Proc as int
  DECLARE @Pat as int
  DECLARE @Surgeon as int
  DECLARE @Hospital as int
  DECLARE @SurgeryTime as DateTime
  DECLARE @SurgeryID as int
  DECLARE @SurgeryLength as DateTime
  DECLARE @Surgery2Length as DateTime

  SELECT TOP 1 @Surgeon = ss.SurgeonID, @Hospital = ss.HospitalID, @SurgeryTime = ss.SurgeryTime, @SurgeryID = ss.ID, @SurgeryLength = p.ProcTime
  FROM SurgerySchedule ss
  JOIN Procedures p
  ON ss.ProcedureID = p.ID
  WHERE ToFollow = 'Y'
  ORDER BY SurgeryTime

  SELECT TOP 1 @Proc = t.ProcedureID, @Pat = t.PatientID, @Surgery2Length = p.ProcTime
  FROM ToBeScheduled t
  JOIN Procedures p
  ON t.ProcedureID = p.ID
  JOIN Surgeons s
  ON p.Specialty = s.Specialty
  WHERE s.ID = @Surgeon AND t.Scheduled = 'N'
  ORDER BY PatientID

-- Below logic detects duplicates and tries to schedule them where available.
-- With this data set, no duplicates are scheduled for To-Follows
  IF EXISTS (SELECT * FROM SurgerySchedule WHERE PatientID = @Pat)
  BEGIN
    IF EXISTS (SELECT * FROM SurgerySchedule WHERE PatientID = @Pat AND ToFollow ='Y')
    AND ((SELECT Specialty FROM Procedures WHERE ID = @Proc) = (Select Specialty FROM Surgeons WHERE ID = (SELECT SurgeonID FROM SurgerySchedule WHERE PatientID = @Pat)))
    BEGIN
      SELECT @Surgeon = ss.SurgeonID, @Hospital = ss.HospitalID, @SurgeryTime = ss.SurgeryTime, @SurgeryID = ss.ID, @SurgeryLength = pr.Proctime
      FROM SurgerySchedule ss
      JOIN Procedures pr
      ON ss.ProcedureID = pr.ID
      WHERE ss.PatientID = @Pat

      INSERT INTO SurgerySchedule (PatientID, SurgeonID, ProcedureID, HospitalID, SurgeryTime)
      VALUES (@Pat, @Surgeon, @Proc, @Hospital, @SurgeryTime + @SurgeryLength)

      UPDATE SurgerySchedule
      SET ToFollow = 'S'
      WHERE ID = @SurgeryID

      UPDATE ToBeScheduled
      Set Scheduled = 'Y', SurgeryID = (SELECT TOP 1 ID FROM SurgerySchedule ORDER BY ID DESC)
      WHERE ProcedureID = @Proc AND PatientID = @Pat

      IF @SurgeryTime + @SurgeryLength + @Surgery2Length <
      (SELECT LastProcedureBy FROM SurgeonSchedule WHERE SurgeonID = @Surgeon
        AND DatePart(day, LastProcedureBy) = DatePart(day,@SurgeryTime))
      BEGIN
  	   UPDATE SurgerySchedule
  	   SET ToFollow = 'Y'
  	   WHERE ID = (SELECT Count(*) FROM SurgerySchedule)
      END
    END

    ELSE
    BEGIN
      UPDATE ToBeScheduled
      Set Scheduled = 'P'
      WHERE PatientID = @Pat and ProcedureID = @Proc
    END
  END

  ELSE
  BEGIN

    INSERT INTO SurgerySchedule (PatientID, SurgeonID, ProcedureID, HospitalID, SurgeryTime)
    VALUES (@Pat, @Surgeon, @Proc, @Hospital, @SurgeryTime + @SurgeryLength)

    UPDATE SurgerySchedule
    SET ToFollow = 'S'
    WHERE ID = @SurgeryID

    UPDATE ToBeScheduled
    Set Scheduled = 'Y', SurgeryID = (SELECT TOP 1 ID FROM SurgerySchedule ORDER BY ID DESC)
    WHERE ProcedureID = @Proc AND PatientID = @Pat

    IF @SurgeryTime + @SurgeryLength + @Surgery2Length <
    (SELECT LastProcedureBy FROM SurgeonSchedule WHERE SurgeonID = @Surgeon
      AND DatePart(day, LastProcedureBy) = DatePart(day,@SurgeryTime))
    BEGIN
	   UPDATE SurgerySchedule
	   SET ToFollow = 'Y'
	   WHERE ID = (SELECT Count(*) FROM SurgerySchedule)
    END
  END

END

-- Below loop will locate and delete duplicate patients from ToBeScheduled.

DECLARE @Counter int = 1;

WHILE (@Counter > 0)
BEGIN
  DECLARE @Procedure int = NULL;
  DECLARE @Patient int;

  SELECT @Procedure = ProcedureID, @Patient = PatientID
  FROM ToBeScheduled
  GROUP BY ProcedureID, PatientID
  HAVING COUNT(ProcedureID) > 1 AND COUNT(PatientID) > 1

  DELETE TOP (1)
  FROM ToBeScheduled
  WHERE ProcedureID = @Procedure AND PatientID = @Patient

  IF @Procedure IS null
  BEGIN
    SET @counter = 0
  END
END

-- All available days should be scheduled by above, filling out the SurgerySchedule table. Requirements are listed below.


-- Write a SELECT query that uses a WHERE clause
-- Return patients with local phone number.
SELECT [Name]
FROM Patients
WHERE PhoneNumber LIKE '502%'

-- Write a  SELECT query that uses an OR and an AND operator
SELECT p.[Name] as "Patients Needing Additional Attention", SurgeryTime
FROM SurgerySchedule ss
JOIN Patients p
ON ss.PatientID = p.ID
JOIN Procedures pr
ON ss.ProcedureID = pr.ID
WHERE (pr.Implants = 'Y' AND pr.ProcTime > '04:00:00') OR p.Age > 70

-- Write a  SELECT query that filters NULL rows using IS NOT NULL
SELECT p.[Name] AS 'Scheduled'
FROM ToBeScheduled t
JOIN Patients p
ON t.PatientID = p.ID
WHERE SurgeryID is not null
ORDER BY p.[Name]

-- Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable
-- DONE ON LINES 517-519.

-- Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable
-- Removing patient from the ToBeScheduled category by phone number.
DECLARE @Descheduled int = (SELECT ID FROM Patients WHERE PhoneNumber = '848-519-9086')

DELETE FROM ToBeScheduled
WHERE PatientID = @Descheduled

-- Write a  SELECT query that utilizes a JOIN
-- Would produce a phone number for all patients able to be scheduled this week.
SELECT DISTINCT p.[Name], p.PhoneNumber
FROM Patients p
JOIN ToBeScheduled t
ON t.PatientID = p.ID
WHERE t.Scheduled = 'Y'

-- Write a SELECT query that utilizes a JOIN with 3 or more tables
-- Query to select "Printable" Surgery Scheduled
SELECT p.[Name] AS 'Patient', s.[Name] AS 'Surgeon', pr.[Name] AS 'Procedure', h.[Name] AS 'Hospital', ss.SurgeryTime AS 'Surgery Start Time'
FROM SurgerySchedule ss
JOIN Patients p
ON PatientID = p.ID
JOIN Surgeons s
ON SurgeonID = s.ID
JOIN Procedures pr
ON ss.ProcedureID = pr.ID
JOIN Hospitals h
ON ss.HospitalID = h.ID
ORDER BY SurgeryTime, SurgeonID

-- Write a  SELECT query that utilizes a LEFT JOIN
-- DONE ON LINES 500-509

-- Write a  SELECT query that utilizes a variable in the WHERE clause

-- Write a  SELECT query that utilizes a ORDER BY clause

-- Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function
-- Query shows total count of procedures scheduled to be performed.
SELECT p.[Name] as 'Procedure', Count(ss.ProcedureID) as 'Procedure Total'
FROM SurgerySchedule ss
JOIN Procedures p
ON ss.ProcedureID = p.ID
GROUP BY p.[Name]
ORDER BY Count(ProcedureID) DESC

-- Write a SELECT query that utilizes a CALCULATED FIELD
-- DONE ON LINES 553-559

-- Write a SELECT query that utilizes a SUBQUERY
-- Query to show which Surgeon has the most cases.
SELECT [Name]
FROM Surgeons
WHERE SurgeonID = (
  SELECT TOP 1 SurgeonID
  FROM SurgerySchedule
  GROUP BY SurgeonID
  ORDER BY Count(SurgeonID) DESC
)

-- Write a DML statement that DELETEs rows from a table that another table references. This script will have to also DELETE any records that reference these rows. Both of the DELETE statements need to be wrapped in a single TRANSACTION.
-- This delete statement simulates two patients leaving the practice, thus needing to be removed from the Patients roster; however, the ID field is referenced by PatientID in ToBeScheduled, so they must be removed from there first.
DECLARE @Pat1 int = (
  SELECT ID
  FROM patients
  WHERE [Name] = 'Philipa Tiebe'
)
DECLARE @Pat2 int = (
  SELECT ID
  FROM patients
  WHERE [Name] = 'Talbot Willcott'
)

BEGIN TRANSACTION

DELETE FROM ToBeScheduled
WHERE PatientID = @Pat1 OR PatientID = @Pat2

DELETE FROM Patients
WHERE ID = @Pat1 OR ID = @Pat2

COMMIT

-- Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with an aggregate function

-- Write a SELECT query that utilizes a JOIN with 3 or more tables, at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause with an aggregate function, and a HAVING clause
-- Average Age of Male Patients being operated on due to complex Fractures at U of L and Norton Audubon Hospitals
SELECT pr.[Name], Avg(p.Age) AS 'Average Age', Count(pr.[Name]) AS 'Total Surgeries'
FROM SurgerySchedule ss
JOIN Patients p
ON ss.PatientID = p.ID
JOIN Procedures pr
ON ss.ProcedureID = pr.ID
WHERE ((ss.HospitalID = 2) OR (ss.HospitalID = 4)) AND p.Gender = 'M'
GROUP BY pr.[Name]
HAVING pr.[Name] LIKE '%FIXATION%'
ORDER BY 'Total Surgeries'

-- Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries

-- Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries

-- Design a NONCLUSTERED INDEX with AT LEAST ONE KEY COLUMN and AT LEAST ONE INCLUDED COLUMN that improves the performance of one of the above queries

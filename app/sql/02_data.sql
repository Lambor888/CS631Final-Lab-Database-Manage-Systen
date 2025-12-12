-- Lab Members
INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Professor', 'Smith', 'Faculty', '2015-08-01');
INSERT INTO FACULTY (Member_ID, Department) VALUES (1, 'CS');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date) 
VALUES ('Alice', 'Johnson', 'Student', '2022-09-01', 1, '2022-09-01', '2026-05-15');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (2, 'S9001', 'MS', 'CS');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Bob', 'Lee', 'Collaborator', '2023-01-15');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (3, 'NYU', 'Specializes in AI Ethics.');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Dr.', 'Chen', 'Faculty', '2018-01-10');
INSERT INTO FACULTY (Member_ID, Department) VALUES (4, 'CS');

INSERT INTO LAB_MEMBER (First_Name, Middle_Name, Last_Name, Type, Join_Date) 
VALUES ('Jane', 'A', 'Clark', 'Student', '2023-08-20');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (5, 'S9002', 'BS', 'ENG');

INSERT INTO LAB_MEMBER (First_Name, Middle_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date) 
VALUES ('Emily', 'B', 'Davis', 'Student', '2023-08-20', 4, '2023-08-20', '2025-08-20');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (6, 'S9003', 'BS', 'BIO');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Oliver', 'Walker', 'Student', '2023-08-22');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (7, 'S9004', 'MS', 'ME');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Professor', 'Harris', 'Faculty', '2001-04-24');
INSERT INTO FACULTY (Member_ID, Department) VALUES (8, 'ENG');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Dr.', 'Brown', 'Faculty', '2016-09-03');
INSERT INTO FACULTY (Member_ID, Department) VALUES (9, 'BIO');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Nina', 'Charles', 'Collaborator', '2021-11-15');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (10, 'ASU', 'Focuses on Urban Development.');

INSERT INTO LAB_MEMBER (First_Name, Last_Name, Type, Join_Date) 
VALUES ('Sam', 'Doe', 'Collaborator', '2014-03-21');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (11, 'NJIT', 'Expertise in Health Informatics.');

-- Grants
INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (101, 'NSF', 500000.00, '2024-01-01');

INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (102, 'DOD', 300000.00, '2023-05-20');

-- Projects
INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (201, 1, 'Quantum Machine Learning', 'Active', '2024-02-01', '2027-02-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (102, 4, 'Applications of Quantum Machine Learning in Leukemia Research', 'Active', '2023-06-15', '2026-06-15');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (103, 9, 'Prototype Construction for IEEE Conference', 'Active', '2022-09-01', '2026-10-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (104, 3, 'AI Ethics Framework Development', 'Completed', '2021-03-10', '2023-03-10');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (105, 6, 'Wearable Technology for Health Monitoring', 'Active', '2022-11-05', '2025-11-05');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (202, 8, 'Design of Renewable Energy Systems', 'Paused', '2020-07-14', '2026-01-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (302, 4, 'Quantum Computing in Drug Discovery', 'Paused', '2023-03-01', '2026-03-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (203, 9, 'Investigating Bioterrorism Threats', 'Completed', '2023-05-20', '2023-11-20');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (403, 10, 'Urban Renewable Energy Solutions', 'Active', '2021-09-15', '2024-09-15');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (410, 11, 'Exploration of LLMs in ', 'Completed', '2019-01-10', '2022-01-10');

-- Funds
INSERT INTO FUNDS (Grant_ID, Project_ID) VALUES (101, 201);
INSERT INTO FUNDS (Grant_ID, Project_ID) VALUES (102, 203);

-- Equipment
INSERT INTO EQUIPMENT (Equip_ID, Name, Type, Status, Purchase_Date, Req_Qualification) 
VALUES (301, 'NVIDIA A100', 'GPU Server', 'Available', '2023-11-01', 'AI Ethics');

INSERT INTO EQUIPMENT (Equip_ID, Name, Type, Status, Purchase_Date, Req_Qualification) 
VALUES (302, 'Solar Panel Array', 'Renewable Energy', 'In Use', '2020-05-20', 'Certified Solar Installer');

INSERT INTO EQUIPMENT (Equip_ID, Name, Type, Status, Purchase_Date) 
VALUES (303, 'Chemical Storage Unit', 'Safety Equipment', 'Retired', '2002-08-30');

-- Publication 
INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (401, 'Integrating Wearable Technology into Chronic Disease Management', 'January', 2022, 'IEEE', '10.1080/13658816.2021.1904696');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (402, 'Innovative Materials for Enhancing Structural Integrity in Aerospace Applications', 'April', 2009, 'Journal of Advanced Engineering Materials', '10.1234/jaem.2025.0098');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (403, 'Advancements in Quantum Computing Algorithms for Large-Scale Data Processing', 'June', 2023, 'ACM Computing Surveys', '10.1145/3571234');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (404, 'Renewable Energy Solutions for Urban Environments', 'September', 2021, 'Renewable Energy Journal', '10.1016/j.renene.2021.05.045');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (405, 'Bioterrorism Threat Detection Using Advanced Sensor Networks', 'March', 2024, 'Journal of Homeland Security', '10.1080/19361610.2024.1723456');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (406, 'Machine Learning Techniques for Predictive Analytics in Healthcare', 'November', 2022, 'Health Informatics Journal', '10.1177/14604582221123456');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (407, 'AI Ethics in Autonomous Systems: A Comprehensive Review', 'February', 2020, 'Ethics and Information Technology', '10.1007/s10676-020-09531-5');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (408, 'Quantum Entanglement and Its Applications in Secure Communications', 'July', 2021, 'Journal of Quantum Information Science', '10.4236/jqis.2021.107005');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (409, 'Advances in Renewable Energy Storage Technologies', 'October', 2023, 'Energy Storage Materials', '10.1016/j.ensm.2023.05.012');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (410, 'Project Management Strategies for Large-Scale Engineering Projects', 'December', 2019, 'International Journal of Project Management', '10.1016/j.ijproman.2019.06.004');

-- Authors
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (9, 401);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (11, 401);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (8, 402);

-- Qualifications
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (2, 'AI Ethics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (4, 'Quantum Physics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (6, 'Certified Solar Installer');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (7, 'Project Management Professional');

-- Works On
INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (1, 201, 'Leader', 200);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (2, 201, 'Developer', 150);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (8, 202, 'Leader', 300);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (10, 202, 'Assistant', 150);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (9, 203, 'Leader', 100);

-- Usage Log
INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date) 
VALUES (2, 301, 'Training Model A', '2024-12-01', '2024-12-10');

INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date) 
VALUES (6, 302, 'Collect and Analyze Solar Energy', '2024-05-21', '2024-09-10');

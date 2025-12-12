-- Lab Members
INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (1, 'Professor', 'Smith', 'Faculty', '2015-08-01');
INSERT INTO FACULTY (Member_ID, Department) VALUES (1, 'CS');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date)
VALUES (2, 'Dr.', 'Adams', 'Faculty', '2010-06-15');
INSERT INTO FACULTY (Member_ID, Department) VALUES (2, 'AERO ENGR');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (3, 'Dr.', 'Williams', 'Faculty', '2005-09-30');
INSERT INTO FACULTY (Member_ID, Department) VALUES (3, 'IS');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (4, 'Dr.', 'Chen', 'Faculty', '2018-01-10');
INSERT INTO FACULTY (Member_ID, Department) VALUES (4, 'CS');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date)
VALUES (5, 'Professor', 'Garcia', 'Faculty', '1999-11-20');
INSERT INTO FACULTY (Member_ID, Department) VALUES (5, 'EE');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (8, 'Professor', 'Harris', 'Faculty', '2001-04-24');
INSERT INTO FACULTY (Member_ID, Department) VALUES (8, 'ENG');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (9, 'Dr.', 'Brown', 'Faculty', '2016-09-03');
INSERT INTO FACULTY (Member_ID, Department) VALUES (9, 'BIO');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (100, 'Nina', 'Charles', 'Collaborator', '2021-11-15');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (100, 'ASU', 'Focuses on Urban Development.');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (101, 'Sam', 'Doe', 'Collaborator', '2014-03-21');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (101, 'NJIT', 'Expertise in Health Informatics.');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (103, 'Bob', 'Lee', 'Collaborator', '2023-01-15');
INSERT INTO COLLABORATOR (Member_ID, Institute, Biography) VALUES (103, 'NYU', 'Specializes in AI Ethics.');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date) 
VALUES (20000, 'Alice', 'Johnson', 'Student', '2022-09-01', 1, '2022-09-01', '2026-05-15');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20000, 'S9001', 'MS', 'CS');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Middle_Name, Last_Name, Type, Join_Date) 
VALUES (20001, 'Jane', 'A', 'Clark', 'Student', '2023-08-20');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20001, 'S9002', 'BS', 'ENG');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Middle_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date) 
VALUES (20002, 'Emily', 'B', 'Davis', 'Student', '2023-08-20', 4, '2023-08-20', '2025-08-20');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20002, 'S9003', 'BS', 'BIO');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date) 
VALUES (20003, 'Oliver', 'Walker', 'Student', '2023-08-22');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20003, 'S9004', 'MS', 'ME');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date)
VALUES (20004, 'Liam', 'Wilson', 'Student', '2022-01-10');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20004, 'S9005', 'PhD', 'CS');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date)
VALUES (20005, 'Sophia', 'Martinez', 'Student', '2024-02-15', 9, '2024-04-15', '2026-02-15');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20005, 'S9006', 'MS', 'BIO');

INSERT INTO LAB_MEMBER (Member_ID, First_Name, Last_Name, Type, Join_Date, Mentor_ID, Mentor_Start_Date, Mentor_End_Date)
VALUES (20006, 'James', 'Anderson', 'Student', '2020-03-01', 5, '2024-03-01', '2027-03-01');
INSERT INTO STUDENT (Member_ID, Student_Num, Ac_Level, Major) VALUES (20006, 'S9007', 'PhD', 'EE');


-- Grants
INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (101, 'NSF', 500000.00, '2024-01-01');

INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (102, 'DOD', 300000.00, '2023-05-20');

-- Projects
INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (201, 1, 'Quantum Machine Learning', 'Active', '2024-02-01', '2027-02-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (102, 1, 'Applications of Quantum Machine Learning in Leukemia Research', 'Active', '2023-06-15', '2026-06-15');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (302, 1, 'Quantum Computing in Drug Discovery', 'Paused', '2023-03-01', '2026-03-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (104, 3, 'AI Ethics Framework Development', 'Completed', '2021-03-10', '2023-03-10');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (200, 5, 'Advancement in Modulation for Signal Processing', 'Active', '2022-05-01', '2025-05-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (105, 8, 'Wearable Technology for Health Monitoring', 'Active', '2022-11-05', '2025-11-05');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (403, 8, 'Urban Renewable Energy Solutions', 'Active', '2021-09-15', '2024-09-15');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (202, 9, 'Design of Renewable Energy Systems', 'Paused', '2020-07-14', '2026-01-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (203, 9, 'Investigating Bioterrorism Threats', 'Completed', '2023-05-20', '2023-11-20');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (103, 9, 'Prototype Construction for IEEE Conference', 'Active', '2022-09-01', '2026-10-01');

INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date)
VALUES (410, 9, 'Exploration of LLMs in Research Publications', 'Completed', '2019-01-10', '2022-01-10');

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

INSERT INTO EQUIPMENT (Equip_ID, Name, Type, Status, Purchase_Date, Req_Qualification)
VALUES (304, 'Multimeter', 'Measurement Device', 'Available', '2018-03-15', 'Electrical Safety Training');
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

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (411, 'Exploration of AI in Mechanical Systems Design', 'May', 2024, 'Journal of Mechanical Design', '10.1115/1.4045362');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (412, 'Adversarial Networks in Image Recognition: A Survey', 'August', 2022, 'Computer Vision Journal', '10.1007/s11263-022-01567-8');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (413, 'Deep Learning Approaches for Natural Language Processing', 'March', 2023, 'Journal of Artificial Intelligence Research', '10.1613/jair.1.12345');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (414, 'Fungusal Biofilms in Medical Device Infections', 'June', 2024, 'Journal of Clinical Microbiology', '10.1128/JCM.01234-21');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (415, 'Solar Energy Harvesting Techniques for Remote Sensors', 'November', 2021, 'Sensors and Actuators A: Physical', '10.1016/j.sna.2021.112345');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (416, 'Signal Processing Algorithms for 5G Communications', 'January', 2020, 'IEEE Transactions on Signal Processing', '10.1109/TSP.2019.2951234');

INSERT INTO PUBLICATION (Public_ID, Title, Month, Year, Venue, DOI)
VALUES (417, 'State Space Models in Control Systems Engineering', 'April', 2019, 'Control Engineering Practice', '10.1016/j.conengprac.2019.02.005');
-- Authors
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (9, 401);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (2, 402);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (4, 403);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (9, 404);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (9, 405);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (1, 406);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (3, 407);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (1, 408);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (9, 409);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (8, 410);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20003, 411);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20004, 412);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20004, 413);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20005, 414);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20006, 415);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20006, 416);
INSERT INTO AUTHOR (Member_ID, Public_ID) VALUES (20006, 417);



-- Qualifications
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (1, 'AI Ethics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (3, 'AI Ethics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (4, 'Quantum Physics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (5, 'Certified Solar Installer');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (5, 'Electrical Safety Training');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (8, 'Project Management Professional');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (20006, 'Electrical Safety Training');

-- Works On
INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (1, 201, 'Leader', 200);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours)
VALUES (1, 102, 'Leader', 200);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours)
VALUES (1, 302, 'Leader', 200);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours)
VALUES (1, 103, 'Leader', 200);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (20000, 201, 'Developer', 150);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours)
VALUES (3, 104, 'Leader', 180);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (8, 202, 'Leader', 300);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (20005, 202, 'Assistant', 150);

INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (9, 203, 'Leader', 100);

-- Usage Log
INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date) 
VALUES (1, 301, 'Training Model A', '2024-12-01', '2024-12-10');

INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date) 
VALUES (5, 302, 'Collect and Analyze Solar Energy', '2024-05-21', '2024-09-10');

INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date)
VALUES (20006, 304, 'Electrical Measurements for Project', '2024-12-15', '2025-03-20');

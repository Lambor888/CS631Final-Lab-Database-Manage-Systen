
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

INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (101, 'NSF', 500000.00, '2024-01-01');
INSERT INTO GRANT_INFO (Grant_ID, Source, Budget, Start_Date) 
VALUES (102, 'DOD', 300000.00, '2023-05-20');


INSERT INTO PROJECT (Project_ID, Leader_ID, Title, Status, Start_Date, End_Date) 
VALUES (201, 1, 'Quantum Machine Learning', 'Active', '2024-02-01', '2027-02-01');


INSERT INTO FUNDS (Grant_ID, Project_ID) VALUES (101, 201);


INSERT INTO EQUIPMENT (Equip_ID, Name, Type, Status, Purchase_Date, Req_Qualification) 
VALUES (301, 'NVIDIA A100', 'GPU Server', 'Operational', '2023-11-01', 'AI Ethics');


INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (2, 'AI Ethics');
INSERT INTO HAS_QUALIFICATION (Member_ID, Qualification) VALUES (4, 'Quantum Physics');


INSERT INTO WORK_ON (Member_ID, Project_ID, Role, Hours) 
VALUES (2, 201, 'Developer', 150);


INSERT INTO USAGE_LOG (Member_ID, Equip_ID, Purpose, Start_Date, End_Date) 
VALUES (2, 301, 'Training Model A', '2024-12-01', '2024-12-10');
-- 1. Create Main Entity Tables

-- LAB_MEMBER (Lab Member)
CREATE TABLE LAB_MEMBER (
    Member_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL CHECK ((lower(Type) IN ('student', 'faculty', 'collaborator'))),
    Join_Date DATE NOT NULL,
    
    -- Mentor Relationship 
    Mentor_ID INTEGER,
    Mentor_Start_Date DATE,
    Mentor_End_Date DATE,

    FOREIGN KEY (Mentor_ID) REFERENCES LAB_MEMBER(Member_ID),
    
    -- Constraint: Mentor related attributes must be either all NULL or all NOT NULL 
    CONSTRAINT chk_mentor_full_info CHECK (
        (Mentor_ID IS NULL AND Mentor_Start_Date IS NULL AND Mentor_End_Date IS NULL) OR 
        (Mentor_ID IS NOT NULL AND Mentor_Start_Date IS NOT NULL AND Mentor_End_Date IS NOT NULL)
    )
);

-- STUDENT 
CREATE TABLE STUDENT (
    Member_ID INTEGER PRIMARY KEY,
    Student_Num VARCHAR(20) UNIQUE NOT NULL, 
    ac_level VARCHAR(20),
    Major VARCHAR(50),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID) ON DELETE CASCADE
);

-- FACULTY 
CREATE TABLE FACULTY (
    Member_ID INTEGER PRIMARY KEY,
    Department VARCHAR(100),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID) ON DELETE CASCADE
);

-- COLLABORATOR 
CREATE TABLE COLLABORATOR (
    Member_ID INTEGER PRIMARY KEY,
    Institute VARCHAR(100),
    Biography TEXT,
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID) ON DELETE CASCADE
);

-- PROJECT 
CREATE TABLE PROJECT (
    Project_ID SERIAL PRIMARY KEY,
    Leader_ID INTEGER NOT NULL, 
    Title VARCHAR(200) NOT NULL,
    Status VARCHAR(50) CHECK ((lower(Status) IN ('active', 'completed', 'paused'))),
    Start_Date DATE,
    End_Date DATE,
    FOREIGN KEY (Leader_ID) REFERENCES LAB_MEMBER(Member_ID)
);

-- GRANT (Renamed to GRANT_INFO to avoid keyword conflict)
CREATE TABLE GRANT_INFO (
    Grant_ID SERIAL PRIMARY KEY,
    Source VARCHAR(100),
    Budget DECIMAL(12, 2),
    Start_Date DATE,
    Duration INTEGER -- In units of months or days
);

-- PUBLICATION 
CREATE TABLE PUBLICATION (
    Public_ID SERIAL PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Month VARCHAR(20) NOT NULL,
    Year INTEGER NOT NULL,
    Venue VARCHAR(100) NOT NULL,
    DOI VARCHAR(100) -- Can be NULL 
);

-- EQUIPMENT 
CREATE TABLE EQUIPMENT (
    Equip_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    Status VARCHAR(50) CHECK ((lower(Status) IN ('available', 'in use', 'retired', 'maintenance'))),
    Purchase_Date DATE,
    Req_Qualification VARCHAR(100) -- Required qualification to use this equipment
);

-- 2. Create Relationship Tables (M:N and Multi-valued Attributes)

-- HAS_QUALIFICATION (Multi-valued attribute)
CREATE TABLE HAS_QUALIFICATION (
    Member_ID INTEGER,
    Qualification VARCHAR(100),
    PRIMARY KEY (Member_ID, Qualification),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID) ON DELETE CASCADE
);

-- WORK_ON (M:N Relationship)
CREATE TABLE WORK_ON (
    Member_ID INTEGER,
    Project_ID INTEGER,
    Role VARCHAR(50),
    Hours DECIMAL(5, 2),
    PRIMARY KEY (Member_ID, Project_ID),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID),
    FOREIGN KEY (Project_ID) REFERENCES PROJECT(Project_ID)
);

-- AUTHOR (M:N Relationship)
CREATE TABLE AUTHOR (
    Member_ID INTEGER,
    Public_ID INTEGER,
    PRIMARY KEY (Member_ID, Public_ID),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID),
    FOREIGN KEY (Public_ID) REFERENCES PUBLICATION(Public_ID)
);

-- FUNDS (M:N Relationship)
CREATE TABLE FUNDS (
    Grant_ID INTEGER,
    Project_ID INTEGER,
    PRIMARY KEY (Grant_ID, Project_ID),
    FOREIGN KEY (Grant_ID) REFERENCES GRANT_INFO(Grant_ID),
    FOREIGN KEY (Project_ID) REFERENCES PROJECT(Project_ID)
);

-- USE (Renamed to USAGE_LOG)
CREATE TABLE USAGE_LOG (
    Member_ID INTEGER,
    Equip_ID INTEGER,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Purpose VARCHAR(200),
    PRIMARY KEY (Member_ID, Equip_ID),
    FOREIGN KEY (Member_ID) REFERENCES LAB_MEMBER(Member_ID),
    FOREIGN KEY (Equip_ID) REFERENCES EQUIPMENT(Equip_ID)
);

ALTER TABLE USAGE_LOG
    ADD COLUMN Duration INTERVAL GENERATED ALWAYS AS ((End_Date - Start_Date + 1) * interval '1 day') STORED;

ALTER TABLE PROJECT
    ADD COLUMN Duration INTERVAL GENERATED ALWAYS AS ((End_Date - Start_Date + 1) * interval '1 day') STORED;    

ALTER TABLE LAB_MEMBER
    ADD COLUMN Duration INTERVAL GENERATED ALWAYS AS ((Mentor_End_Date - Mentor_Start_Date + 1) * interval '1 day') STORED;

-- 3. Advanced Constraint Implementation (Triggers & Functions)

-- 3.1 Constraint: Mentor cannot be of type 'Student' 
CREATE OR REPLACE FUNCTION check_mentor_type() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Mentor_ID IS NOT NULL THEN
        IF EXISTS (SELECT 1 FROM LAB_MEMBER WHERE Member_ID = NEW.Mentor_ID AND Type = 'Student') THEN
            RAISE EXCEPTION 'Constraint Violation: Mentor cannot be a Student.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_mentor_type
BEFORE INSERT OR UPDATE ON LAB_MEMBER
FOR EACH ROW EXECUTE FUNCTION check_mentor_type();

-- 3.2 Constraint: Project Leader must be of type 'Faculty' 
CREATE OR REPLACE FUNCTION check_project_leader_type() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM LAB_MEMBER WHERE Member_ID = NEW.Leader_ID AND Type = 'Faculty') THEN
        RAISE EXCEPTION 'Constraint Violation: Project Leader must be a Faculty member.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_project_leader
BEFORE INSERT OR UPDATE ON PROJECT
FOR EACH ROW EXECUTE FUNCTION check_project_leader_type();

-- 3.3 Constraint: User must possess the required qualification to operate the equipment 
CREATE OR REPLACE FUNCTION check_equipment_qualification() RETURNS TRIGGER AS $$
DECLARE
    required_qual VARCHAR(100);
BEGIN
    -- Retrieve required qualification for the equipment
    SELECT Req_Qualification INTO required_qual FROM EQUIPMENT WHERE Equip_ID = NEW.Equip_ID;
    
    -- If qualification is required, check if the user possesses it
    IF required_qual IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM HAS_QUALIFICATION 
            WHERE Member_ID = NEW.Member_ID AND Qualification = required_qual
        ) THEN
            RAISE EXCEPTION 'Constraint Violation: User does not possess the required qualification (%) for this equipment.', required_qual;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_equip_qual
BEFORE INSERT OR UPDATE ON USAGE_LOG
FOR EACH ROW EXECUTE FUNCTION check_equipment_qualification();

-- 3.4 Constraint: A single equipment can be used by a maximum of 3 people concurrently in the same period 
-- Needs to check for time overlap
CREATE OR REPLACE FUNCTION check_equipment_concurrency() RETURNS TRIGGER AS $$
DECLARE
    usage_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO usage_count
    FROM USAGE_LOG
    WHERE Equip_ID = NEW.Equip_ID
      AND Start_Date <= NEW.End_Date 
      AND (End_Date IS NULL OR End_Date >= NEW.Start_Date); -- Time overlap check logic

    IF usage_count >= 3 THEN
        RAISE EXCEPTION 'Constraint Violation: Equipment % cannot be used by more than 3 people concurrently.', NEW.Equip_ID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_equip_concurrency
BEFORE INSERT OR UPDATE ON USAGE_LOG
FOR EACH ROW EXECUTE FUNCTION check_equipment_concurrency();

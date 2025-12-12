from fastapi import APIRouter, Request, Form
from fastapi.templating import Jinja2Templates
from ..utils import execute_raw_sql 


router = APIRouter()
templates = Jinja2Templates(directory="templates")

# Task 1 Bullet 2: Display the status of a project.
@router.post("/query/project-status") #your own query function
async def get_project_status(request: Request, project_identifier: str = Form(None)):
    """
    Handles the project status query form submission.
    Determines if the input is a project ID (numeric) or a project title (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if project_identifier is None:
        sql = """SELECT project_id AS "Project ID", title AS "Project Title", status AS "Project Status" FROM project;"""
        params = ""
    elif project_identifier.isdigit():
        sql = """SELECT project_id AS "Project ID", title AS "Project Title", status AS "Project Status" FROM project WHERE project_id = %s;"""
        params = (int(project_identifier),)
    else:
        sql = """SELECT project_id AS "Project ID", title AS "Project Title", status AS "Project Status" FROM project WHERE title ILIKE %s;"""
        params = (f"%{project_identifier}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "project"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Project Status Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# Task 1 Bullet 3: Show members who have worked on projects funded by a given grant.
@router.post("/query/project-grant") #your own query function
async def get_project_grant(request: Request, project_grant: str = Form(None)):
    """
    Handles the project grant query form submission.
    Determines if the input is a grant ID (numeric) or a grant source (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if project_grant is None:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", project.title AS "Project Title", grant_info.source AS "Grant Source"
            FROM lab_member
            JOIN work_on ON lab_member.member_id = work_on.member_id
            JOIN funds ON work_on.project_id = funds.project_id
            JOIN grant_info ON funds.grant_id = grant_info.grant_id
            JOIN project ON project.project_id = work_on.project_id;
        """
        params = ""
    elif project_grant.isdigit():
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", project.title AS "Project Title", grant_info.source AS "Grant Source"
            FROM lab_member
            JOIN work_on ON lab_member.member_id = work_on.member_id
            JOIN funds ON work_on.project_id = funds.project_id
            JOIN grant_info ON funds.grant_id = grant_info.grant_id
            JOIN project ON project.project_id = work_on.project_id
            WHERE grant_info.grant_id = %s;
        """
        params = (int(project_grant),)
    else:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", project.title AS "Project Title", grant_info.source AS "Grant Source"
            FROM lab_member
            JOIN work_on ON lab_member.member_id = work_on.member_id
            JOIN funds ON work_on.project_id = funds.project_id
            JOIN grant_info ON funds.grant_id = grant_info.grant_id
            JOIN project ON project.project_id = work_on.project_id
            WHERE grant_info.source ILIKE %s;
        """
        params = (f"%{project_grant}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "project"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Project Grant Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# Task 1 Bullet 4: View mentorship relations with same projects.
@router.post("/query/mentor-relations") #your own query function
async def get_mentor_relations(request: Request):
    """
    Handles the mentor relation query form submission.
    Constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    sql = """ 
        SELECT mentee.first_name AS "Mentee First Name", mentee.last_name AS "Mentee Last Name", mentor.first_name AS "Mentor First Name", mentor.last_name AS "Mentor Last Name", project.title AS "Project Title"
        FROM lab_member mentee
        JOIN lab_member mentor ON mentee.mentor_id = mentor.member_id
        JOIN work_on mentee_works ON mentee.member_id = mentee_works.member_id
        JOIN work_on mentor_works ON mentor.member_id = mentor_works.member_id
        JOIN project ON mentee_works.project_id = project.project_id
        WHERE mentee_works.project_id = mentor_works.project_id;
    """
    params = ""

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "project"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Mentor Relation Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin  
    })

# Task 2 Bullet 2: Show status of a piece of equipment.
@router.post("/query/equipment-status") #your own query function
async def get_equipment_status(request: Request, equipment_identifier: str = Form(None)):
    """
    Handles the equipment status query form submission.
    Determines if the input is equipment ID (numeric) or a equipment name (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if equipment_identifier is None:
        sql = """SELECT equip_id AS "Equipment ID", name AS "Equipment Name", status AS "Equipment Status" FROM equipment;"""
        params = ""
    elif equipment_identifier.isdigit():
        sql = """SELECT equip_id AS "Equipment ID", name AS "Equipment Name", status AS "Equipment Status" FROM equipment WHERE equip_id = %s;"""
        params = (int(equipment_identifier),)
    else:
        sql = """SELECT equip_id AS "Equipment ID", name AS "Equipment Name", status AS "Equipment Status" FROM equipment WHERE name ILIKE %s;"""
        params = (f"%{equipment_identifier}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "equipment"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Equipment Status Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# Task 2 Bullet 3: Show the members using a piece of equipment and their projects.
@router.post("/query/equipment-members") #your own query function
async def get_equipment_members(request: Request, equipment_identifier: str = Form(None)):
    """
    Handles the equipment members query form submission.
    Determines if the input is equipment ID (numeric) or equipment name (text),
    Constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if equipment_identifier is None:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", equipment.name as "Equipment Name", project.title AS "Project Title"
            FROM lab_member
            LEFT JOIN work_on ON lab_member.member_id = work_on.member_id
            LEFT JOIN project ON work_on.project_id = project.project_id
            JOIN usage_log ON lab_member.member_id = usage_log.member_id
            JOIN equipment ON usage_log.equip_id = equipment.equip_id;
        """
        params = ""
    elif equipment_identifier.isdigit():
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", equipment.name as "Equipment Name", project.title AS "Project Title"
            FROM lab_member
            LEFT JOIN work_on ON lab_member.member_id = work_on.member_id
            LEFT JOIN project ON work_on.project_id = project.project_id
            JOIN usage_log ON lab_member.member_id = usage_log.member_id
            JOIN equipment ON usage_log.equip_id = equipment.equip_id
            WHERE equipment.equip_id = %s;
        """
        params = (int(equipment_identifier),)
    else:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", equipment.name as "Equipment Name", project.title AS "Project Title"
            FROM lab_member
            LEFT JOIN work_on ON lab_member.member_id = work_on.member_id
            LEFT JOIN project ON work_on.project_id = project.project_id
            JOIN usage_log ON lab_member.member_id = usage_log.member_id
            JOIN equipment ON usage_log.equip_id = equipment.equip_id
            WHERE equipment.name ILIKE %s;
        """
        params = (f"%{equipment_identifier}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "equipment"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Equipment Members Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# Task 3 Bullet 1: Identify the name of the member(s) with the highest number of publications.
@router.post("/query/publication-count") #your own query function
async def get_member_publications(request: Request, publication_count: str = Form(None)):
    """
    Handles the member publications query form submission.
    Uses a default or numerical number of members to limit the number of results returned,
    Constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if publication_count is None:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", COUNT(publication.public_id) AS "Number of Publications"
            FROM lab_member, publication, author
            WHERE lab_member.member_id = author.member_id AND author.public_id = publication.public_id
            GROUP BY lab_member.first_name, lab_member.last_name
            ORDER BY "Number of Publications" DESC;
        """
        params = ""
    elif publication_count.isdigit():
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", COUNT(publication.public_id) AS "Number of Publications"
            FROM lab_member, publication, author
            WHERE lab_member.member_id = author.member_id AND author.public_id = publication.public_id
            GROUP BY lab_member.first_name, lab_member.last_name
            ORDER BY "Number of Publications" DESC
            LIMIT %s;
        """
        params = (int(publication_count),)
    # Default query if user enters anything other than a numerical value
    else:
        sql = """
            SELECT lab_member.first_name AS "First Name", lab_member.last_name AS "Last Name", COUNT(publication.public_id) AS "Number of Publications"
            FROM lab_member, publication, author
            WHERE lab_member.member_id = author.member_id AND author.public_id = publication.public_id
            GROUP BY lab_member.first_name, lab_member.last_name
            ORDER BY "Number of Publications" DESC;
        """
        params = ""

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "grant"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Equipment Members Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# Task 3 Bullet 4: Find the three most prolific members who have worked on a project funded by a given grant.
@router.post("/query/grant-prolific") #your own query function
async def get_grant_prolific_members(request: Request, grant_identifier: str = Form(...)):
    """
    Handles the prolific members of a certain grant query form submission.
    Determines if the input is grant ID (numeric) or grant source (text),
    Constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    # Should not be None but have here just in case it could be in the future 
    if grant_identifier is None:
        sql = """
            SELECT First_name, last_name, title, L.Source, COUNT(P.Member_ID) AS COUNT_PUB
            FROM ( SELECT WORK_ON.Member_ID, FUNDS.project_id, GRANT_INFO.Source FROM WORK_ON, FUNDS, GRANT_INFO WHERE WORK_ON.project_ID = FUNDS.project_ID AND GRANT_INFO.Grant_ID = FUNDS.Grant_ID AND FUNds.Grant_ID = 101 )
            AS L
            LEFT OUTER JOIN AUTHOR AS P ON L.Member_ID = P.Member_ID
            JOIN PROJECT ON PROJECT.Project_ID = L.Project_ID
            JOIN LAB_MEMBER ON LAB_MEMBER.Member_ID = L.MEMBER_ID
            GROUP BY lab_member.first_name, lab_member.last_name, title, l.source
            ORDER BY COUNT_PUB DESC
            FETCH FIRST 3 ROWS ONLY;
        """
        params = ""
    elif grant_identifier.isdigit():
        sql = """
            SELECT First_name, last_name, title, L.Source, COUNT(P.Member_ID) AS COUNT_PUB
            FROM ( SELECT WORK_ON.Member_ID, FUNDS.project_id, GRANT_INFO.Source FROM WORK_ON, FUNDS, GRANT_INFO WHERE WORK_ON.project_ID = FUNDS.project_ID AND GRANT_INFO.Grant_ID = FUNDS.Grant_ID AND FUNds.Grant_ID = %s )
            AS L
            LEFT OUTER JOIN AUTHOR AS P ON L.Member_ID = P.Member_ID
            JOIN PROJECT ON PROJECT.Project_ID = L.Project_ID
            JOIN LAB_MEMBER ON LAB_MEMBER.Member_ID = L.MEMBER_ID
            GROUP BY lab_member.first_name, lab_member.last_name, title, l.source
            ORDER BY COUNT_PUB DESC
            FETCH FIRST 3 ROWS ONLY;
        """
        params = (int(grant_identifier),)
    else:
        sql = """
            SELECT First_name, last_name, title, L.Source, COUNT(P.Member_ID) AS COUNT_PUB
            FROM ( SELECT WORK_ON.Member_ID, FUNDS.project_id, GRANT_INFO.Source FROM WORK_ON, FUNDS, GRANT_INFO WHERE WORK_ON.project_ID = FUNDS.project_ID AND GRANT_INFO.Grant_ID = FUNDS.Grant_ID AND GRANT_INFO.source ILIKE %s )
            AS L
            LEFT OUTER JOIN AUTHOR AS P ON L.Member_ID = P.Member_ID
            JOIN PROJECT ON PROJECT.Project_ID = L.Project_ID
            JOIN LAB_MEMBER ON LAB_MEMBER.Member_ID = L.MEMBER_ID
            GROUP BY lab_member.first_name, lab_member.last_name, title, l.source
            ORDER BY COUNT_PUB DESC
            FETCH FIRST 3 ROWS ONLY;
        """
        params = (f"%{grant_identifier}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Identify the original page to return to
    origin = "grant"

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Equipment Members Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql,
        "origin": origin
    })

# You can continue adding other project-related query functions here...

from fastapi import APIRouter, Request, Form
from fastapi.templating import Jinja2Templates
from ..utils import execute_raw_sql 


router = APIRouter()
templates = Jinja2Templates(directory="templates")

# Task 1 Bullet 2: Display the status of a project.
@router.post("/query/project-status") #your own query function
async def get_project_status(request: Request, project_identifier: str = Form(...)):
    """
    Handles the project status query form submission.
    Determines if the input is a project ID (numeric) or a project title (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if project_identifier.isdigit():
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
async def get_project_grant(request: Request, project_grant: str = Form(...)):
    """
    Handles the project grant query form submission.
    Determines if the input is a grant ID (numeric) or a grant source (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if project_grant.isdigit():
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
    Handles the project status query form submission.
    Determines if the input is a project ID (numeric) or a project title (text),
    constructs the appropriate SQL query, executes it, and renders the results.
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

# You can continue adding other project-related query functions here...

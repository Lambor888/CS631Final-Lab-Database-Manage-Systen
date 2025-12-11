from fastapi import APIRouter, Request, Form
from fastapi.templating import Jinja2Templates
from ..utils import execute_raw_sql 


router = APIRouter()
templates = Jinja2Templates(directory="templates")

@router.post("/query/project-status") #your own query function
async def get_project_status(request: Request, project_identifier: str = Form(...)):
    """
    Handles the project status query form submission.
    Determines if the input is a project ID (numeric) or a project title (text),
    constructs the appropriate SQL query, executes it, and renders the results.
    """
    # write RAW sql 👇
    if project_identifier.isdigit():
        sql = "SELECT project_id, title, status FROM project WHERE project_id = %s;"
        params = (int(project_identifier),)
    else:
        sql = "SELECT project_id, title, status FROM project WHERE title ILIKE %s;"
        params = (f"%{project_identifier}%",)

    # Execute SQL
    headers, rows, status_msg, error = execute_raw_sql(sql, params)

    # Render the common template
    return templates.TemplateResponse("query_result.html", {
        "request": request,
        "page_title": "Project Status Details",
        "headers": headers,
        "rows": rows,
        "error_detail": error,
        "sql_query": sql  
    })

# You can continue adding other project-related query functions here...
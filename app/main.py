import os
import psycopg2
from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
import time

# 1. Initialize Application and Template Engine
app = FastAPI()
# The templates directory is 'templates', relative to the Docker container working directory
templates = Jinja2Templates(directory="templates")

# Retrieve connection URL from environment variable
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@db:5432/database")

def check_db_connection(max_retries=10, delay=5):
    """
    Attempt to connect to the database, retrying if it fails.
    """
    DATABASE_URL = os.getenv("DATABASE_URL")
    
    for attempt in range(max_retries):
        conn = None
        try:
            conn = psycopg2.connect(DATABASE_URL)
            with conn.cursor() as cur:
                cur.execute("SELECT 1;")
            print(f"Database connection successful on attempt {attempt + 1}")
            return "Success", None  # Connection successful
            
        except psycopg2.OperationalError as e:
            if attempt < max_retries - 1:
                # Only retry if connection fails (e.g., 'database "user" does not exist')
                print(f"Connection failed (Attempt {attempt + 1}/{max_retries}). Retrying in {delay} seconds...")
                time.sleep(delay)
            else:
                # Maximum number of retries reached
                return "Failed", str(e)
                
        except Exception as e:
            # Catch all other exceptions
            return "Failed", str(e)
            
        finally:
            if conn:
                conn.close()
    
    return "Failed", "Maximum connection attempts reached."

@app.get("/", include_in_schema=False)
async def home(request: Request):
    """
    Home route, checks database connection status and renders the HTML page.
    """
    status, error_detail = check_db_connection()
    
    # Render the templates/status.html template
    return templates.TemplateResponse(
        "status.html", 
        {
            "request": request,
            "status_message": status,
            "error_detail": error_detail
        }
    )

def get_all_table_names():
    """
    Connects to the database and queries all BASE TABLE names in the public schema.
    """
    conn = None
    try:
        conn = psycopg2.connect(DATABASE_URL)

        print(f"Python is connected to database: {conn.info.dbname}")

        with conn.cursor() as cur:
            # Use information_schema.tables to query all base table names
            cur.execute("""
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema = 'public'
                AND table_type = 'BASE TABLE';
            """)
            # fetchall returns a list of (table_name,) tuples; we need to flatten it
            table_names = [row[0] for row in cur.fetchall()]
            print(f"Retrieved table names: {table_names}")
            return table_names, None # Return the list of table names and no error
            
    except Exception as e:
        # If connection or query fails, return an empty list and the error message
        return [], str(e)
        
    finally:
        if conn:
            conn.close()


def get_table_data(table_name):
    """
    Connects to the database and queries all data for the specified table.
    Returns column names (headers) and row data (rows).
    """
    conn = None
    try:
        conn = psycopg2.connect(DATABASE_URL)
        
        with conn.cursor() as cur:
            # Construct the query, enclosing the table name in double quotes to handle PostgreSQL default lowercase table names
            # Note: table_name is a safe input from a database query, so direct string formatting is acceptable here.
            query = f"SELECT * FROM \"{table_name}\";"
            cur.execute(query)
            
            # 1. Retrieve column names (headers)
            headers = [desc[0] for desc in cur.description]
            
            # 2. Retrieve all row data
            rows = cur.fetchall()
            
            return headers, rows, None # Return headers, data, and no error
            
    except Exception as e:
        # If connection or query fails, return empty lists and the error message
        return [], [], str(e)
        
    finally:
        if conn:
            conn.close()

def execute_raw_sql(sql_query):
    """
    Connects to the database and executes any SQL statement.
    Returns execution results (headers/rows/status_message/error).
    """
    conn = None
    try:
        conn = psycopg2.connect(DATABASE_URL)
        
        with conn.cursor() as cur:
            # Execute the query
            cur.execute(sql_query)
            
            # Check if there is a result set (SELECT/EXPLAIN)
            if cur.description is not None:
                headers = [desc[0] for desc in cur.description]
                rows = cur.fetchall()
                conn.commit()
                return headers, rows, None, None # Return headers, rows, status, error
            else:
                # For non-query commands (INSERT/UPDATE/DELETE/CREATE/ALTER)
                status = cur.statusmessage
                conn.commit()
                return None, None, status, None # Return status message
            
    except Exception as e:
        # Catch all exceptions, especially SQL syntax errors or constraint violations
        if conn:
            conn.rollback()
        return None, None, None, str(e)
        
    finally:
        if conn:
            conn.close()

@app.get("/tables/{table_name}", include_in_schema=False)
async def table_detail(request: Request, table_name: str):
    """
    New route: Displays detailed data for a specific table.
    """
    # Add security check: ensure the requested table name is an actual existing table name
    valid_tables, _ = get_all_table_names()
    
    if table_name not in valid_tables:
        # Simple error handling; a dedicated error template could be created in a production application
        return templates.TemplateResponse(
            "tables.html", 
            {
                "request": request,
                "table_names": valid_tables,
                "error_detail": f"Error: Table '{table_name}' does not exist or is not a base table."
            },
            status_code=404
        )
        
    # Retrieve table data
    headers, rows, error = get_table_data(table_name)
    
    # Render the templates/table_detail.html template
    return templates.TemplateResponse(
        "table_detail.html", 
        {
            "request": request,
            "table_name": table_name,
            "headers": headers,
            "rows": rows,
            "error_detail": error
        }
    )

@app.get("/tables", include_in_schema=False)
async def list_tables(request: Request):
    """
    New route: Retrieves the list of table names and renders the tables.html page.
    """
    table_names, error = get_all_table_names()
    
    return templates.TemplateResponse(
        "tables.html", 
        {
            "request": request,
            "table_names": table_names,
            "error_detail": error
        }
    )

@app.get("/sql-executor", include_in_schema=False)
async def sql_executor_page(request: Request):
    """
    render SQL Executor page (GET request).
    """
    return templates.TemplateResponse(
        "sql_executor.html", 
        {"request": request, "sql_query": ""}
    )

@app.post("/execute-sql", include_in_schema=False)
async def execute_sql(request: Request):
    """
    Receive and execute SQL statement (POST request).
    """
    form = await request.form()
    sql_query = form.get("sql_query", "").strip()
    
    headers, rows, status_message, error_detail = execute_raw_sql(sql_query)
    
    # Render results to the same template
    return templates.TemplateResponse(
        "sql_executor.html", 
        {
            "request": request,
            "sql_query": sql_query,
            "headers": headers,
            "rows": rows,
            "status_message": status_message,
            "error_detail": error_detail
        }
    )

# ... Your other routes (if already written)
# from .routers import members
# app.include_router(members.router)
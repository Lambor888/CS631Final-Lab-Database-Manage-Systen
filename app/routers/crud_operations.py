from fastapi import APIRouter, Request, Form
from fastapi.templating import Jinja2Templates
from ..utils import execute_raw_sql, get_primary_key_columns
from fastapi.responses import RedirectResponse

router = APIRouter()
templates = Jinja2Templates(directory="templates")


@router.post("/tables/{table_name}/delete", include_in_schema=False)
async def delete_row(request: Request, table_name: str):
    form = await request.form()
    
    pk_columns = get_primary_key_columns(table_name)
    where_clauses = []
    
    if not pk_columns:
        message = "delete failed: no primary key columns found."
        return RedirectResponse(f"/tables/{table_name}?message={message}", status_code=303)

    for pk_col in pk_columns:
        pk_value = form.get(f"pk_{pk_col}") 
        if not pk_value:
            message = f"delete failed: missing primary key value '{pk_col}'."
            return RedirectResponse(f"/tables/{table_name}?message={message}", status_code=303)
        where_clauses.append(f"\"{pk_col}\" = '{pk_value}'")
        
    sql_query = f"DELETE FROM \"{table_name}\" WHERE {' AND '.join(where_clauses)};"
    
    _, _, status_message, error_detail = execute_raw_sql(sql_query)
    
    message = "delete successful!" if not error_detail else f"delete failed: {error_detail}"
    return RedirectResponse(
        f"/tables/{table_name}?message={message}", 
        status_code=303
    )


@router.post("/tables/{table_name}/crud", include_in_schema=False)
async def handle_crud(request: Request, table_name: str):
    form = await request.form()
    operation = form.get("operation") # 'insert' or 'update'
    
    query_headers = f"SELECT * FROM \"{table_name}\" LIMIT 0;"
    headers, _, _, _ = execute_raw_sql(query_headers)

    pk_columns = get_primary_key_columns(table_name)

    IGNORED_COLUMNS = ['duration']
    
    sql_query = None
    message = ""
    
    try:
        def format_value(value):
            """handle NULL values and SQL escaping"""
            if value is None or value == '' or (isinstance(value, str) and value.lower() == 'none'):
                return 'NULL'
            safe_value = str(value).replace("'", "''")
            return f"'{safe_value}'"

        if operation == 'insert':
            cols = []
            vals = []
            for header in headers:
                if header.lower() in IGNORED_COLUMNS:
                    continue
                
                value = form.get(header)
                if value is not None and value != '': 
                    cols.append(f"\"{header}\"")
                    vals.append(format_value(value))
            
            if not cols:
                 message = "insert failed: no valid data provided."
            else:
                sql_query = f"INSERT INTO \"{table_name}\" ({', '.join(cols)}) VALUES ({', '.join(vals)});"
        
        elif operation == 'update':
            where_clauses = []
            set_clauses = []

            for pk_col in pk_columns:
                pk_value = form.get(pk_col)
                if not pk_value:
                    message = f"update failed: missing primary key value '{pk_col}'."
                    break 
                where_clauses.append(f"\"{pk_col}\" = '{pk_value}'")
            
            if message: 
                pass 
            else:
                # 2. Build SET clause
                for header in headers:
                    # Exclude primary key AND auto-generated columns
                    if header not in pk_columns and header.lower() not in IGNORED_COLUMNS:
                        value = form.get(header)
                        set_clauses.append(f"\"{header}\" = {format_value(value)}")
                
                if not set_clauses:
                    message = "update failed: no fields to update (or only attempted to modify primary key/generated columns)."
                else:
                    sql_query = f"UPDATE \"{table_name}\" SET {', '.join(set_clauses)} WHERE {' AND '.join(where_clauses)};"
        
        else:
             message = "operation failed: invalid CRUD operation type."

        # Execute SQL
        if sql_query and not message:
            _, _, status_message, error_detail = execute_raw_sql(sql_query)
            
            if error_detail:
                message = f"{operation.capitalize()} failed : {error_detail}"
            else:
                message = f"{operation.capitalize()} successful! ({status_message})"

    except Exception as e:
        message = f"operation failed: internal error {str(e)}"

    return RedirectResponse(
        f"/tables/{table_name}?message={message}", 
        status_code=303
    )
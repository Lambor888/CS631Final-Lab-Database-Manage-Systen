import os
import psycopg2

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@db:5432/database")

def execute_raw_sql(sql_query, params=None):
    """
    Connects to the database and executes any SQL statement.
    Returns execution results (headers/rows/status_message/error).
    """
    conn = None
    try:
        conn = psycopg2.connect(DATABASE_URL)
        with conn.cursor() as cur:
            # If there are parameters, use parameterized execution; otherwise execute directly
            if params:
                cur.execute(sql_query, params)
            else:
                cur.execute(sql_query)
            
            # If it is a SELECT query, fetch the results
            if cur.description is not None:
                headers = [desc[0] for desc in cur.description]
                rows = cur.fetchall()
                conn.commit()
                return headers, rows, None, None
            else:
                # For non-query commands (INSERT/UPDATE/DELETE/CREATE/ALTER)
                status = cur.statusmessage
                conn.commit()
                return None, None, status, None
            
    except Exception as e:
        if conn:
            conn.rollback()
        return None, None, None, str(e)
        
    finally:
        if conn:
            conn.close()
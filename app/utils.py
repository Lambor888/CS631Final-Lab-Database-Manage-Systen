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

# main.py (新的 get_primary_key_columns 函数)

def get_primary_key_columns(table_name: str) -> list[str]:
    """
    使用 execute_raw_sql 查询指定表的所有主键列名称。
    
    返回: 
        list[str]: 主键列名的列表 (对于复合键，返回多个列名)
    """
    # SQL 查询：从 PostgreSQL 的系统目录表中获取主键列名
    # 注意：需要确保 execute_raw_sql 能正确处理此 SELECT 语句。
    query = f"""
        SELECT a.attname
        FROM   pg_index i
        JOIN   pg_attribute a ON a.attrelid = i.indrelid
                             AND a.attnum = ANY(i.indkey)
        WHERE  i.indrelid = '{table_name}'::regclass
        AND    i.indisprimary;
    """
    
    # 使用你提供的辅助函数执行查询
    headers, rows, _, error = execute_raw_sql(query)
    
    if error:
        print(f"Error retrieving PK for {table_name}: {error}")
        return []
        
    # rows 结果为 [(col1,), (col2,)]，需要扁平化
    pk_columns = [row[0] for row in rows]
    return pk_columns
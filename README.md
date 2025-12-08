# 🚀 Research Lab Manager System Deployment Guide

This guide details the steps required to deploy and run the Research Lab Manager application, which uses **FastAPI** as the backend and **PostgreSQL** as the database, all orchestrated via **Docker Compose**.

## 📋 Prerequisites

Before starting, ensure you have the following software installed on your machine:

  * **Git:** For cloning the repository.
  * **Python 3.10+**
  * **Docker Desktop (or Docker Engine & Compose):** For building and running the containerized services.

## 1\. 📂 Project Structure Overview

The project relies on a specific file structure for Docker Compose initialization:

```
research-lab-manager/
├── docker-compose.yml       # Defines services (web, db, pgadmin)
├── init-db.sh               # Database readiness check script (run by Docker)
├── main.py                  # FastAPI application logic
├── requirements.txt         # Python dependencies
├── app/
│   └── sql/
│       ├── 01_init.sql      # Database schema (CREATE TABLE, Triggers, Functions)
│       └── 02_data.sql      # Sample data (INSERT statements)
└── templates/
    ├── status.html          # Connection status page
    ├── tables.html          # List of all database tables
    └── table_detail.html    # Detailed data view for a specific table
```

-----

## 2\. ⬇️ Setup and Deployment Steps

Follow these steps precisely to clone the repository and initialize the services.

### Step 2.1: Clone the Repository

Clone your project from the Git repository and navigate into the directory:

```bash
git clone <YOUR_REPOSITORY_URL>
cd research-lab-manager
```

### Step 2.2: Ensure Initialization Files Are Correct

Verify that the critical database initialization files have the correct names and execution permissions.

1.  **Grant Execution Permission:** Ensure the database waiting script is executable:
    ```bash
    chmod +x init-db.sh
    ```
2.  **Verify SQL File Names:** Confirm your schema and data files are named correctly for alphabetical execution order:
    ```bash
    ls app/sql/
    # Expected output: 01_init.sql  02_data.sql
    ```

### Step 2.3: Initial Build and Database Initialization

Since the database relies on initialization scripts (`01_init.sql` and `02_data.sql`), we must ensure Docker fully rebuilds and initializes the volumes.

1.  **Run Docker Compose:** Use the `--build` .

    ```bash
    docker-compose up --build
    ```

    > 💡 **Note:** The `db` service will first run `init-db.sh` (waiting for the database), then automatically execute `01_init.sql` (schema) and `02_data.sql` (data).

2.  **Monitor Logs:** Watch the logs from the `db-1` service. Look for confirmation messages:

      * `db-1 | Database initialization complete.`
      * `web-1 | Application startup complete.`

-----

## 3\. ✅ Verification and Usage

Once the services are running, you can access the application and management tools.

### Step 3.1: Application Frontend

Access the main web application through your browser.

  * **URL:** `http://localhost:8000/`

     

  * **Table Browser:** Access the list of initialized tables:

      * **URL:** `http://localhost:8000/tables`
      * Click on any table name (e.g., `lab_member`, `project`) to see the detailed data inserted from `02_data.sql`.

### Step 3.2: Database Management (PgAdmin)

You can use the built-in PgAdmin service to inspect the database directly.

  * **URL:** `http://localhost:8080/`
  * **Login Credentials:**
      * Email: `admin@example.com`
      * Password: `admin` (or as configured in `docker-compose.yml`)

<!-- end list -->

1.  Add a New Server Connection.
2.  **Connection Details:**
      * Host name/address: `db` (or `localhost` if connecting from outside Docker network, depending on your setup)
      * Maintenance database: `user`
      * Username: `user`
      * Password: `password`

You should now be able to browse the `lab_manager` database, confirm all 13 tables (e.g., `lab_member`, `project`, `usage_log`) exist, and verify the sample data is present.

-----

## 4\. 🛑 Stopping the Services

To stop and clean up the services when you are finished:

  * **Stop Containers:** This keeps the data volume intact (`postgres_data`).
    ```bash
    docker-compose down
    ```
  * **Stop and Clean Data:** Use this command to completely remove the running containers, networks, and the persistent data volume (`postgres_data`). **Use this if you need to re-initialize the database from scratch.**
    ```bash
    docker-compose down --volumes
    ```
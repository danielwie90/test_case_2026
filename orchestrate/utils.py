from urllib.parse import quote_plus


def get_database_connection_string() -> str:
    """Function to fetch the connection string to use to connect to the database.

    Returns
    -------
    str
        The connection string for the database.
    """
    password = quote_plus("Password@123")
    return f"mssql+pyodbc://sa:{password}@localhost:1433/incomedata?driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes"

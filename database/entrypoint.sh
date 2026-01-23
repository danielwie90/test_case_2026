#!/bin/bash
/opt/mssql/bin/sqlservr &
for _ in {1..90}; do
    /opt/mssql-tools18/bin/sqlcmd -S 127.0.0.1 -U sa -P "${SA_PASSWORD}" -C -Q "SELECT 1" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "SQL Server started successfully"
        break
    fi
    sleep 1
done

# Execute the post-deployment script
/opt/mssql-tools18/bin/sqlcmd -S 127.0.0.1 -U sa -P "${SA_PASSWORD}" -C -i /usr/src/app/Script.PostDeployment.sql

if [ $? -ne 0 ]; then
    echo "Error executing Script.PostDeployment.sql"
fi

# Keep the container running by bringing SQL Server to foreground
wait

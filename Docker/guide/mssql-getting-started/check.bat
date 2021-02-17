@ECHO OFF

CALL global_variables.bat
REM docker exec -it mssql_local /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P toce123.

docker exec -it %rname% /bin/bash /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P %PWD%
@ECHO OFF
REM docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=tc' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu
REM docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=tc' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu
REM
REM @see https://hub.docker.com/_/microsoft-mssql-server
REM  mcr.microsoft.com/mssql/server:2017-latest-ubuntu
REM docker run --rm --name toce_sql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=%PWD%' -p 1433:1433 -d toce/mssql_local
REM docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>

SET name=toce-mssql-local
SET rname=toce_sql
SET PWD=toce123@
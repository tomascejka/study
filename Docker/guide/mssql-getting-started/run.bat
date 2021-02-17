@ECHO OFF
REM
REM @see https://hub.docker.com/_/microsoft-mssql-server
REM

CALL global_variables.bat

REM docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=tc' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu
REM docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=tc' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu
REM docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>
REM docker run --name %rname% -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=%PWD%' -p 1433:1433 -d %name%
docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=%PWD% -p 1433:1433 -p 8080:8080 -d %name%
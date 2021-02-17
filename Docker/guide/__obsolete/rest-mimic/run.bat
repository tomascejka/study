@ECHO OFF
REM
REM Skript, kt. lokalne zbuilduje java project via maven, konkretne package goal. Pote 
REM jej zbuilduje docker a vytvori v lokalnim registry image [nazev je nastavovan v 
REM global_variables.bat - abych mohl skripty reusovat i v jinych projektech].
REM
REM @author tomas.cejka
REM 

REM -- nastaveni globalnich promenny
CALL global_variables.bat

REM -- Najde bezici docker container, pokud existuje, tak jej [brutalne/force] smaze
docker ps | findstr "%regName%/%imgName%">foo.txt
set FOO= < foo.txt
IF "%FOO%" EQU [] (
    ECHO [INFO]
	ECHO [INFO] No container is running (from image: %regName%/%imgName%)
	ECHO [INFO]
	REM -- do nothing
) ELSE (
    ECHO [INFO]
	ECHO [INFO] Delete previous container (from image: %regName%/%imgName%)
	ECHO [INFO]
	docker rm -f %imgName%
)
DEL foo.txt


ECHO [INFO]
ECHO [INFO] Run new container (from image: %regName%/%imgName%)
ECHO [INFO]
docker run -d -p 8080:8080 -p 4848:4848 --name %imgName% --env APP_VERSION=1.0-SNAPSHOT %regName%/%imgName%
ECHO .
ECHO [INFO]
ECHO [INFO] Show container running metadata (docker ps)
ECHO [INFO]
docker ps | findstr "%regName%/%imgName% CONTAINER" 
REM -- ...sestavi se souborem s promenymi pro docker image
REM docker run -d -p 8080:8080 -p 4848:4848 --name %imgName% --env-file ./env_file %regName%/%imgName%


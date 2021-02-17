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
docker ps | findstr "%imgCtxName%">foo.txt
set FOO= < foo.txt
IF "%FOO%" EQU [] (
    ECHO [INFO]
	ECHO [INFO] No container is running (from image: %imgCtxName%)
	ECHO [INFO]
	REM -- do nothing
) ELSE (
    ECHO [INFO]
	ECHO [INFO] Delete previous container (from image: %imgCtxName%)
	ECHO [INFO]
	REM @see https://docs.docker.com/engine/reference/commandline/rm/
	docker rm -f %cntName%
)
DEL foo.txt


ECHO [INFO]
ECHO [INFO] Run new container (from image: %imgCtxName%)
ECHO [INFO]
REM -d, viz. https://docs.docker.com/engine/reference/run/#detached--d
REM -p, viz. https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose
REM --name, viz. https://docs.docker.com/engine/reference/run/#name---name
REM --env, viz. https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file
docker run -d -p %httpPort%:8080 -p %adminPort%:4848 --name %cntName% --env APP_VERSION=%appVersion% %imgCtxName%
ECHO .
ECHO [INFO]
ECHO [INFO] Show container running metadata (docker ps)
ECHO [INFO]
docker ps | findstr "%imgCtxName% CONTAINER" 
REM -- ...sestavi se souborem s promenymi pro docker image
REM docker run -d -p 8080:8080 -p 4848:4848 --name %imgName% --env-file ./env_file %regName%/%imgName%


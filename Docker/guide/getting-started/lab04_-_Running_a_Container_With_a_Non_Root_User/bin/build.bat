@echo off
REM
REM Simplest build command in order to create docker image using basic
REM docker command as: '$ docker build' /study links below/
REM
REM @author tomas.cejka
REM 
REM @since lab1
REM
REM @see https://docs.docker.com/engine/reference/commandline/build/
REM @see https://docs.docker.com/engine/reference/commandline/build/#specify-a-dockerfile--f
REM

REM -- setup global variables /first parameter one show all variables in console/
CALL global-variables.bat 1

REM -- Spusti build s dockerfile a build. kontext /oba posunuty o uroven vyse/ a 
REM -- z toho duvodu, ze se tam mohou nalezat dalsi zdroje pro kontainer /tato cesta resp.
REM -- kontext pak odpovida cestam v Dockerfile, dost to ovlivnuje relativni cesty/. Ja vnimam/lepeji se
REM -- nahlizi na laborator z jeho domovskeho adresare, coz je prave o urovne vyse, via ..
REM
REM -- @see https://docs.docker.com/engine/reference/commandline/build/#specify-a-dockerfile--f
REM -- @see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#understand-build-context

ECHO .
ECHO .
ECHO =================== [Choose case] ======================
ECHO .
ECHO   What you wanna build, man:
ECHO .
ECHO     [1] Default no user specified (docker uses root)
ECHO     [2] Using new created user with USER instruction
ECHO     [x] Exit script
ECHO .
ECHO . Need help? Learn README.md. There is more information
ECHO . how to use this laboratory.
ECHO . 
ECHO ========================================================
SET /P UID="Selected case:"
SET CID=CASE_%UID%
GOTO %CID%
:CASE_1
	ECHO --------------------------------------
	ECHO Build dockerfile as ROOT
	ECHO    using file: Dockerfile
	ECHO --------------------------------------
	docker build -f ..\Dockerfile -t %regName%/%imgName%:%tagVersion% ..
	GOTO OUTPUT
:CASE_2
	ECHO --------------------------------------
	ECHO Build dockerfile as specified USER
	ECHO    using file: Dockerfile.rootless
	ECHO --------------------------------------
	docker build -f ..\Dockerfile.rootless -t %regName%/%imgName%:%tagVersion% ..
	GOTO OUTPUT
:CASE_x
    GOTO EOF

:OUTPUT
REM @see https://ss64.com/nt/errorlevel.html
IF %ERRORLEVEL% EQU 0 (
  ECHO ============================================
  ECHO Docker image
  ECHO    name: %imgCtxName%
  ECHO    BUILD SUCCESSFULL
  ECHO ============================================
)

:EOF
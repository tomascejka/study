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
docker build -f ..\Dockerfile -t %regName%/%imgName%:%tagVersion% ..

REM @see https://ss64.com/nt/errorlevel.html
IF %ERRORLEVEL% EQU 0 (
  ECHO ============================================
  ECHO Docker image
  ECHO    name: %imgCtxName%
  ECHO    BUILD SUCCESSFULL
  ECHO ============================================
)
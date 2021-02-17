@ECHO off
REM
REM It is usefull command if you are magician and you wanna play with docker localy 
REM and after game is over it is very usefull clean you local registry using native 
REM docker command: REM '$ docker system prune' which helps you with cleaning your 
REM local docker registry, study link below.
REM
REM @author tomas.cejka
REM 
REM @since lab1
REM
REM @see https://docs.docker.com/engine/reference/commandline/system_prune/
REM

REM -- setup global variables /first parameter one show all variables in console/
CALL global-variables.bat 1

ECHO ---------------------------------
ECHO.
ECHO   Clean unused entities:

IF [%1] == [] (
  ECHO     $ docker system prune -f
  ECHO.
  ECHO ---------------------------------
  ECHO. 
  docker system prune -f
) ELSE (
  ECHO     $ docker system prune -f -a
  ECHO.
  ECHO ---------------------------------
  ECHO.
  docker system prune -f -a
)
ECHO.

ECHO.
ECHO ---------------------------------
ECHO.
ECHO Show images (docker images)
ECHO.
ECHO ---------------------------------
docker images

:EOF

@echo off
REM
REM Simplest build command in order to run docker container. First if there is
REM exist some running container (derived from given image) - if exists it is
REM removed; study links below.
REM
REM @author tomas.cejka
REM 
REM @since lab1
REM
REM @see https://docs.docker.com/engine/reference/run/
REM @see https://docs.docker.com/engine/reference/commandline/run/
REM

REM -- setup global variables /first parameter one show all variables in console/
CALL global-variables.bat 1

:CLEAN_CONTAINER
REM Clean and remove existingc concrete %regName% /no parameter/ container
CALL remove.bat

:RUN_NEW_CONTAINER
REM Execute / create always new container /previous is deleted, using --rm/
REM Try to re-create/start with clean/right-now configured docker container ...
IF [%1] == [] (
  REM -- run container hidden in backgroud (-d parameter)/show container ID
  ECHO ======================================================
  ECHO Run: DETACHED
  ECHO   $ docker run --rm -d ^^ 
  ECHO           --name %regName% ^^
  ECHO           %imgCtxName%
  ECHO ======================================================
  docker run --rm -d --name %regName% %imgCtxName%
) 
IF [%1] EQU [1] (
  REM -- run container interactivelly (including parameter -it) WITHOUT attaching BASH
  ECHO ======================================================
  ECHO Run: WITHOUT bash
  ECHO   $ docker run --rm -it ^^ 
  ECHO           --name %regName% ^^
  ECHO           %imgCtxName%
  ECHO ======================================================
  docker run --rm -it --name %regName% %imgCtxName%
) 
IF [%1] EQU [2] (
  REM -- run container interactivelly (including parameter -it) WITH attached BASH!!!
  ECHO ======================================================
  ECHO Run: WITH bash
  ECHO   $ docker run --rm -it ^^ 
  ECHO           --name %regName% ^^
  ECHO           %imgCtxName% bash
  ECHO ======================================================
  docker run --rm -it --name %regName% %imgCtxName% bash
)

ECHO Show container running metadata (docker ps)
docker ps | findstr "%imgCtxName% CONTAINER"

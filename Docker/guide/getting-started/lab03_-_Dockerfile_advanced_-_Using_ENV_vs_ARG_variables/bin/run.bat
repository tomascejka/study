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

ECHO ========================================================
ECHO What do ya wanna do, man:
ECHO .
ECHO [1] using overlay via parameter (-e "COUNT=1")
ECHO [2] using overlay via file (--env_file, COUNT=5)
ECHO [3] none enviroment overlay (use dockerfile's default, COUNT=3))
ECHO .
ECHO ========================================================
SET /P UID="Selected case:"
SET CID=CASE_%UID%
GOTO %CID%

:CASE_1
  ECHO Count of called ICMP ping command will by only ONE
  SET command=-e "COUNT=1"
  GOTO RUN_VARIATION
:CASE_2
  ECHO Count of called ICMP ping command will by only FIVE TIMES
  SET command=--env-file=../resources/envfile
  GOTO RUN_VARIATION
:CASE_3
  ECHO Count of called ICMP ping command will by only THREE TIMES
  SET command=
  GOTO RUN_VARIATION 

:RUN_VARIATION
REM -- Script run.bat is able to be run with three options:
REM --  * none - container is executed DETACHED /v tomto pripade nesmysl... my zjistujeme, kolikrat byl ping spusten/
REM --  * 1    - container is executed interactively WITHOUT BASH
REM --  * 2    - container is executed interactively WITH BASH
IF [%1] == [] (
  ECHO -- DETACHED
  docker run --rm -d --name %regName% %command% %imgCtxName%
) 
IF [%1] EQU [1] (
  ECHO --  interactively WITHOUT bash
  docker run --rm -it --name %regName% %command% %imgCtxName%
) 
IF [%1] EQU [2] (
  ECHO --  interactively WITH bash
  docker run --rm -it --name %regName%  %command% %imgCtxName% bash
) 

:SHOW_RUNNING_CONTAINERS
ECHO Show container running metadata (docker ps)
docker ps | findstr "%imgCtxName% CONTAINER"

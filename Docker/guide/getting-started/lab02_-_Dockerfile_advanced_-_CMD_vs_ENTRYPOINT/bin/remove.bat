@echo off
REM
REM There is a small crap-based problem in laboratory to run repeatable image with same name /easiest way to run
REM docker container without any next complexity in support scripts/. See links below how I have done that. 
REM
REM There is variou ways how to do that:
REM   * no parameter - there will be find and removed conrete container
REM   * 1 -  script has global context; remove all existing stopped containers!!!
REM
REM @author tomas.cejka
REM 
REM @since lab2
REM
REM @see https://docs.docker.com/engine/reference/commandline/rm/
REM

REM -- setup global variables /first parameter one show all variables in console/
CALL global-variables.bat

IF [%1] == [] (
ECHO ======================================
ECHO   Remove only specific container
ECHO   id: %regName%
ECHO ======================================
docker rm --force %regName%
GOTO EOF
)

IF [%1] EQU [1] (
REM @see https://stackoverflow.com/questions/27624252/how-to-set-a-sqlcmd-output-to-a-batch-variable
for /f %%a in ('docker ps -a -q') do SET ids=%%a
ECHO ======================================
ECHO   Remove all stopped containers
ECHO   ids: %ids%
ECHO ======================================
docker rm --force %ids%
GOTO EOF
)

:EOF
@echo off
REM
REM Sometimes you need to look into container / inside using console via bash... you can
REM
REM @author tomas.cejka
REM 
REM @since lab3
REM
REM @see https://docs.docker.com/engine/reference/commandline/exec/
REM
REM -- setup global variables /first parameter one show all variables in console/
CALL global-variables.bat 1

ECHO =================== [Choose case] ======================
ECHO .
ECHO   What you wanna check, man:
ECHO .
ECHO     [1] Using bash console using 'exec -it bash'
ECHO         Notice: container must run
ECHO     [2] Check state of image using 'inspect'
ECHO     [x] Exit script
ECHO .
ECHO . Need help? Learn README.md. There is more information
ECHO . how to use this laboraty.
ECHO . 
ECHO ========================================================
SET /P UID="Selected case:"
SET CID=CASE_%UID%
GOTO %CID%
:CASE_1
	REM Execute interactive console using bash inside container
	CALL docker exec -it %regName% bash
	GOTO EOF
:CASE_2
    REM check
	CALL docker image inspect %imgCtxName% 
	GOTO EOF
:CASE_x
    GOTO EOF

:EOF


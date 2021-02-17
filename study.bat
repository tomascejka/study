echo off
rem --
rem -- Zaklada projekt, ktery chci dale rozvinout. Muze to byt cokoliv, napr. studium noveho framework/knihovny, jazyka apod.
REM --
rem -- Changelog:
rem -- ==========
rem -- 1.0 (15.02.2017, cejka) Vznik skriptu
rem --
rem -- @version 1.0
rem -- @since 15.02.2017
rem --

TITLE Start STUDY project
mode con:cols=97 lines=55

:PROJECT_CREATE
setlocal enableextensions
call styrax_logo.bat
call study_global_variables.bat

:CHOOSE_OPERATION
echo "[INFO]"
echo "[INFO] --------------------------------"
echo "[INFO] Generate study project: "
echo "[INFO] --------------------------------"
echo "[INFO]    [1] Create new study project"
echo "[INFO]    [2] Create new task for project"
echo "[INFO]    [x] exit script"
echo "[INFO] --------------------------------"
echo "[INFO]"
SET /P PID="[INFO] Choose a option: "

rem --
rem -- Vyber danou %PID%
rem --
GOTO CASE_%PID%
:CASE_1
	SET /P PROJECT_NAME="Write your name of project: "
	call study_create_project.bat %PROJECT_NAME% %ROOT_PROJECT_PATH%
	echo "[INFO]"
	echo "[INFO] Project created - %ROOT_PROJECT_PATH%\%PROJECT_NAME%"
	echo "[INFO]"
	goto END
:CASE_2
	call study_create_task.bat
	echo "[INFO]"
	echo "[INFO] Task created"
	echo "[INFO]"
	goto END
	goto END	
:CASE_x
    echo "[INFO] Script has been closed"
	goto EOF

:END
cls
goto CHOOSE_OPERATION
:EOF
exit
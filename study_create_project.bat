echo off
REM --
REM -- Zaklada adresar na disku pro projekt, kt. chci dale rozvinout/nastudovat
REM --
REM -- Changelog:
REM -- ==========
REM -- 1.0 (28.03.2017, cejka) Vznik skriptu
REM --
REM -- @version 1.0
REM -- @since 28.03.2017
REM --

setlocal enableextensions
call study_global_variables.bat

REM --
REM -- pokud je parametr null
REM -- @see https://ss64.com/nt/if.html
REM --
IF [%1] EQU [] (
	echo "[ERROR] Input parameter : Project Name is null"
	goto EOF
)
IF [%2] EQU [] (
	echo "[ERROR] Input parameter : Project filepath location is null"
	goto EOF
)

REM -- nazev noveho projektu
set PROJECT_DIR=%1
REM -- cesta k novemu projektu
set ROOT_PROJECT_PATH=%2

rem -- ostatni promenne
set PROJECT_PATH=%ROOT_PROJECT_PATH%\%PROJECT_DIR%

:CREATE_DIRS
echo "[INFO]"
echo "[INFO] Create projects' dirs"
echo "[INFO]"
md %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%BIN_DIR%
md %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%DOC_DIR%
md %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%TMP_DIR%
md %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%WORK_DIR%

:CREATE_TASKIDFILE
REM -- cesta k souboru, kt. drzi posledni pouzite id tasku a zaroven ulozeni init id (s hodnotou 0) tasku
echo "[INFO]"
echo "[INFO] Save init task_id: 0"
echo "[INFO]"
set ID_TASK_FILEPATH=%ROOT_PROJECT_PATH%\%PROJECT_DIR%\%WORK_DIR%\%ID_TASK_FILENAME%
echo 0 > %ID_TASK_FILEPATH% 2>&1

:CREATE_README
REM -- vytvoreni README.md souboru
echo "[INFO]"
echo "[INFO] Create README file"
echo "[INFO]"
(
echo # %PROJECT_DIR%
echo .
echo ## Popis:
echo analyza problemu/projektu/myslenky ...
echo .
echo ## Repository:
echo popis priciny ...
echo .
echo ## POZN:
echo pripadne poznamky ...
) > %PROJECT_PATH%\README.md
goto END_CASE

:END_CASE
echo "[INFO]"
echo "[INFO] -------------------------------------------"
echo "[INFO] Project %PROJECT_DIR% successfully created"
echo "[INFO] -------------------------------------------"
echo "[INFO]"
pause
goto EOF

:EOF
echo "[INFO] Create project script has been closed"
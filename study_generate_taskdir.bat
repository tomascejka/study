echo off
REM --
REM -- Zaklada adresar na disku pro konkretni ukol v ramci specifickeho projektu (adresare), kt. chci dale rozvinout/nastudovat
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

REM -- cesta k souboru, kt. drzi posledni pouzite id tasku
set ID_TASK_FILEPATH=%ROOT_PROJECT_PATH%\%PROJECT_DIR%\%WORK_DIR%\%ID_TASK_FILENAME%

REM -- precteni posledniho pouziteho idcka
set /P TASK_ID=<%ID_TASK_FILEPATH%
REM -- navyseni cisla pro generovani id tasku
set /A NEXT_TASK_ID=%TASK_ID%+1
REM -- paddovani zleva nulami do maxima 4 pozic, rozsah 0001-9999
set VarID=000%NEXT_TASK_ID%
set VarID=%VarID:~-4%

echo "[INFO] -----------------------------------------------"
echo "[INFO] "
echo "[INFO] Write task name (mandatory) and description (optional)"
echo "[INFO] "
echo "[INFO] -----------------------------------------------"
set /P TASK_NAME="[INFO] Write task name: "
REM -- replacing space by underscore
set TASK_NAME=%TASK_NAME: =_%
set /P TASK_DESC="[INFO] Write task description(optional): "

set TASK_DIR="%PROJECT_DIR%-%VarID%_-_%TASK_NAME%"
echo "[INFO] -----------------------------------------------"
echo "[INFO] "
echo "[INFO] Generate task"
echo "[INFO]     for project: %PROJECT_DIR%"
echo "[INFO]         task id: %VarID%"
echo "[INFO] "
echo "[INFO] -----------------------------------------------"
md %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%WORK_DIR%\%TASK_DIR%
REM -- ulozeni aktulaniho/posledniho pouziteho id tasku
echo "[INFO] Save current task_id: %NEXT_TASK_ID%"
(
echo %NEXT_TASK_ID%
) > %ID_TASK_FILEPATH% 2>&1

REM -- vytvoreni README.md souboru
(
echo # %TASK_DIR%
echo.
echo ## Popis
echo %TASK_DESC%
echo.
echo ## ANALYZA:
echo analyza problemu ...
echo .
echo ## PRICINA:
echo popis priciny ...
echo .
echo ## FIXED:
echo popis opravy ...
echo .
echo ## POZN:
echo pripadne poznamky ...
) > %ROOT_PROJECT_PATH%\%PROJECT_DIR%\%WORK_DIR%\%TASK_DIR%\README.md

pause
:CLOSE_SCRIPT
exit

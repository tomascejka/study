echo off
REM --
REM -- Vybira adresar na disku pro projekt, a dale vytvori novy ukol
REM --
REM -- Changelog:
REM -- ==========
REM -- 1.0 (28.03.2017, cejka) Vznik skriptu
REM --
REM -- @PROJECT_PATHion 1.0
REM -- @since 28.03.2017
REM --

setlocal enableextensions
SETLOCAL ENABLEDELAYEDEXPANSION
call study_global_variables.bat

echo "[INFO]"
echo "[INFO]---------------------------------------------"
echo "[INFO] List of projects"
echo "[INFO]---------------------------------------------"
echo "[INFO]"
cd %ROOT_PROJECT_PATH%
set /a counter=0
for /d %%i in (*) do (
  rem -- nastaveni citace/id na kt. se pak mohu odkazovat
  set /a counter=!counter!+1
  rem -- nastaveni hodnoty pro dany citac/id na ktery se pak mohu odkazovat
  set id_!counter!=%%i
  echo "[INFO]  [!counter!] %%i"
)
echo "[INFO]  [x] Close script"
echo "[INFO]---------------------------------------------"
set /p PROJECT_ID="[INFO] Select your project,eg. 1:"
echo "[INFO]---------------------------------------------"
if "%PROJECT_ID%"=="x" (
	goto EOF
)
set PROJECT_PATH=!id_%PROJECT_ID%!
goto CREATE_TASK

:CREATE_TASK
echo "[INFO]"
echo "[INFO]---------------------------------------------"
echo "[INFO] Create task for %PROJECT_PATH%"
echo "[INFO]    in %ROOT_PROJECT_PATH%\%PROJECT_PATH%"
echo "[INFO]---------------------------------------------"
echo "[INFO]"
call study_generate_taskdir.bat %PROJECT_PATH% %ROOT_PROJECT_PATH%
pause
goto EOF

:EOF
echo "[INFO] Create task script has been closed"

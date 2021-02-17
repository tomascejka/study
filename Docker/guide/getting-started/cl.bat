@echo off
REM --
REM -- Vytvori studijni sub-projekt tzv. "LAB" - pro overeni dane myslenky
REM --
REM -- @author tomas.cejka
REM -- @version 1.00
REM -- @since lab1
REM --

SETLOCAL enableextensions
SETLOCAL enableDelayedExpansion

REM -- baseline adresář, každý si dá svou lokaci na HDD
SET LAB_HOME=f:\Study\Docker\guide\getting-started
REM -- unikatni id laboratoře, kt. figuruje v názvu adresáře
set ID_LAB_FILENAME=lab_id
REM -- plná cesta k souboru, kt. si pamatuje poslední vygenerované číslo laboratoře
set ID_LAB_FILEPATH=%LAB_HOME%\%ID_LAB_FILENAME%
REM -- pokud jsem tak znalý, že skripty si píši sám tak nastav na 1
reM -- nebudou se do labu kopírovat defaulty z /temp, viz. navesti COPY_BATCH
SET NIGHTMARE_MODE=0

REM -- Ladici rezim /uzitecne pri hledani chyb nebo novych vlastnosti/
REM -- kdyz je GANJA_MODE=1 ladim chyby/novinky
IF [%1] == [] (
	SET GANJA_MODE=0
) ELSE (
    SET GANJA_MODE=1
)

:GRAPHICS
ECHO ================================================
ECHO .
ECHO   Welcome,
ECHO .
ECHO   ..create own laboratory for your 
ECHO   super fantastic idea!
ECHO .
ECHO   Happy learning, man!
ECHO .
IF [%GANJA_MODE%] EQU [1] (
	ECHO --// ----xx-
	ECHO  [WARNING] - You are in debugging mode!
	ECHO --\\ ----xx-
)
ECHO .
ECHO ================================================

:INIT_LAB
REM -- v pripade, ze soubor s posledním vygenerovaným číslem laboratoře neexistuje
REM -- vytvoří se, stane se právě jednou
IF EXIST %ID_LAB_FILEPATH% (
  REM -- soubor existuje, jdi vytvořit laboratoř
  GOTO CREATE_LAB_NAME
) ELSE (
  REM -- soubor neexistuje, vytvoř jej a zapiš 0 jako výchozí stav
  GOTO CREATE_LAB_IDFILE
)

:CREATE_LAB_IDFILE
REM -- cesta k souboru, kt. drzi posledni pouzite id lab-u a zaroven ulozeni init id (s hodnotou 0) lab
echo " Save init task_id: 0"
echo 0 > %ID_LAB_FILEPATH% 2>&1

:CREATE_LAB_NAME
REM -- precteni posledniho pouziteho idcka
set /P LAB_ID=<%ID_LAB_FILEPATH%
REM -- navyseni cisla pro generovani id tasku
set /A NEXT_LAB_ID=%LAB_ID%+1
REM -- paddovani zleva nulami do maxima 1 pozic, rozsah 00-99
set VarID=00%NEXT_LAB_ID%
set VarID=%VarID:~-2%
SET /P LAB_NAME= Name of lab:
REM -- replacing space by underscore
SET LAB_NAME=%LAB_NAME: =_%
SET CLAB_NAME=lab%VarID%_-_%LAB_NAME%
REM -- Ulozeni posledniho pouziteho id tasku 
REM -- /pouze kdyz to neni ladici mod/
IF [%GANJA_MODE%] EQU [0] (	
	echo  Save current lab_id: %NEXT_LAB_ID%
	(
	echo %NEXT_LAB_ID%
	) > %ID_LAB_FILEPATH% 2>&1
)

:CREATE_DIRS
ECHO   ---------------------------- 
ECHO     Create lab:
ECHO        %CLAB_NAME%
ECHO   ---------------------------- 
SET LAB_PATH=%LAB_HOME%\%CLAB_NAME%
SET SUB_DIRS=bin,temp,www,resources
mkdir %LAB_PATH%
FOR %%G IN (%SUB_DIRS%) DO (mkdir %LAB_PATH%\%%G)

:COPY_BATCH
REM -- pouze v pripade, ze NIGHTMARE_MODE je nahozen na 0, pak 
REM -- zkopiruji *.bat soubory do /bin v dane laboratori
IF [%NIGHTMARE_MODE%] == [0] (
REM COPY /?
REM /Y Suppresses prompting to confirm you want to overwrite an existing destination file.
REM /V Verifies that new files are written correctly.
ECHO  Copy support script files
ECHO .
COPY temp\*.bat /Y /V %LAB_PATH%\bin
)

:CREATE_README
REM -- vytvoreni README.md souboru
ECHO .
ECHO  Create README file
(
echo # %CLAB_NAME%
echo .
echo ## Přehled
echo Krátký přehled o dané laboratoři o jejím cíli ...
echo .
echo ## Předpoklady
echo Popiš, co je nutné mít dříve, než začneš s touto laboratoří experimentovat ...
echo .
echo ## Poznámky
echo Zde popiš cestu k cíli, jak danou laboratoř používat ...
echo .
echo ## Závěr
echo Zde napiš k čemu si dospěl... ideálně
echo .
echo ## Zdroje
echo Ideální stav je popsat, z jakých zdrojů si vycházel - tzn. ověřitelnost tvých postupů ...
) > %LAB_PATH%\README.md

:CREATE_DOCKERIGNORE
REM -- vytvoreni .dockerignore souboru s předem daným entitami, lze si jej pochopitelně obohacovat
REM -- o další soubory, složky apod.
echo  Create dockerignore file
(
echo # ignoruj www, bat a txt soubory
echo bin
echo www
echo src
echo temp
echo !target/*.war
echo *.bat
echo *.md
echo *.sh
echo *.txt
echo *.xml
) > %LAB_PATH%\.dockerignore

:CREATE_DOCKERFILE
REM -- vytvoření úplně základního Dockerfile souboru, používám zde Alpine Linux, 
REM -- protože se snažím o co minimální trafic a jednoduchost - ta image ma 5MB 
REM -- lze ji samozřejmě změnit
echo  Create Dockerfile file
(
echo #
echo # @see https://docs.docker.com/engine/reference/builder/ oficialni dockerfile reference documentation
echo #
echo FROM alpine:latest
echo.
echo # Install bash because it can be used in CMD/ENTRYPOINT instructions /which we will use in docker run phase/
echo # @see https://stackoverflow.com/questions/44803982/how-do-i-run-a-bash-script-in-an-alpine-docker-container/44804509#44804509
echo RUN apk add --no-cache --upgrade bash
echo.
echo CMD ["/bin/sh"]
) > %LAB_PATH%\Dockerfile.txt
REM -- jinak neumim, nelze vytvorit soubore bez pripony
mv %LAB_PATH%\Dockerfile.txt %LAB_PATH%\Dockerfile

IF [%GANJA_MODE%] EQU [1] (
	GOTO DELETE_AFTER_DEBUG
) ELSE (
	GOTO FINISH
)

:DELETE_AFTER_DEBUG
REM -- V pripade, ze si preju ladit nove funkce, nebo chybu
REM -- tak chci umoznit, abych vzniknuvsi laborator mohl smazat
ECHO ================================================
ECHO Do you wish delete laboratory?
ECHO  [1] yes, delete (including subdirs)
ECHO  [2] no, close a script
ECHO ================================================
SET /P ALLOW_DEL="Select options:"
SET CID=CASE_%ALLOW_DEL%
:CASE_1
  RMDIR /S /Q %LAB_PATH%
  ECHO ----------------------------------------------
  ECHO Delete: %CLAB_NAME%
  ECHO    has been SUCCESSFULL
  ECHO ----------------------------------------------
  GOTO EOF
:CASE_2
  GOTO EOF

:FINISH
IF %ERRORLEVEL% EQU 0 (
  ECHO ============================================
  ECHO Create: %CLAB_NAME%
  ECHO    has been SUCCESSFULL
  ECHO ============================================
)

:EOF
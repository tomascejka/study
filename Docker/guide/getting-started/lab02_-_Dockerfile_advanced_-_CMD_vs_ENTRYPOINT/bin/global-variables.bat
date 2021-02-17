@echo off
REM
REM Setup global variables - it is useful /nothing else .../, eg.
REM setup completely image+tag name, using pattern: regName/imageName:tagName
REM
REM @author tomas.cejka
REM 
REM @since lab1
REM

REM
REM -- je nutne nahradit za unikatni nazev /laboratore idealne, napr. tc_lab1/
REM -- je to nazev, pod kt. bude image ulozena v registru docker image, napr. docker hub
REM
SET regName=tc_lab2
IF %regName%==NAHRAD_ME_KAMO (
ECHO ------------------------------------
ECHO Zmen hodnotu v promene 'regName' 
ECHO  z 'NAHRAD_ME_KAMO' za nejaky unikatni nazev!!!!
ECHO  napr. laboratore idealne, napr. tc_lab1
ECHO ------------------------------------
GOTO EOF
)

REM -- nazev image
SET imgName=alpine-started
REM -- nazev tagu/verse -- vyber si jak na to budes nahlizet
SET tagVersion=latest
REM -- nazev image, pod kterym bude ulozena v registru /local a pak i remote/
SET imgCtxName=%regName%/%imgName%:%tagVersion%

REM -- pokud existuje alespon jeden paramert /zjednoduseni/, pak vypis na vystup
IF [%1] == [] ( 
  echo. 
) ELSE (
  echo =========== global variables: ==========
  echo regName   : %regName%
  echo imgName   : %imgName%
  echo tagVersion: %tagVersion%
  echo imgCtxName: %imgCtxName%
  echo ==========================================
)

:EOF

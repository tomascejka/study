@ECHO OFF
REM
REM Skript, kt. lokalne zbuilduje java project via maven, konkretne package goal. Pote 
REM jej zbuilduje docker a vytvori v lokalnim registry image [nazev je nastavovan v 
REM global_variables.bat - abych mohl skripty reusovat i v jinych projektech].
REM
REM @author tomas.cejka
REM 

REM -- nastaveni globalnich promenny
CALL global_variables.bat

REM -- lokalni build via maven a pote docker build [proneseni zmen zdrojaku do image]
mvn clean package && docker build -t %regName%/%imgName% .
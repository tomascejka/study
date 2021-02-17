@ECHO OFF

CALL global_variables.bat

docker build -t %name% .
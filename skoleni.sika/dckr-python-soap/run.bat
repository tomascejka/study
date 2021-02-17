@echo off

call .\bin\global_var.bat

REM -- build docker container
call .\bin\dock.bat

REM -- call curl endpoint
REM -- call .\bin\call.bat
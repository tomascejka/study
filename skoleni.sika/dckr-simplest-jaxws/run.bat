@echo off

call d:\Study\skoleni.sika\dckr-simplest-jaxws\bin\global_var.bat

REM -- build application via maven
call .\bin\build.bat

REM -- build docker container
call .\bin\dock.bat

REM -- call curl endpoint
call .\bin\call.bat
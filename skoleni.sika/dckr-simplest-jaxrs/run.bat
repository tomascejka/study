@echo off

call __global_var

REM -- build application via maven
call build.bat

REM -- build docker container
call dock.bat

REM -- call curl endpoint
call call.bat
@echo off

call __global_var

REM -- build application via maven
call build.bat

set tagv=1
set tname=%iname%:%tagv%

call docker build -t %gname%/%tname% .
call docker rm -f %iname%
call docker run -d -p %hport%:8080 --name %iname% %gname%/%tname%
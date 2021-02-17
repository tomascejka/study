@echo off

call global_var.bat

set tagv=1
set tname=%iname%:%tagv%

call docker build -t %gname%/%tname% .
call docker rm -f %iname%
call docker run -d -p %hport%:8080 -p 9990:9990 --name %iname% %gname%/%tname%
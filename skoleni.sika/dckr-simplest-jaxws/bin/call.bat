@echo off

call global_var.bat

set API_NAME=SimplestWebServiceApi
echo.
echo "Call - http://localhost:%hport%/%iname%/%API_NAME%?wsdl"
echo.

curl -v http://localhost:%hport%/%iname%/%API_NAME%?wsdl
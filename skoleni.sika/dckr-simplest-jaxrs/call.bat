@echo off

call __global_var
echo.
echo "Call - http://localhost:%hport%/%iname%/resources/user"
echo.
curl -v http://localhost:%hport%/%iname%/resources/user
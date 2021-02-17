@ECHO OFF

REM -- nastaveni globalnich promenny
CALL global_variables.bat

REM -- chvili pockame nez se war nahraje
TIMEOUT /T 5
REM SLEEP 5
REM -- zkusime zda server odpovi, apka je napsana, ze vrati Hello pozdrav
ECHO [INFO] Call endpoint - curl http://localhost:%httpPort%/%contextName%/resources/ping
REM @see https://curl.haxx.se/docs/httpscripting.html#GET
curl http://localhost:%httpPort%/%contextName%/resources/ping
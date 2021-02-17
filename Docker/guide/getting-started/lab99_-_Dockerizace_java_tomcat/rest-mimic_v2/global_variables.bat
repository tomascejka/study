@ECHO OFF
REM
REM Nastaveni globalnich hodnota, ktere pouzivam ve skriptech
REM 

REM -- 
REM -- Promenne pro docker build prikaz, tzn. vytvoreni image
REM -- napr. docker build -t %regName%/%imgName%:%tagVersion%
REM --
REM -- An image name is made up of slash-separated name components, optionally prefixed by a registry hostname.
REM --
REM -- @see https://docs.docker.com/engine/reference/commandline/tag/
REM
SET regName=toce
SET imgName=restmimic
SET tagVersion=2
REM -- verse aplikace, kt. by musi korelovat s versi v pom.xml - jinak nenastartujes kamo
SET appVersion=%tagVersion%.0

REM --
REM -- Nastaveni networking u aplikacniho serveru
REM --
REM -- @see https://www.robvanderwoude.com/battech_math.php
REM --
REM offset pro networking, toze cilovym resenim je mit az n-serveru
SET offset=1000%tagVersion%
REM tcp/port, na kt. je tomcat dostupny zvenku, port nat/forwarding
SET httpPort=8080
SET /a httpPort+=%offset%
REM tcp/port, na kt. je tomcat-admin console dostupna zvenku
SET adminPort=4848
SET /a adminPort+=%offset%
REM --context name, kt. bude pouzivat v url
set contextName=%imgName%-%appVersion%

REM --
REM -- Dodatecne pomocne promenne
REM --
SET imgCtxName=%regName%/%imgName%:%tagVersion%
SET cntName=%imgName%_v%tagVersion%
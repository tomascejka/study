@ECHO OFF
REM
REM Nastaveni globalnich hodnota, ktere pouzivam ve skriptech
REM 

REM -- 
REM -- Promenne pro docker build prikaz, tzn. vytvoreni image
REM -- napr. docker build -t %regName%/%imgName%
REM --
REM -- An image name is made up of slash-separated name components, optionally prefixed by a registry hostname.
REM --
REM -- @see https://docs.docker.com/engine/reference/commandline/tag/
REM
SET regName=toce
SET imgName=restmimic
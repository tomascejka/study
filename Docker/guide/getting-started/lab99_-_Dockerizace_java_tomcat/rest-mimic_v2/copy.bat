@ECHO OFF

REM -- nastaveni globalnich promenny
CALL global_variables.bat

docker cp %cntName%:/usr/local/tomcat/conf/tomcat-users.xml ./temp
REM docker cp %cntName%:/usr/local/tomcat/conf/server.xml ./temp
REM docker cp %cntName%:/usr/local/tomcat/conf/context.xml ./temp
REM docker cp %cntName%:/usr/local/tomcat/conf/catalina.properties ./temp
REM docker cp %cntName%:/usr/local/tomcat/conf/logging.properties ./temp
@ECHO OFF

REM -- nastaveni globalnich promenny
CALL global_variables.bat

docker cp %cntName%:/usr/local/tomcat/conf/web.xml ./temp
docker cp %cntName%:/usr/local/tomcat/conf/server.xml ./temp
docker cp %cntName%:/usr/local/tomcat/conf/context.xml ./temp
docker cp %cntName%:/usr/local/tomcat/conf/catalina.properties ./temp
docker cp %cntName%:/usr/local/tomcat/conf/logging.properties ./temp
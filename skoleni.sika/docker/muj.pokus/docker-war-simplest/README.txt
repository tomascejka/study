
2. navod jak pridat rychle WAR do dockerfile - https://github.com/goldmann/wildfly-docker-deployment-example
3. WAR soubor, hledal jsem nejaky oficialni docker hello world, http://tomcat.apache.org/tomcat-10.0-doc/appdev/sample/
4. pak jsem upravil Dockerfile na (pridal jsem war z bodu 3)
FROM jboss/wildfly
ADD sample.war /opt/jboss/wildfly/standalone/deployments/
--
5. pak jsem postupoval dle manualu bod 2
- docker build --tag=simple-war .
- docker run --name war -it -p 8080:8080 simple-war
6. pak jsem spustil prohlizec viz. http://localhost:8080/sample/ (adresu jsem si vzal z webu viz. bod 3)2
	- zobrazila se mi html stranka z WAR souboru ve wildfly

7. pak jsem zkusil volani jako deamon
 - docker run --name war -d -p 8080:8080 simple-war
 - curl http://localhost:8080/sample
 - a vidim html zdrojak
--
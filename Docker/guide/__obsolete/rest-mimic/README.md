# Dockerizace Tomcat server
Snahou je mit receptař (rozuměj minimalistický průvodce), jak zdokerizovat java project jedoucí na Tomcat serveru.

## Maven archetype startup
Z konsole jsem spustil generoveni z archetypu
```bash
mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp
```
Zdroj - https://maven.apache.org/archetypes/maven-archetype-webapp/
--

## Úprava pom.xml

### Maven WAR plugin
Pridal jsem maven plugin
```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.3</version>
  </plugin>
```
Zdroj - https://maven.apache.org/plugins/maven-war-plugin/plugin-info.html#usage
--

### JAX-RS konfigurace
Nechci pouzivat web.xml, viz. https://myshadesofgray.wordpress.com/2014/04/27/restful-web-service-using-jersey-and-no-web-xml/
```xml
<properties>
  <!-- omit for brevity ... -->
  <failOnMissingWebXml>false</failOnMissingWebXml>
<properties>
```
Pak je nutne pridat tridu, kt. ma anotaci 'javax.ws.rs.ApplicationPath' a pouziva 'javax.ws.rs.core.Application'
```java
@ApplicationPath("resources")//tohle zaridi,ze nemusis resit nastaveni serveltu v web.xml
public class JAXRSConfiguration extends Application {

}
```
--
### Jersey konfigurace/zavislosti
Vybral jsem Jersey (dotahne si transitivne i jaxrs-api), abych jej pak pouzil v Tomcat server-u.
```xml
<dependency>
    <groupId>org.glassfish.jersey.containers</groupId>
    <artifactId>jersey-container-servlet</artifactId>
    <version>2.30.1</version>
</dependency>
```
Zdroj - https://eclipse-ee4j.github.io/jersey.github.io/documentation/latest/modules-and-dependencies.html
--

### Dockerizace Java WAR aplikace
Nejdříve jsem vytvořil .dockerignore soubor, abych do build-u nezahrnoval soubory/adresáře, kt. do něj nepatří[1]. Poté jsem vytvořil Dockerfile soubor, kterým jsem se inspiroval[2].
```bash
FROM tomcat:8.5.41-jre8-alpine
# omit for brevity 
```
Poté jsem vytvořil soubor env_file s proměnnými, kt. používám v Dockerfile a potřebuji je nastavovat každým buildem[3,4]. Nakonec jsem skončil
po revizi u jedne proměnne, tak jsem začal používat pouze parametr --env[4].

Zdroje
1. https://codefresh.io/docker-tutorial/not-ignore-dockerignore-2/
2. https://codefresh.io/Docker-Tutorial/dockerize-java-application/
3. https://vsupalov.com/docker-arg-env-variable-guide/
3. https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file
4. https://www.youtube.com/watch?v=P6Bk3Eiz3kE&t=199s
--
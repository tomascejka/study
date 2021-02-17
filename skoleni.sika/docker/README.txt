Školení docker
Místnost: https://meet.google.com/ujz-kqpd-aup, od:09:00 – 17:00
Školitel - Ondřej Šika, https://ondrej-sika.cz/doporuceni/

26.1.20212

•	Vrstva na kernelovými voláními
•	Kontejnery jsou separátní prostory
o	Procesní
o	Paměťový
o	Síťový
o	Chová se to jako by to běželo na izolovaném stroji byť na jednom HARDWARE
•	Image má všechno v sobě (včetně závislostí – od OS přes aplikační runtime až po samotnou aplikací)
o	Dá se verzovat, používají se TAG-y
o	Jako konfigurovat 
	Aplikaci v něm běžící – jak to dělat správně
o	Nevýhody
	Podpora v AWS oddělení docker vs VM
•	Jak má vypadat kontainerizace, viz. https://opencontainers.org/
•	Jak psát microservice appky, viz. https://12factor.net/

Základy

Systém info
•	docker run hello-world
•	docker version - print version
•	docker info - system wide information
•	docker system df - docker disk usage
•	docker system prune - cleanup unused data
o	docker system prune –a (smaže i images, ne ty použité, lze použít na PROD)
o	docker system prune –-volume (bacha smaže neaktivní volumes, kt. zrovna nikdo nepoužívá)
Docker images
•	docker pull <image> - download an image
•	docker image ls - list all images
•	docker image ls -q - quiet output, just IDs
•	docker image ls <image> - list image versions
•	docker image rm <image> - remove image

•	docker image history <image> - show image history
•	docker image inspect <image> - show image properties
Registr docker
•	https://hub.docker.com/ - remote registr (mimo firmu)
•	Jak to funguje v Azure – aby se během CI/CD tahaly z Azure – mluvím o našich IMAGES
•	https://goharbor.io/ nástroj pro správu, práci s docker registry
•	Muj scope:
o	https://hub.docker.com/r/jboss/wildfly
	Má vespod:
•	W21 - https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile
•	JDK - https://github.com/jboss-dockerfiles/base-jdk/blob/jdk8/Dockerfile
•	CENTOS - https://github.com/jboss-dockerfiles/base/blob/master/Dockerfile
o	docker pull jboss/Wildfly
o	pro spusteni a pridani WAR souboru - https://github.com/goldmann/wildfly-docker-deployment-example
	soubor (pro jistotu, jsem použil) WAR z oficiálního Tomcat repo:
•	http://tomcat.apache.org/tomcat-10.0-doc/appdev/sample/
o	https://stackify.com/guide-docker-java/

Konfigurace
•	Volumes nejsou vhodne
•	Lepší env-variables, které vše popíší
•	Securitas (hesla a přístupy) v remote VAULT secret management, např. VAULT HashCorp
•	docker run debian env – vypíše proměnné
Restart policy
•	nastudovat, jak to použít
•	docker run –restart=always debian –c „sleep 5“
•	docker run –restart=always debian –c „sleep 5 && false“ (pro ladění, když restart on-failure)
Docker Exec
•	aka SSH přístup do běžícího kontejneru
Logování
•	přepnout ze server.log na standartní výstup v Docker, tzn. stdout
•	vytáhnout ven via logovací driver:
o	 elasticstack je standart
•	logování není omezen na velikost, max-počet souborů, rotaci lze nastavit via parametry, priklad: ondrejsika/log-rotation , viz. https://github.com/ondrejsika/docker-training#json-file-default-log-driver
docker inspect
Zdroj - https://github.com/ondrejsika/docker-training#docker-inspect
•	najdeš stav kontejneru
•	informace o síti (pouze pokud kontejner běží)
•	proměnné prostředí
•	kam to loguje
•	příklad - docker inspect log-rotation --format "{{.NetworkSettings.IPAddress}}"

Docker volumes
Zdroj - https://github.com/ondrejsika/docker-training#docker-volumes

•	špatně se škálují 
•	pro práci se souborama zvolit vhodnější řešení: např. S3, min.io
•	je možné použít drivery pro vytváření vzdálených volumes:
o	viz. https://github.com/ondrejsika/docker-training#ssh-fs-volumes
o	docker volume create --driver local --opt type=nfs --opt o=addr=nfs.sikademo.com,rw --opt device=:/nfs nfsvolume	
o	použití: docker run -ti -v nfsvolume:/data debian (musíš mit OS s NFS hlavičkami)

Dockerfile
•	validator Dockerfile:
o	cat Dockerfile | docker run --rm -i hadolint/hadolint
•	multistage:
o	https://github.com/ondrejsika/docker-training#multi-stage-builds
•	Filesystem cachovani v build procesu, zlepsi buildovani velkych JAVA aplikaci:
o	Buildkit, viz. https://github.com/ondrejsika/docker-training#docker-buildkit
o	https://docs.docker.com/develop/develop-images/build_enhancements/
•	Entrypoint/command - https://github.com/ondrejsika/docker-training#entrypoint-vs-command

Docker network
•	Defaultne se spousti v tzv. BRIDGE

Graficke GUI pro docker
•	Portainer.io, https://github.com/ondrejsika/docker-training#portainer

Balíčkovač:
•	 Nixery.dev, https://github.com/ondrejsika/docker-training#nixerydev
•	Dobré pro testovani, nechas si sestavit OS/Linux+balicky, kt. si vyjmenujes via syntaxi Nixery a mas testovaci prostředí, jde o jednuchost

Monitoring pro docker
•	https://github.com/ondrejsika/docker-training#cadvisor-container-advisor
•	Daj se pak sbirate promethesu
•	Moznost viz. https://meet.google.com/linkredirect?authuser=0&dest=https%3A%2F%2Fondrej-sika.cz%2Fblog%2Fzaznam-devops-live-7-docker-monitoring-pomoci-promethea-a-alertmanageru%2F

-- Další --
MSSQL
•	https://hub.docker.com/_/microsoft-mssql-server
•	https://github.com/microsoft/mssql-docker

•	https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-cmd
•	https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver15&pivots=cs1-bash
•	/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<YourStrong@Passw0rd>" \
•	> -Q 'SELECT @@VERSION'
•	https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15
•	Jak nahrat data do mssql containeru
o	https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-ver15&pivots=cs1-cmd
o	https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container << zajimave umi databasi vytvořit (vždy bude čistá), vhodné pro testování

Správa infratrutury via Terraform
•	https://ondrej-sika.cz/blog/zaznam-devops-live-4-uvod-do-terraformu/
•	https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

Odkazy:
•	https://github.com/ondrejsika/docker-training#course
•	https://ondrej-sika.cz/devops-pipeline/
•	https://12factor.net/
•	https://opencontainers.org/
•	https://docs.docker.com/install/overview/
•	Co je to Yaml - https://learnxinyminutes.com/docs/yaml/
•	https://musl.libc.org/ << knihovna prog. jazyka C, kt. používá Alpine
•	https://www.etalabs.net/compare_libcs.html

--------------------------------------------------------------------------------------------------------------------------------

## Docker Compose
 * Co je to Yaml - https://learnxinyminutes.com/docs/yaml/
 * https://github.com/ondrejsika/docker-training#docker-compose
 * YAML kotvy
 	- dovoluje definovat "objekty"
 	- musi zacina, napr. x-base, pouziti: &base
 	- viz. https://github.com/ondrejsika/docker-training#yaml-anchors
 	- pokud potrebuji sdilet spolecne veci pres vice compose/services
 * commands 
 	- https://github.com/ondrejsika/docker-training#compose-commands
 	- --force-recreate nesaha na VOLUMES
 	- docker image prune - mazani starych nepouzivanych image, tzn. <none>/<none>
 * vypnuti stacku:

 PS D:\Study\skoleni.sika\example--simple-compose\examples\simple-compose> docker-compose ps
          Name                        Command               State         Ports
--------------------------------------------------------------------------------------
simple-compose_counter_1   python app.py                    Up      0.0.0.0:80->80/tcp
simple-compose_redis_1     docker-entrypoint.sh --app ...   Up      6379/tcp
PS D:\Study\skoleni.sika\example--simple-compose\examples\simple-compose> docker-compose stop redis
Stopping simple-compose_redis_1 ... done
PS D:\Study\skoleni.sika\example--simple-compose\examples\simple-compose> docker-compose stop counter
Stopping simple-compose_counter_1 ... done
PS D:\Study\skoleni.sika\example--simple-compose\examples\simple-compose> docker-compose ps
          Name                        Command                State     Ports
----------------------------------------------------------------------------
simple-compose_counter_1   python app.py                    Exit 137
simple-compose_redis_1     docker-entrypoint.sh --app ...   Exit 0
PS D:\Study\skoleni.sika\example--simple-compose\examples\simple-compose>
--
* proxy via traefik:
	- traefik.io, github.com/traefik/traefik
	- https://doc.traefik.io/traefik/providers/docker/
	- TLS - umi generovat SSL certifikaty!!!!
	- podporuje monitoring: cloud-native nastroje
	- podporuje tracerouting
	- skoleni: https://github.com/ondrejsika/traefik-le
	- docker-compose config (prepinani compose)
	- jde spojovat compose.yml, např. docker-compose -f a.yml -f b.yml up -d
	- treafik (totiz obsadi 80/443) mimo aplikaci a svoje docker-compose na to pripojit
		- tzn. mit 
			|- docker-compose.yml ... traefic
			|-projects -- subadresare per projekt se svymi compose.yml, tzn. tim oddelim proxy od aplikaci, a tim nedojde kolize na port-u 80/443
	- github.com/microsoft/terminal 
		- tip pro lepsi praci s konsoli
	- nio.io - poskytne DNS pro testovani
	- pro testovani zateze
		- ab -n 1000000 -c 4 http://localhost/ , apache benchmark nastroj
		- sledovani traficku - http://localhost:8080/metrics
	- spustit vice compose vedle sebe - a spustit vice versi vedle sebe
	    - spusteni v konsoli:
			- COMPOSE_PROJECT_NAME=1 HOST=1.127.0.0.1.nio.io docker-compose up -d
			- COMPOSE_PROJECT_NAME=2 HOST=2.127.0.0.1.nio.io docker-compose up -d
	- priklady, viz. https://ondrej-sika.cz/repozitare/
	- TLS vytvareni SSL certifikaty
		- lze vyzkouset v traefic projektu (ma v /demos projekty: /nginx)
			- viz. d:\Study\skoleni.sika\traefik-le\
		- nastartuji traefic s TLS
		- pak nastartuji /nginx po 10s ma validni TLS cert na 3 mesice
		- to se deje via let's encrypt - trusted CA CERTy s kratkym trvanim, 3 mesice

## Docker Swarm
	- cluster - jednoduchy cluster manager (aka K8) pro Docker Compose
	- https://github.com/ondrejsika/docker-training#docker-swarm
	- 2 typy node:
		- manager - drzi stav, ovladani clusteru 
		- worker - se pousteji containery
	- nelze delat docker-compose localne a pak to spoustet
		- je nutne image push-voat do registry, 
		    - https://github.com/ondrejsika/docker-training#build--push (local)
			- https://github.com/ondrejsika/docker-training#stacks-composes-in-swarm (deploy do swarm-u)- misto docker compose!, tzn. docker stack deploy -c a.yml
		- bacha labels jsou jine, je to videt v traefik, jsou tam pod sebou (jednou je pro compose a druhe jsou pro swarm, zanorene v services/app/deploy/labels)
	- na lokale lze simulovat pouze jedno node cluster!

## Konfigurace Docker instanci
 	- per prostredi, 
 		- buildtime vyplyvne IMAGE s ARG/ENV promennema
 		- runtime:
 			- ma povinnost dodat hodnoty AGR/ENV
 			- tzn. PROD/UAT ma ruzne ARG/ENV
 	- tzn. IMAGE je zbuildovana s app versi, ale lze nasadit na ruzna prostredi

## Udelat si dema v githubu
	- pak event sdilet s Ondrej Siko
	
--

## Zdroje
* https://stream.sika.io/stream/ghokxxgxxubyaakw
* https://ondrej-sika.cz/skoleni/prometheus - azure (terraform / prometheus)
* doporuceni na Twitter - @ondrejsika nebo Linkedin

### JavaEE
* https://rieckpil.de/bootstrap-a-jakarta-ee-8-maven-project-with-java-11-in-seconds/
	- mvn archetype:generate -DarchetypeGroupId=de.rieckpil.archetypes -DarchetypeArtifactId=jakartaee8 -DinteractiveMode=false -DgroupId=cz.tc.learn -DartifactId=cz.tc.learn.jaxrs.simplest
* https://github.com/AdamBien/javaee8-essentials-archetype

### MSSQL
* https://hub.docker.com/_/microsoft-mssql-server?tab=description
* https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container
* https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-cmd#pullandrun2019
* https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-ver15&pivots=cs1-cmd
* https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver15&pivots=cs1-bash
* https://github.com/microsoft/mssql-docker
* https://www.sqlshack.com/creating-your-own-sql-server-docker-image/
* https://ralph.blog.imixs.com/2016/10/22/wildfly-install-postgresql-jdbc-driver-as-a-module/
* https://github.com/davidgfolch/mssql-linux-docker-spring-boot-jpa

### Wildfly
* https://github.com/jboss-dockerfiles
* https://hub.docker.com/r/jboss/wildfly
* https://github.com/goldmann/wildfly-docker-deployment-example
* https://goldmann.pl/blog/2014/07/18/logging-with-the-wildfly-docker-image/
* https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/
* https://github.com/imixs/imixs-docker/blob/master/wildfly/Dockerfile << inspirace, jak si udelat vlastni WF image
* https://github.com/imixs/imixs-docker/tree/master/wildfly
* https://ralph.blog.imixs.com/2016/05/05/wildfly-reverse-proxy-via-ssl/
* https://www.squins.com/knowledge/jboss-cli-mysql-datasource-howto/
* https://github.com/wildfly/quickstart/tree/master/jaxws-retail
* http://www.mastertheboss.com/jboss-server/jboss-datasource/configuring-ms-sqlserver-datasource-in-wildfly
* https://github.com/Adelantos/Docker-Wildfly-MsSql << konfigurace pomoci XSL

### Jakarta 9
* https://ralph.blog.imixs.com/2020/12/13/migrating-to-jakarta-ee-9/
* https://golb.hplar.ch/2020/04/java-javascript-engine.html << migrace s Nashorn na GraalVM
* https://medium.com/graalvm/nashorn-removal-graalvm-to-the-rescue-d4da3605b6cb
* http://www.mastertheboss.com/javaee/jakarta-ee/jakarta-ee-9-hello-world-example-application

### Monitoring
* https://ralph.blog.imixs.com/2020/11/04/monitoring-your-kubernetes-cluster-the-right-way/

### OTHER
* https://ralph.blog.imixs.com/2020/10/23/how-to-set-timezone-and-locale-for-docker-image/
* https://ralph.blog.imixs.com/2020/05/08/microprofile-openapi-and-swagger-ui/
* https://ralph.blog.imixs.com/2018/09/27/docker-container-persistence/
* http://javaeemicro.services/

### Kubernetes
* https://docs.microsoft.com/en-us/azure/developer/java/migration/migrate-wildfly-to-wildfly-on-azure-kubernetes-service
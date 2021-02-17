# Studijní plán - docker, kubernetes pro STX

## Milníky
* 06/2021 - docker a fungující NTFM
* 12/2021 - docker a SDX1 (moduly) a automatická CD/CI pipeline do azure
* http://www.whatweekisit.org/ >> v jakém jsme týdnu
* detailní plán je ONLINE - viz. https://docs.google.com/document/d/1L-yUwt5Lp4fJMBNESr_bZpeI9g_9eloctKUFx6b7xCI/edit?usp=sharing
--

* projdi si worklog adresare, nekdy eviduji MD/TXT soubory přímo v nich a preved je sem, at je to na jednom miste!!!

## Jira tickety
* SSD-1349 - kontainerizace SDX (epic)
* SSD-1349 - migrace NTFM na JDK 11
* 



### Follow up od Ondřej Šika
- Docker
Materiály
Repozitář s kurzy
Docker - https://github.com/ondrejsika/docker-training/
Další použité repozitáře
Traefik s Let's Encrypt - https://github.com/ondrejsika/traefik-le
Témata, které jsme nakousli
Terraform - Infrastructure as a code, Školení Terraformu
DigitalOcean - Cloudova Platforma, Školení DigitalOcean

- Kubernetes
Materiály
Repozitář s kurzy
Kubernetes - https://github.com/ondrejsika/kubernetes-training/
Repozitáře, které jsme při školení vytvořili
https://github.com/sika-training-examples
Další použité repozitáře
Terraform Infrastruktura Demo Gitlabu - https://github.com/ondrejsika/terraform-demo-gitlab
Traefik Ingress for Kubernets - https://github.com/ondrejsika/kubernetes-ingress-traefik
Demo Kubernetes Cluster on DigitalOcean - https://github.com/ondrejsika/terraform-do-kubernetes-example
Prometheus on Kubernetes - https://github.com/ondrejsika/ondrejsika-k8s-prom
--

Pokud byste měli zájem o nějaké další školení, můžete si vybrat zde:

Všechny kurzy - https://ondrej-sika.cz/seznam-skoleni/
Veřejné termíny - https://ondrej-sika.cz/verejne-terminy/
Ostatní zajímavé repozitáře
https://ondrej-sika.cz/repozitare/ - Seznam zajímavých repozitářů
https://github.com/ondrejsika - Všechny mé repozitáře na Githubu
--

## Review školení
* školení mám uložené zde viz. D:\Study\skoleni.sika
* pak rozdělené dle tématu na \docker a \kubernetes
* review jsem stavěl nad dokumenty/pozn. ze školení:
	- docker\README.txt
	- kubernetes\README.txt

### Docker
* docker - review
	- zdroj - D:\Study\skoleni.sika\docker\README.md
	- základy: 
		- zdroj: https://github.com/ondrejsika/docker-training/#image-and-container
		- Systém info
			* docker run hello-world
			* docker version - print version
			* docker info - system wide information
			* docker system df - docker disk usage
			* docker system prune - cleanup unused data
				- docker system prune –a (smaže i images, ne ty použité, lze použít na PROD)
				- docker system prune –-volume (bacha smaže neaktivní volumes, kt. zrovna nikdo nepoužívá)
		- Docker images
			* docker pull <image> - download an image
			* docker image ls - list all images
			* docker image ls -q - quiet output, just IDs
			* docker image ls <image> - list image versions
			* docker image rm <image> - remove image
			* docker image history <image> - show image history
			* docker image inspect <image> - show image properties
		- Containers
			* docker ps - list containers
			* docker start <container>
			* docker stop <container>
			* docker restart <container>
			* docker rm <container> - remove container
		- Common Docker Run Params
			* --name <name>
			* --rm - remove container after stop
			* -d - run in detached mode
			* -ti - map TTY a STDIN (for bash eg.)
			* -e <variable>=<value> - set ENV variable
			* --env-file=<env_file> - load all variables defined in ENV file
		- pozn. dostačující, dobrý pro cheatsheet s docker-em pro základní každodenní práci
		--				
	- docker registry:
		- zdroj: https://github.com/ondrejsika/docker-training/#docker-registry
		- https://hub.docker.com/ - remote registr (mimo firmu)
		- je vhodné postavit interní/private docker registry (pro interní potřeby firmy)
		- pro testování je možné si udělat svou registry, viz. https://github.com/ondrejsika/docker-training/#own-docker-registry
		- pozn:
			- registry je pak vhodné pro Swarm/Kubernetes, oba stahují jedině z tohoto zdroje, narozdíl od docker compose, který umí build/stahovat image z lokálu
		--
	- konfigurace
		- ne do volumes, ale pomocí env-variables
		- hesla do nějakého/externího VAULT řešení
		- docker run debian env – vypíše proměnné
	- logování
		- zdroj - https://github.com/ondrejsika/docker-training/#docker-logs
		- přepnout aplikaci, aby logovala na stdout
		- vytáhnout pak ven via logovací driver, např. elastic je standart
			- konsekvence, jak a co logovat, 
			- dále jaký formát, aby se dal snadno vyhledávat
		- tím přijdeme o log soubor, lze rešit odkládáním na volume (ale v clusteru, s n-instancemi je to problém, jak rozlišovat z kt. instance log soubor pochází)
		- logování není omezen na velikost, max-počet souborů, rotaci lze nastavit via parametry, priklad: ondrejsika/log-rotation
		- log driver, viz. https://github.com/ondrejsika/docker-training#json-file-default-log-driver
	- zkoumání docker-u
		* via docker inspect, viz. https://github.com/ondrejsika/docker-training#docker-inspect
			* najdeš stav kontejneru
			* informace o síti (pouze pokud kontejner běží)
			* proměnné prostředí
			* kam to loguje
			* příklad - docker inspect log-rotation --format "{{.NetworkSettings.IPAddress}}"
		* via docker exec - přístup aka SSH do běžícího kontejneru
			* další info, https://github.com/ondrejsika/docker-training/#docker-exec
	- práce se soubory
		* lze použít volumes, viz. https://github.com/ondrejsika/docker-training/#docker-volumes
		* špatně se škálují 
		* pro práci se souborama zvolit vhodnější řešení: např. S3, min.io
		* je možné použít drivery pro vytváření vzdálených volumes:
			o	viz. https://github.com/ondrejsika/docker-training#ssh-fs-volumes
			o	docker volume create --driver local --opt type=nfs --opt o=addr=nfs.sikademo.com,rw --opt device=:/nfs nfsvolume	
			o	použití: docker run -ti -v nfsvolume:/data debian (musíš mit OS s NFS hlavičkami)
	- sítařina
	    - sítě, viz. https://github.com/ondrejsika/docker-training/#docker-networks
		- port forwarding - https://github.com/ondrejsika/docker-training/#port-forwarding
	- monitoring
		* https://github.com/ondrejsika/docker-training#cadvisor-container-advisor
		* Daj se pak sbirate promethesu
		* Moznost viz. https://meet.google.com/linkredirect?authuser=0&dest=https%3A%2F%2Fondrej-sika.cz%2Fblog%2Fzaznam-devops-live-7-docker-monitoring-pomoci-promethea-a-alertmanageru%2F
--
* docker compose - review
	* zdroj - https://github.com/ondrejsika/docker-training#docker-compose
	* příkazy, viz.  https://github.com/ondrejsika/docker-training#compose-commands
	* např. použití jsme presentovali na proxy raefic, viz. skoleni.sika\traefik-le
--
* docker swarm - review
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
--
* review zajímavosti:
	* spustit vice compose vedle sebe - a spustit vice versi vedle sebe
	    - spusteni v konsoli:
			- COMPOSE_PROJECT_NAME=1 HOST=1.127.0.0.1.nio.io docker-compose up -d
			- COMPOSE_PROJECT_NAME=2 HOST=2.127.0.0.1.nio.io docker-compose up -d
		- priklady, viz. https://ondrej-sika.cz/repozitare/
    * nástroj pro konsoli - github.com/microsoft/terminal
    * nio.io - poskytne DNS pro testovani
	* pro testovani zateze (apache httpd, obsahuje utilitku ab)
		- ab -n 1000000 -c 4 http://localhost/ , apache benchmark nastroj
		- sledovani traficku, např. v traefic - http://localhost:8080/metrics    
	* proxy traefic (https://github.com/ondrejsika/traefik-le):
		- TLS - umi generovat SSL certifikaty!!!!
		- podporuje monitoring: cloud-native nastroje
		- podporuje tracerouting
		- treafik (totiz obsadi 80/443) mimo aplikaci a svoje docker-compose na to pripojit
		- tzn. mit 
			|- docker-compose.yml ... traefic
			|-projects -- subadresare per projekt se svymi compose.yml, tzn. tim oddelim proxy od aplikaci, a tim nedojde kolize na port-u 80/443
	* TLS vytvareni SSL certifikaty via traefic
		- lze vyzkouset v traefic projektu (ma v /demos projekty: /nginx)
			- viz. d:\Study\skoleni.sika\traefik-le\
		- nastartuji traefic s TLS
		- pak nastartuji /nginx po 10s ma validni TLS cert na 3 mesice
		- to se deje via let's encrypt - trusted CA CERTy s kratkym trvanim, 3 mesice
	* docker swarm/minikube - oba umí pouze one-node cluster
	* konfigurace Docker instanci
 		- per prostredi, 
	 		- buildtime vyplyvne IMAGE s ARG/ENV promennema
	 		- runtime:
	 			- ma povinnost dodat hodnoty AGR/ENV
	 			- tzn. PROD/UAT ma ruzne ARG/ENV
 		- tzn. IMAGE je zbuildovana s app versi, ale lze nasadit na ruzna prostredi
--

### Kubernetes
* kubernetes - review
	- zdroj - D:\Study\skoleni.sika\kubernetes\README.md
	- základy: https://github.com/ondrejsika/kubernetes-training/
		* komponenty: master, client
			- na masterech bezi: Api Server, Controller Manager a Scheduler
			- na clientech bezi: Kubelet, KubeProxy (pro LB/forwad traficu z/do clusteru)
			- další info, https://kubernetes.io/docs/concepts/overview/components/
		* resources:
			- Pod - nejmensi stavebni blok, nema stabilni sitovy interface
			- Deployment - managuje pod-y, update pod-u, taky nema stabilni sit. interface
			- Service - stabilni sitovy interface, vidi sitove na vsechny pod-y
			- Ingress - LoadBalancing, Reversni proxy - expose IP adress
		* další:
			* viz. https://sika.link/k8s-slides
			* https://kubernetes.io/docs/concepts/workloads/
			* https://kubernetes.io/docs/concepts/services-networking/
	- nástroje
		- kubectl
		- helm - package manager
		- minikube - k8 cluster pro vývoj
		- kubeadm - pro správu clusteru
		- další mastroj pro ovladani k8 clusteru
			* https://github.com/ondrejsika/kubernetes-training#kube-ps1
			* https://github.com/ondrejsika/kubernetes-training#kubectx--kubens
--


## Zdroje
* jak na dockerignore:
	- https://codefresh.io/docker-tutorial/not-ignore-dockerignore-2/
* raw pristup via jdbc/result API v java
    - https://docs.oracle.com/javase/tutorial/jdbc/basics/sqldatasources.html
	- https://docs.microsoft.com/en-us/sql/connect/jdbc/data-source-sample?view=sql-server-ver15
	- https://www.journaldev.com/2509/java-datasource-jdbc-datasource-example
* jak zaclenit MAVEN do docker flow:
	- https://codefresh.io/howtos/using-docker-maven-maven-docker/
	- https://github.com/fabric8io/docker-maven-plugin
* monitoring - SmallRye Metrics (implementace Eclipse MicroMetrics) viz. 2021-02-01 22:33:39,616 INFO  [io.smallrye.metrics] (MSC service thread 1-7) MicroProfile: Metrics activated (SmallRye Metrics version: 2.4.2) 

### K8 networking
* https://itnext.io/kubernetes-networking-behind-the-scenes-39a1ab1792bb
* https://digitalvarys.com/kubernetes-networking-models/
* https://8gwifi.org/docs/kube-ports.jsp

### Other 
* https://gist.github.com/tuannvm/4e1bcc993f683ee275ed36e67c30ac49 << helm cheatsheet
* https://hackernoon.com/practical-introduction-to-docker-compose-d34e79c4c2b6 practical docker compose intro - nice app
* https://www.altoros.com/wp-content/uploads/pdf/Kubernetes-Kubectl-CLI-Cheat-Sheet.pdf
* https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html
* https://medium.com/better-programming/the-essential-docker-dockerfile-and-docker-compose-cheat-sheet-8bf1c42876c1
* https://www.techrepublic.com/article/how-to-create-a-docker-swarm/
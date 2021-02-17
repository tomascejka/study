# Docker


## Popis:
Nastudovat/oprášit zkušenosti s docker platformou (docker engine, docker compose a docker swarm).
.
## Repository:
...

Inputs

* http://adambien.blog/roller/abien/entry/simplest_possible_java_ee_8 << maven archetype s JAVA-EE 8 a microprofile/packaging=war


## Zdroje

### NUTNOST PRECIST
* https://aboullaite.me/protola-alpine-java/
* https://www.cyberciti.biz/faq/10-alpine-linux-apk-command-examples/
* https://aboullaite.me/speed-up-your-java-application-images-build-with-buildkit/
9.  https://codefresh.io/docker-tutorial/java_docker_pipeline/ HOT, @docker-java
10. https://codefresh.io/Docker-Tutorial/dockerize-java-application/ HOT, @docker-java
14. https://docs.docker.com/develop/dev-best-practices/ << @docker best practices
15. https://docs.docker.com/storage/volumes/ @docker persisteni uloziste pro konfigurace napr.
17. https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/
18. https://dzone.com/articles/run-simple-jar-application-in-docker-container-1
19. https://success.docker.com/article/docker-enterprise-best-practices
20. https://www.thegeekdiary.com/beginners-guide-to-the-docker-world/ << HOT, vse najednou v jednom clanku !!!!
* https://birthday.play-with-docker.com/run-as-user/

Zdroje
1.  https://docs.docker.com/get-started/swarm-deploy/
2.  https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory
3.  https://stackify.com/guide-docker-java/ (logovani na host, viz. kapitola Sharing directories)
4.  https://www.baeldung.com/ops/docker-container-environment-variables (externi konfigurace via Enviromental variables)
5.  https://docs.docker.com/engine/swarm/secrets/ << ext. konfigurace pro citliva data
6.  https://www.baeldung.com/docker-compose
7.  https://cloudplatform.googleblog.com/2018/07/introducing-jib-build-java-docker-images-better.html
8.  https://stackify.com/docker-environment-variables/ >> HOT, @docker-config Enviromental variables
...
11. https://dzone.com/articles/how-to-decrease-jvm-memory-consumption-in-docker-u << @docker-java @memory
12. https://www.jrebel.com/blog/docker-microservices-java << HOT, @docker-java
13. https://www.jrebel.com/blog/kubernetes-vs-docker-swarm << @docker-swarm vs. @kubernetes
...
16. https://stackshare.io/stackups/docker-machine-vs-docker-swarm-vs-kubernetes

94. https://www.jrebel.com/blog/docker-tips-for-java-developers
93. https://stackify.com/complete-docker-toolkit/ HOT, @docker study resources
94. https://stackify.com/docker-tutorial/ HOT, @docker basics
95. https://spring.io/guides/gs/spring-boot-docker/ << jak k docker se stavi spring << studnice, je to taky java aplikace
96. https://www.baeldung.com/ops/docker-container-shell << jak se dostat do beziciho kontaineru, resp. do bash konsole
97. https://www.baeldung.com/docker-images-vs-containers
98. https://www.baeldung.com/ops/docker-container-filesystem
--


### Ke studiu

#### Dockerfile
* https://docs.docker.com/engine/reference/builder/
* https://docs.docker.com/get-started/part2/#define-a-container-with-dockerfile
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
* https://docs.docker.com/develop/dev-best-practices/
* https://cloud.google.com/solutions/best-practices-for-building-containers
* https://www.docker.com/blog/intro-guide-to-dockerfile-best-practices/
* https://www.docker.com/dockercon/2019-videos?watch=dockerfile-best-practices
* http://crosbymichael.com/dockerfile-best-practices.html
* http://crosbymichael.com/dockerfile-best-practices-take-2.html
* https://engineering.bitnami.com/articles/best-practices-writing-a-dockerfile.html
* https://www.tecmint.com/build-and-configure-docker-container-images-with-dockerfile/
* https://towardsdatascience.com/how-to-build-slim-docker-images-fast-ecc246d7f4a7 << @dockerfile slim multistage
* https://medium.com/better-programming/super-slim-docker-containers-fdaddc47e560 << @dockerfile slim multistage4
* https://pumpingco.de/blog/environment-variables-angular-docker/ << @dockerfile a použití multistage (inspirace)
* https://phoenixnap.com/kb/docker-add-vs-copy << HOT, prikazy ADD vs. COPY vcetne prikladu (userful)
* https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/#1-create-the-dockerfile << tutorial
* http://www.mastertheboss.com/soa-cloud/docker/deploying-applications-on-your-docker-wildfly-image << jak pridat usera v dockerfile na widlfy
* https://github.com/hypergrid-inc/docker-java << HOT, kompletni manula na docker!!
* https://github.com/IBM/docker101 << HOT, kompletni manula na docker!!

#### Build
* https://docs.docker.com/engine/reference/builder/#dockerignore-file
* https://codefresh.io/docker-tutorial/not-ignore-dockerignore-2/
* https://docs.docker.com/engine/reference/commandline/build/
* https://docs.docker.com/engine/reference/run/
* https://runnable.com/docker/java/dockerize-your-java-application >> dokerize java app, pak pak tomcat + app ...
* https://runnable.com/docker/java/advantages-of-docker-for-java-apps
* https://stackify.com/docker-build-a-beginners-guide-to-building-docker-images/

#### Security
* https://snyk.io/blog/10-docker-image-security-best-practices/
* https://www.stackrox.com/post/2019/09/docker-security-101/

#### Alpine
* https://blog.overops.com/my-alpine-desktop-setting-up-a-software-development-environment-on-alpine-linux/
* http://blog.zot24.com/tips-tricks-with-alpine-docker/
* https://wiki.alpinelinux.org/wiki/Docker
* https://stackoverflow.com/questions/51192713/how-to-make-curl-available-in-docker-image-based-java8-jdk-alpine-and-keep-the << alpine image a prikazy no-cache a pridani programu add/curl
* https://rollout.io/blog/alpine-based-docker-images-make-difference-real-world-apps/
* https://blog.overops.com/why-i-deleted-my-ide-and-how-it-changed-my-life-for-the-better/

#### Tomcat
* https://www.mulesoft.com/tcat/tomcat-maven
* https://www.mulesoft.com/tcat/tomcat-configuration
* https://www.logicbig.com/tutorials/build-tools/apache-maven/tomcat-maven-plugin.html

#### Konfigurace
* https://success.docker.com/article/mta-best-practices >> kapitola Configuration Management
* https://vsupalov.com/docker-arg-env-variable-guide/ HOT, popis vsech moznych zpusobu konfigurace docker-u
* https://documentation.bloomreach.com/14/library/deployment/set-environment-specific-configuration-with-docker.html << HOT, jak konfigurovat Tomcat (inspirace)
* https://neo4j.com/docs/operations-manual/current/docker/configuration/#docker-environment-variables << jako se konfiguruje Neo4j (inspirace)
* https://medium.com/@kale.miller96/how-to-mount-your-current-working-directory-to-your-docker-container-in-windows-74e47fa104d7

#### Docker Volumes
* https://training.play-with-docker.com/docker-volumes/ HOT, interaktivni ucebni web pro praci s docker VOLUMES
* https://spin.atomicobject.com/2019/07/11/docker-volumes-explained/ HOT, simply
* https://linuxhint.com/docker_volume_share_data/ << priklad jak sdilet pro dva servery httpd/apache jednu stranku stranku (index.html)
* https://thenewstack.io/docker-basics-how-to-share-data-between-a-docker-container-and-host/
* https://www.ostechnix.com/explaining-docker-volumes-with-examples/
* https://medium.com/bb-tutorials-and-thoughts/understanding-docker-volumes-with-an-example-d898cb5e40d7
* https://www.ionos.com/community/server-cloud-infrastructure/docker/understanding-and-managing-docker-container-volumes/ << vcetne prikladu

#### Docker JVM tunning
* https://dzone.com/articles/java-inside-docker-what-you-must-know-to-not-fail?fromrel=true << HOT, memory problemy a jejich reseni
* https://developers.redhat.com/blog/2017/03/14/java-inside-docker/ << HOT, memory problemy a jejich reseni
* https://www.javaadvent.com/2018/12/docker-and-the-jvm.html << HOT, jvm tunning
* https://www.baeldung.com/jvm-parameters HOT, basic jvm parameters for tunning

#### JVM parametry
* https://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html << pro JDK7 a nizsi
-- pro jboss/wildfly
* http://www.mastertheboss.com/jboss-server/jboss-performance/jboss-performance-tuning-part-1
* http://www.mastertheboss.com/jboss-server/jboss-performance/jboss-as-7-performance-tuning?showall=
* https://developer.jboss.org/thread/233904 << zde je zminka, ze je  nutne zapnout v statistics>> vice info v jboss_cli.bat!!!
* https://blog.akquinet.de/2014/09/15/monitoring-the-jboss-eap-wildfly-application-server-with-the-command-line-interface-cli/

#### Java Memory Management
* https://dzone.com/articles/java-ram-usage-in-containers-top-5-tips-not-to-los?fromrel=true HOT, memory issues a reseni
* https://dzone.com/articles/running-a-jvm-in-a-container-without-getting-kille?fromrel=true HOT, memory issues s ukazkami a reseni
* https://dzone.com/articles/gc-explained-heap?fromrel=true
* https://dzone.com/articles/native-memory-allocation-in-examples?fromrel=true
* https://dzone.com/articles/java-and-memory-limits-in-containers-lxc-docker-an?fromrel=true

#### Docker Machine
* https://docs.docker.com/machine/overview/
* https://www.callicoder.com/docker-machine-swarm-stack-golang-example/ << @docker-machine a @docker-swarm
* https://mmorejon.io/en/blog/docker-swarm-with-docker-machine-high-availability/ << @docker-machine a @docker-swarm

#### Docker Swarm
* https://docs.docker.com/engine/swarm/
* https://stackify.com/docker-swarm-vs-kubernetes-a-helpful-guide-for-picking-one/
* https://www.docker.com/blog/announcing-docker-machine-swarm-and-compose-for-orchestrating-distributed-apps/ << HOT, @docker-machine/@docker-swarm
* http://www.johnzaccone.io/3-node-cluster-in-30-seconds/
* https://github.com/IBM/docker101/tree/master/workshop/lab-3 << HOT, IBM/101 Docker github workshop
* https://devopscook.com/docker-swarm-tutorial/
* https://rominirani.com/docker-swarm-tutorial-b67470cf8872
* https://blog.scottlogic.com/2016/06/17/docker-swarm.html
* https://takacsmark.com/docker-swarm-tutorial-for-beginners/
* https://blog.sixeyed.com/production-docker-swarm-on-azure-why-you-should-use-powershell-and-docker-machine/ << @docker-swarm a @docker-machine v @azure
* https://www.freecodecamp.org/news/how-to-manage-more-containers-with-docker-swarm-332b5fc4c346/
* https://rollout.io/blog/docker-machine-compose-and-swarm-how-they-work-together/ << checknout zda je to uptodate
* https://www.linux.com/topic/cloud/how-use-docker-machine-create-swarm-cluster/
* https://dzone.com/articles/docker-swarm-with-docker-machine-and-scripts
* https://hackernoon.com/kubernetes-vs-docker-swarm-a-complete-comparison-guide-15ba3ac6f750
* https://mindmajix.com/kubernetes-vs-docker-swarm#docker-drawbacks

#### Docker Compose
* https://medium.com/factualopinions/docker-compose-tricks-and-best-practices-5e7e43eba8eb
* zmena pouze kontaineru, kt. se to tyka, viz.:
For changes to be made, the Dockerfile is updated for those containers. After making changes, the corresponding containers are recreated and others are left intact.

docker-compose -f dockerfile.yml up -d --no-recreate
zdroj - https://bobcares.com/blog/docker-change-container-configuration/
--
* https://linuxhint.com/beginners_guide_docker_compose/ << basic info o @docker-compose

#### Docker Registry
* https://docs.docker.com/registry/introduction/

#### Sprava docker-u
* https://linuxhint.com/cleanup-docker/ << jak vycistit lokal. docker prostredi (vhodne pro DEV)
* https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes << dalsi cistici rady, smazani container/image
* https://linuxhint.com/networking-storage-docker/ << @network v @docker
* https://linuxhint.com/optimizing-docker-images/ << optimalizace @docker-image
* https://www.thegeekdiary.com/how-to-check-the-status-and-space-used-by-images-and-containers/ << kolik dat zabira lokal
* https://www.thegeekdiary.com/how-to-backup-and-restore-docker-containers/ jak zalohovat containery
* https://www.thegeekdiary.com/how-to-get-information-about-a-container-in-docker/ << jak zjistit info o container zvenku
* https://www.thegeekdiary.com/how-to-add-new-host-entry-in-etc-hosts-when-a-docker-container-is-run/ << jak zadat hostname v /etc/host
* https://www.datadoghq.com/blog/docker-logging/ << logovani
* https://stackify.com/what-are-docker-logs/ << logovani
* https://stackify.com/docker-performance-improvement-tips-and-tricks/ << performance
* https://blog.overops.com/docker-monitoring-5-methods-for-monitoring-java-applications-in-docker/ << monitoring
* https://blog.overops.com/debugging-distributed-systems-3-common-distributed-tracing-challenges-how-to-overcome-them/ << tracing

#### Ostatni
* https://jfrog.com/whitepaper/best-practices-structuring-naming-artifactory-repositories/
* https://dzone.com/articles/setting-up-your-pipeline-with-azure-devops << @docker, @azure-devops
* https://openliberty.io/guides/containerize.html << @docker-java v @openliberty
* https://docs.oracle.com/en/solutions/develop-microservice-java-app/index.html << @docker-java v @oracle cloud
* https://www.baeldung.com/docker-java-api << zajimave, java api pro ovladani Docker
--
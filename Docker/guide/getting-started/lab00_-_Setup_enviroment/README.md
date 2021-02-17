# lab01 - Setup enviroment
Prvotní inspirací je tento [workshop]( https://github.com/danielguerra69/alpine-vnc/blob/master/Dockerfile "In this lab, you will install docker. We will be using docker throughout the rest of the labs.")
. Motivem je mít easy-as-possible laboratorní prostředí, kt. jsou lehce praktikovatelné a obsahují jasné a ověřitelné postupy.

## Přehled
Cílem je rozchodit lokální instalaci Docker nástroje. 

## Předpoklady
Linux asi bez problému (podpora virtuálního prostředí/Docker je již dávno implementována narozdíl od Windows), který distro si vybereš. Co se týče Windows, zde určitě 10 jako minimum - vyhneš se zbytečnému workaroundu s [Docker Toolbox](https://docs.docker.com/toolbox/overview/).

## Poznámky
Nejdříve si stáhnu Docker Desktop z [domovské stránky](https://www.docker.com/products/docker-desktop). Vybereme si příslušný OS (já budu v dalších lab-ech popisovat prostředí s Windows 10 - mám je nově na notebook-u). A pokračuji na stránku s [postupem](https://hub.docker.com/editions/community/docker-ce-desktop-windows) stažení/instalace - je to velmi jednouché/intuitivní.

### Docker platfom

Docker has four main tools that it provides to accomplish tasks:

* Docker Engine
* Docker Compose
* Docker Machine
* Docker Swarm

#### Docker Engine 
is Docker’s
>“powerful open source containerization technology combined with a work flow for building and containerizing your applications.” — Docker, About Docker Engine

It’s what builds and executes Docker images from either a single Dockerfile or docker-compose.yml. When someone uses a docker command through the Docker CLI, it talks to this engine to do what needs to be done.

#### Docker Compose
> “is a tool for defining and running multi-container Docker applications” — Docker, Overview of Docker Compose
This is what you use when you have an application made up of multiple microservices, databases and other dependencies. The docker-compose.yml allows you to configure all those services in one place and start them all with a single command. I’ll cover Docker Compose in much greater detail in the follow up blog post.

#### Docker Machine
In years past, Docker Machine was more popular than it is now.
“Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands.” — Docker, Docker Machine Overview

It’s fallen by the wayside a bit as Docker images have become more stable on their native platforms, but earlier in Docker’s history it was very helpful. That’s about all you need to know about Docker Machine for now.

#### Docker Swarm
The final tool, Docker Swarm
“creates a swarm of Docker Engines where you can deploy application services. You don’t need additional orchestration software to create or manage a swarm” — Docker, Swarm Mode Overview

## Zdroje
* https://www.docker.com/products/docker-desktop
* https://hub.docker.com/editions/community/docker-ce-desktop-windows
* https://docs.docker.com/toolbox/overview/

# lab01 - Dockerfile basics

## Přehled
Popisuje triviální postup, jak udělat docker image. Ideálně z nějakého malého distra, a protože tento dokument píši zpětně = vybral jsem Alpine Linux.

## Předpoklady
Nainstalovaný docker na počítači.

## Poznámky
Zde je jednoduchý seznam dockerfile instrukcí, kt. lze použít:

* ADD copies the files from a source on the host into the container’s own filesystem at the set destination.
* CMD can be used for executing a specific command within the container.
* ENTRYPOINT sets a default application to be used every time a container is created with the image.
* ENV sets environment variables.
* EXPOSE associates a specific port to enable networking between the container and the outside world.
* FROM defines the base image used to start the build process.
* (deprecated, use LABEL) MAINTAINER defines a full name and email address of the image creator. << deprecated, use LABEL key=value
* RUN is the central executing directive for Dockerfiles.
* USER sets the UID (or username) which is to run the container.
* VOLUME is used to enable access from the container to a directory on the host machine.
* WORKDIR sets the path where the command, defined with CMD, is to be executed.

LABEL allows you to add a label to your docker image.
Not all keywords are required for a Dockerfile to function. Case in point, our example will only make use of FROM, MAINTAINER, and RUN.


## Zdroje

### Oficiální
* https://docs.docker.com/develop/dev-best-practices/ << HOT, určitě nastuduj
* https://docs.docker.com/engine/reference/builder/ << Dockerfile dokumentace
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
* https://docs.docker.com/develop/develop-images/multistage-build/ << HOT, dost ušetří místo/velikost image

* https://www.alpinelinux.org/
* https://hub.docker.com/_/alpine
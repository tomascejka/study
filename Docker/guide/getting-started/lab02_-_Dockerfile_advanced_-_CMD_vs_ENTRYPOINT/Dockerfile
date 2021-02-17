#
# @see https://docs.docker.com/engine/reference/builder/ << oficialni dockerfile reference documentation
# @see https://github.com/alpinelinux/docker-alpine
#
FROM alpine:latest

# Install bash because there is a shell script (which we will use in docker run phase), see below
# @see https://stackoverflow.com/questions/44803982/how-do-i-run-a-bash-script-in-an-alpine-docker-container/44804509#44804509
RUN apk add --no-cache --upgrade bash

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
# @see https://docs.docker.com/engine/reference/builder/#workdir 
WORKDIR /root

# Copy local file into container (into root directory)
# @see https://docs.docker.com/engine/reference/builder/#copy
COPY resources/entrypoint.sh /root

#
# An ENTRYPOINT allows you to configure a container that will run as an executable
#
# @see https://docs.docker.com/engine/reference/builder/#entrypoint
# @see https://docs.docker.com/engine/reference/builder/#cmd
# @see http://www.johnzaccone.io/entrypoint-vs-cmd-back-to-basics/ << HOT how CMD/ENTRYPOINT works together/standalone

# --
# Ruzne variace (vzdy odkomentuj pouze jednu variaci)
# --
#
# v1 - pokud pustis run.bat 1 - vypise to ascii grafiku na vystup
# ENTRYPOINT ["./entrypoint.sh"]
# --
# v2 - pokud pustis run.bat 1 - vypise to obsah adresare /usr na vystup
# CMD ls /usr # shell format
# --
# v3 - pokud pustis run.bat /bez parametru - bezi to na pozadi a musis pouzit exec pro scan/ pokud 1 - vypisuje to interaktivne prikaz ping na vystup/ctrl+c stopne bezici process/kontainer
# ENTRYPOINT ping www.google.com  # shell format
# --
# v4 - podobné jako v3 akorat v exec formatu (kt. je doporucovany)
# ENTRYPOINT ["ping", "www.google.com"]  # exec format
# --
# v5 - podobné jako v4 s tim rozdilem, ze via CMD dokazes parametrizovat prikaz definovat v ENTRYPOINT-u, tzn. 3x ping-e a skonci process
ENTRYPOINT ["ping", "www.google.com"]  # exec format
CMD ["-c","3"]
# --
#
# Simplest dockerfile as I am able to do (with bash+script as addon)
#
# @see https://docs.docker.com/engine/reference/builder/ << oficial dockerfile reference documentation
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
COPY resources/start.sh /root

#
# An ENTRYPOINT allows you to configure a container that will run as an executable
#
# @see https://docs.docker.com/engine/reference/builder/#entrypoint
# @see https://docs.docker.com/engine/reference/builder/#cmd
ENTRYPOINT ["./start.sh"]
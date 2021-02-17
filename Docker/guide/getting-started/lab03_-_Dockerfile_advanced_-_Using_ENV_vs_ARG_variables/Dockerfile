#
# @see https://docs.docker.com/engine/reference/builder/ << oficialni dockerfile reference documentation
# @see https://github.com/alpinelinux/docker-alpine
#
FROM alpine:latest

# ENV value acts as default value
# @see https://docs.docker.com/engine/reference/builder/#environment-replacement
ARG input=3
ENV COUNT ${input}

# Install bash because there is a shell script (which we will use in docker run phase), see below
# @see https://stackoverflow.com/questions/44803982/how-do-i-run-a-bash-script-in-an-alpine-docker-container/44804509#44804509
RUN apk add --no-cache --upgrade bash

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
# @see https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /root

# Copy local file into container (into root directory)
# @see https://docs.docker.com/engine/reference/builder/#copy
COPY resources/ping.sh /root

# Run ping in container and limit count of attemps by variable
ENTRYPOINT ["./ping.sh"]  # exec format
#
# @see https://docs.docker.com/engine/reference/builder/ oficialni dockerfile reference documentation
#
FROM alpine:latest

# Install bash because there is a shell script (which we will use in docker run phase), see below
# @see https://stackoverflow.com/questions/44803982/how-do-i-run-a-bash-script-in-an-alpine-docker-container/44804509#44804509
# @see https://serverfault.com/questions/1001174/cant-ping-permission-denied
RUN apk add --no-cache --upgrade bash iputils

# bude ping-at na strycka google-a
ENTRYPOINT ["ping", "www.google.com"]  # exec format
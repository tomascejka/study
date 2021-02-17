#
# There's a target to learn about dockerfile. 
# Motivation is build up own image for development.
#
# @author tomas.cejka
#
# @see https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
#
ARG var_username
FROM alpine:latest

ENV username=$var_username
RUN apk add -U --no-cache \
# https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user
&& adduser -D -s /bin/bash -h /home/${username} ${username}




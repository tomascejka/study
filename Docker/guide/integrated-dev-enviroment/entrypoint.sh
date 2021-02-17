#!/bin/sh

#
# Developement enviroment via docker
#
# @see https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1 
#

# This is all well and good, but I need to actually map the new user & group ID’s to my local user. 
# I’ve created a script that I’ll use as the entry point (entrypoint.sh) into the container when it runs.
# With it, I’ll create a group with the same ID as my local group and then modifying the created user me 
# to have the same ID of my local user (passing the local ID’s to the container on start by adding some 
# environment variables to my docker run command):

# Get standard cali USER_ID variable
USER_ID=${HOST_USER_ID:-9001}
GROUP_ID=${HOST_GROUP_ID:-9001}
# Change 'me' uid to host user's uid
if [ ! -z "$USER_ID" ] && [ "$(id -u me)" != "$USER_ID" ]; then
    # Create the user group if it does not exist
    groupadd --non-unique -g "$GROUP_ID" group
    # Set the user's uid and gid
    usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" me
fi

# When I installed and copied everything over in the Dockerfile, I was actually doing at as the root user. 
# So everything I put in /home/me is owned by root. If I’m going to run as me in the container then the 
# .zshrc, .vimrc & .gitconfig won’t be picked up when using their counterpart programs due to permissions 
# issues. So in my entrypoint.sh, I run a chown on everything in that directory to set the permissions 
# correctly (I also needed to run chown on /var/run/docker.sock to be able to use docker):

# Setting permissions on /home/me
chown -R me: /home/me
# Setting permissions on docker.sock
chown me: /var/run/docker.sock

# su-exec (switch user & execute) is a program that I use as the last thing in the entrypoint.sh 
# to launch me into a tmux shell as the me user.
exec /sbin/su-exec me tmux -u -2 "$@"
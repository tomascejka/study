#
# @see https://docs.docker.com/engine/reference/builder/ oficialni dockerfile reference documentation
#
FROM alpine:latest

# Install bash because it can be used in CMD/ENTRYPOINT instructions /which we will use in docker run phase/
# @see https://stackoverflow.com/questions/44803982/how-do-i-run-a-bash-script-in-an-alpine-docker-container/44804509#44804509
# @see https://serverfault.com/questions/1001174/cant-ping-permission-denied
RUN apk add --no-cache --upgrade bash iputils

# Create new group/user and user is added to group (alpine-based commands):
# @see https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user
# @see https://www.computerhope.com/unix/adduser.htm
# @see https://stackoverflow.com/questions/49955097/how-do-i-add-a-user-when-im-using-alpine-as-a-base-image
RUN addgroup -S appgroup && adduser -D appuser -G appgroup

# Tell docker that all future commands should run as the appuser user
USER appuser

# bude ping-at na strycka google-a pod uzivatelkym konte vytvorenim vyse
ENTRYPOINT ["ping", "www.google.com"]  # exec format
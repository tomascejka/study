FROM alpine:latest

#
# Idea mit IDE v docker 
# @see https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
#

# The Basics
# The core of my environment is built to support my workflow. I’m an avid fan of (Neo)Vim and use 
# that as my editor and git (& git-perl) for source code management. I use tmux for splitting my 
# terminal window into many panes and for ‘tabs’ and ZSH is a nice configurable shell. I also need 
# to install bash and ncurses for tmux plugin manager to work. OpenSSh Client for SSH’ing to things. 
# cURL, less and man are other useful utilities.
#RUN apk add -U --no-cache \
    #git git-perl \
    #zsh tmux openssh-client bash ncurses \
    #curl less man
    ##\
# I also make use of docker-compose, however, this isnt a package that can be installed with apk. 
# I have to add py-pip to my apk install in the Dockerfile
    ##docker python2-dev  py-pip \
# Since docker-compose version 1.24.0, you also need some dev dependencies:
    #python3-dev libffi-dev openssl-dev gcc libc-dev make
# Install spacevim - https://spacevim.org/quick-start-guide/#install
##RUN curl -sLf https://spacevim.org/install.sh | bash   
##RUN pip install docker-compose

RUN apk add -U --no-cache \
    neovim git git-perl \
    zsh tmux openssh-client bash ncurses \
    curl less man \
    ##docker py-pip python2-dev \
    ##&& pip install docker-compose \
    ##&& useradd -ms /bin/zsh me

# Do everything from now in that users home directory
WORKDIR /home/me
ENV HOME /home/me

# Entrypoint script does switches u/g ID's and `chown`s everything
COPY entrypoint.sh /bin/entrypoint.sh
# Set working directory to /workspace
WORKDIR /workspace 
# Default entrypoint, can be overridden
CMD ["/bin/entrypoint.sh"]

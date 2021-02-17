#
# There's a target to learn about dockerfile. 
# Motivation is build up own image for development.
#
# @author tomas.cejka
#
# @see https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
#
FROM alpine:latest

RUN apk add -U --no-cache \
    neovim git git-perl \
    zsh tmux openssh-client bash ncurses \
    curl less man \
# https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user
&& adduser -D -s /bin/bash -h /home/tc tc

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

RUN touch .zshrc && mkdir -p .config/nvim && touch .config/nvim/init.vim
COPY tmux.conf .tmux.conf

# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim +PlugInstall +qa

# Install Tmux Plugin Manager
# RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
# RUN tmux start-server
# RUN tmux new-session -d
# RUN chmod 777 .tmux.conf
# RUN tmux source .tmux.conf
# RUN .tmux/plugins/tpm/bin/install_plugins
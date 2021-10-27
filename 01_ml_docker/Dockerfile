FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

# We love UTF!
ENV LANG C.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Set the nvidia container runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}compute,video,graphics,utility

RUN set -x \
    && apt-get update \
    && apt-get --with-new-pkgs upgrade -y \
    && apt-get install -y mesa-utils \
    && apt-get install -y iputils-ping \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-get install -y openssh-server python3-pip exuberant-ctags \
    && apt-get install -y git vim tmux nano htop sudo curl wget gnupg2 \
    && apt-get install -y bash-completion \
    && apt-get install gunicorn3 -y \
    && apt-get install libboost-all-dev -y \
    && apt-get install cmake -y \
    && apt-get install sudo -y \
    && apt-get install libgl1-mesa-glx -y \
    && pip3 install --upgrade pip \
    && pip3 install --upgrade setuptools \
    && pip3 install powerline-shell  \
    && pip3 install numpy==1.19.5 pandas==1.1.5 matplotlib==3.3.4 regex==2021.4.4 \
    && pip3 install scipy==1.5.4 jupyter jupyterlab scikit-learn==0.24.1 split-folders==0.4.3 \
    && pip3 install keras==2.3.1 tensorflow-gpu==1.14.0 fastai==0.7 \
    && pip3 install flask==1.1.2 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -ms /bin/bash user \
    && echo "user:user" | chpasswd && adduser user sudo \
    && echo "user ALL=(ALL) NOPASSWD: ALL " >> /etc/sudoers

RUN pip3 install openpyxl==3.0.7

RUN pip3 install ggplot==0.11.5 \
    && pip3 install pdpbox==0.2.1 \
    && pip3 install scikit-misc==0.1.3 \
    && pip3 install treeinterpreter==0.2.3 \
    && pip3 install plotly==4.14.3

RUN pip3 install torchtext==0.2.3

RUN pip3 install xgboost==1.3.3 \
    && pip3 install shap==0.39.0

RUN apt-get update \
    && apt-get install graphviz -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 uninstall tensorflow-gpu -y
RUN pip3 install keras==2.6.0 tensorflow-gpu==2.6.0

COPY ./library_files/structured.py /usr/local/lib/python3.6/dist-packages/fastai/structured.py

USER user
WORKDIR /home/user
RUN mkdir notebooks

RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack  \
    && git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux-resurrect
COPY --chown=user:user ./.tmux.conf /home/user/.tmux.conf
COPY --chown=user:user ./.powerline.sh /home/user/.powerline.sh

RUN mkdir -p /home/user/.vim/bundle \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

COPY --chown=user:user ./.vimrc /home/user/.vimrc

RUN set -x \
    && vim -E -u NONE -S /home/user/.vimrc -C "+PluginInstall" -C "+qall";  exit 0

#
# Set some decent colors if the container needs to be accessed via /bin/bash.
RUN echo LS_COLORS=$LS_COLORS:\'di=1\;33:ln=36\' >> ~/.bashrc \
    && echo export LS_COLORS >> ~/.bashrc \
    && echo 'source ~/.powerline.sh' >> ~/.bashrc \
    && echo 'alias tmux="tmux -2"' >> ~/.bashrc \
    && echo 'PATH=~/bin:$PATH' >> ~/.bashrc \
    && touch ~/.sudo_as_admin_successful # To surpress the sudo message at run.

CMD sudo service ssh start && /bin/bash

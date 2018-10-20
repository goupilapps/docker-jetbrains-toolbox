FROM ubuntu:latest

LABEL maintainer "Jean-Marie Bise <goupilapps@gmail.com>"
RUN echo 87 > file

RUN  \
  apt-get update && apt-get install --no-install-recommends -y \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 \
  fuse kmod libglu1 libdbus-1-3 libglib2.0-0 \
  libxkbcommon-dev libxcb-xkb-dev libxslt1-dev libgstreamer-plugins-base1.0-0 \
  nvidia-340 mesa-utils < file

ARG idea_source=https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.11.4269.tar.gz
ARG idea_local_dir=.Toolbox2018

RUN mkdir /opt/idea
WORKDIR /opt/idea

ADD $idea_source /opt/idea/installer.tgz

RUN tar --strip-components=1 -xzf installer.tgz && rm installer.tgz

RUN useradd -ms /bin/bash developer
RUN chmod +x jetbrains-toolbox
#RUN modprobe fuse && groupadd fuse
#RUN usermod -a -G fuse $(whoami)
RUN chown developer:developer jetbrains-toolbox
RUN chown -R developer:developer /opt/idea

USER developer
ENV HOME /home/developer

RUN mkdir /home/developer/.Idea \
  && ln -sf /home/developer/.Idea /home/developer/$idea_local_dir
  
RUN ./jetbrains-toolbox --appimage-extract

WORKDIR /opt/idea/squashfs-root

ENV APPDIR /opt/idea/squashfs-root
CMD [ "/opt/idea/squashfs-root/AppRun" ]

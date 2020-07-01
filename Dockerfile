FROM jenkins/jenkins:lts

MAINTAINER tuimac

ARG plugin=/usr/share/jenkins/ref/plugins.txt
ARG config=/var/jenkins_home/casc_configs/jenkins.yaml

ENV JAVA_OPTS '-Djenkins.install.runSetupWizard=false -Duser.timezone=Asia/Tokyo -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8'

USER root
WORKDIR /root

EXPOSE 8080
EXPOSE 50000

ADD env/bashrc /root/.bashrc
ADD env/login_screen /root/.login_screen
ADD env/vimrc /etc/vim/vimrc.local
ADD config/plugins.txt $plugin 
ADD config/requirements.txt /root/requirements.txt
ADD .aws /root/.aws

RUN apt update && \
    apt upgrade -y && \
    apt install -y vim* traceroute net-tools dnsutils python-pip python3-pip && \
    /usr/local/bin/install-plugins.sh < $plugin && \
    mkdir -p /etc/vim/undo && \
    mkdir -p /etc/vim/backup && \
    pip3 install -r requirements.txt \
    mkdir /opt/tagdns

ADD env/vimrc /etc/vim/vimrc.local
ADD config/jenkins.yaml $config

ENV CASC_JENKINS_CONFIG $config

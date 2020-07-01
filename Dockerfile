FROM jenkins/jenkins:lts

MAINTAINER tuimac

ENV JAVA_OPTS '-Djenkins.install.runSetupWizard=false -Duser.timezone=Asia/Tokyo -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8'

USER root
WORKDIR /root

EXPOSE 8080
EXPOSE 50000

ADD env/bashrc /root/.bashrc
ADD env/login_screen /root/.login_screen
ADD env/vimrc /etc/vim/vimrc.local
ADD config/plugins.txt /usr/share/jenkins/ref/plugins.txt
ADD config/requirements.txt /root/requirements.txt

RUN apt update && \
    apt upgrade -y && \
    apt install -y vim* traceroute net-tools dnsutils python-pip python3-pip && \
    /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt && \
    mkdir -p /etc/vim/undo && \
    mkdir -p /etc/vim/backup && \
    mkdir -p /usr/share/jenkins/ref/casc_configs && \
    pip3 install -r requirements.txt

ADD env/vimrc /etc/vim/vimrc.local
ADD config/jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml

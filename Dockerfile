FROM jenkins/jenkins:lts
ARG HOST_UID=1004
ARG HOST_GID=134
USER root


RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
       
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN groupadd docker
RUN usermod -u ${HOST_UID} jenkins
RUN groupmod -g ${HOST_GID} docker
RUN usermod -aG docker jenkins

USER jenkins
#RUN jenkins-plugin-cli --plugins "blueocean:1.25.0 docker-workflow:1.26"
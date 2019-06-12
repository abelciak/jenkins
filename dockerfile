FROM jenkins/jenkins:lts

MAINTAINER Adrian Belciak

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

WORKDIR /var/jenkins_home

COPY install-plugins.sh /var/jenkins_home/install-plugins.sh
COPY plugins.txt /var/jenkins_home/plugins.txt

USER root
RUN chmod +x /var/jenkins_home/install-plugins.sh
USER jenkins
RUN /var/jenkins_home/install-plugins.sh < /var/jenkins_home/plugins.txt

COPY scripts /var/jenkins_home/scripts
USER root
RUN chmod +x /var/jenkins_home/scripts/*.sh
COPY .ssh /var/jenkins_home/.ssh
RUN chown -R jenkins /var/jenkins_home/.ssh
RUN chmod 400 /var/jenkins_home/.ssh/id_rsa
USER jenkins
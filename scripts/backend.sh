#!/bin/bash
JENKINS_DIR="/var/jenkins_op"
GIT_DIR="/GIT"
GIT_REPOSITORY="${JENKINS_DIR}${GIT_DIR}/microservice_backend/"

echo "Stop backend containers"
#docker stop $(docker ps -a | grep backend | awk '{print $1}')
docker stop $(docker ps -a | grep $(cat ${GIT_REPOSITORY}/docker-compose-dev.yml | grep "container_name" | awk '{print $2}' | sed -e 's/^"//' -e 's/"$//' | sed ':a;N;$!ba;s/\n/\\|/g') | awk '{print $1}')

echo "Delete backend containers"
#docker rm $(docker ps -a | grep backend | awk '{print $1}')
docker rm $(docker ps -a | grep $(cat ${GIT_REPOSITORY}/docker-compose-dev.yml | grep "container_name" | awk '{print $2}' | sed -e 's/^"//' -e 's/"$//' | sed ':a;N;$!ba;s/\n/\\|/g') | awk '{print $1}')

echo "Clone GIT repository backend"
cd ${JENKINS_DIR}${GIT_DIR}
git clone https://github.com/oziomek1/microservice_backend.git
cd ${GIT_REPOSITORY}
git pull

cd ${GIT_REPOSITORY}
if [[ $1 == "-deploy" ]]; then
	echo "Start deployment backend"
	./start.sh
	echo "Finish deployment"
	exit
elif [[ $1 == "-test" ]]; then
	echo "Start tests backend"
	./start.sh -test
	echo "Finish tests"
	exit
fi
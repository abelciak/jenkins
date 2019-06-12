#!/bin/bash
JENKINS_DIR="/var/jenkins_op"
GIT_DIR="/GIT"
GIT_REPOSITORY="${JENKINS_DIR}${GIT_DIR}/course-wpz-frontend/"

echo "Stop frontend containers"
#docker stop $(docker ps -a | grep backend | awk '{print $1}')
docker stop $(docker ps -a | grep "course-wpz-frontend_app" | awk '{print $1}')

echo "Delete backend containers"
#docker rm $(docker ps -a | grep backend | awk '{print $1}')
docker rm $(docker ps -a | grep "course-wpz-frontend_app" | awk '{print $1}')

echo "Clone GIT repository frontend"
cd ${JENKINS_DIR}${GIT_DIR}
git clone https://github.com/tszymanik/course-wpz-frontend.git
cd ${GIT_REPOSITORY}
git pull

cd ${GIT_REPOSITORY}
echo "Start deployment frontend"
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up -d --build
echo "Finish deployment"
exit

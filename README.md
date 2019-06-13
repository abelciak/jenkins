# About
Jenkins to deploy university project. Jenkins provides backend and frontend. Jenkins runs tests backend and deploy backend + frontend on Docker.

## Requirement
Install docker, docker-compose and GIT on your machine.

## Usage
Run commands below
```bash
# Create directory with jenkins (mapping docker)
sudo mkdir /var/jenkins_op
sudo chown -R 1000 /var/jenkins_op

# Add user 'jenkins_op' on your machine with SSH Key. It will deploy containers
sudo adduser jenkins_op --disabled-password
sudo usermod -a -G docker jenkins_op
sudo mkdir /home/jenkins_op/.ssh
sudo chmod 700 /home/jenkins_op/.ssh
sudo touch /home/jenkins_op/.ssh/authorized_keys
sudo bash -c 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXOh1NDfDhF3OGifD/MPxoJSDl6wMIpZKman/CiS0NzC3+OkDJLMK5h3ZbOfsWfYuvAXy9cmCaVnseF3zBkqCT1w7NZJMnAP+19OmIbqmF1i/YnSQIJg3W+fxDcNA7FL6bBE03bAYWTcTWflcnetv1iBSdJQCSkZIiay4Z4v7zyx3CyNNTTxuwhN18DXkyFRST9FiOJ+kz6VXODfwMqbAhbVk1E76or/Fpd7kmOwF3PsZfpHURYE+ilzSebkOjsOGlWm+ZIEMwi12Q5sIAzmVHvH9k9wYSf0P0Pjv/ms7vsrEftK+sIil7Igq8rwshu2kA+j9odTJ3KPbrhLFlK8Xx jenkins_op@localhost" > /home/jenkins_op/.ssh/authorized_keys'
sudo chmod 600 /home/jenkins_op/.ssh/authorized_keys
sudo chown -R jenkins_op /home/jenkins_op/.ssh

# Change privileges for jenkins container
sudo chmod 400 /var/jenkins_op/.ssh/id_rsa
sudo chmod 700 /var/jenkins_op/.ssh
sudo chmod +x /var/jenkins_op/scripts
sudo chmod -R 777 /var/jenkins_op/GIT

```

## Build container with Jenkins
```bash
docker build -t jenkins_op .
docker run -d --network=host -v /var/jenkins_op:/var/jenkins_home jenkins_op:latest
```

Jenkins will available on address http://localhost:8080 with configuration jobs and plugins. It doesn't require login.

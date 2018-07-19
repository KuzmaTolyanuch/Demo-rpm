#!/bin/bash
# This script will install Java, Jenkins, Docker, Ansible, Maven, Artifactory
#############################
# Utils setup
#############################
sudo yum update -y
sudo yum install -y net-tools
sudo yum install -y git
sudo yum install -y curl
sudo yum install -y wget

#############################
# Java
#############################
sudo rm -rf /usr/java
wget --no-cookies \
--no-check-certificate \
--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz \
-O /opt/jdk-8u181-linux-x64.tar.gz
cd /opt && tar zxf jdk-8u181-linux-x64.tar.gz && mkdir /usr/java/ && mv /opt/jdk1.8.0_181 /usr/java && rm /opt/jdk-8u181-linux-x64.tar.gz
Update alternatives section
update-alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_181/jre/bin/java 20000
update-alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0_181/bin/jar 20000
update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_181/bin/javac 20000
update-alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0_181/jre/bin/javaws 20000
update-alternatives --set java /usr/java/jdk1.8.0_181/jre/bin/java
update-alternatives --set javaws /usr/java/jdk1.8.0_181/jre/bin/javaws
update-alternatives --set javac /usr/java/jdk1.8.0_181/bin/javac
update-alternatives --set jar /usr/java/jdk1.8.0_181/bin/jar
#check version
java -version

##############################
# Jenkins
##############################

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
sudo systemctl start jenkins.service
sudo systemctl status jenkins

sudo systemctl stop firewalld
sudo systemctl disable firewalld

#################################
# Saving Jenkins Initial Pass
#################################
sudo cp /var/lib/jenkins/secrets/initialAdminPassword /vagrant/JenkinsPass.txt
echo "Jenkins install complete, Initial Password is in a local project directory"

##############################
# Docker
##############################

sudo cp /vagrant/ansible/docker.repo /etc/yum.repos.d/docker.repo

yum install -y docker-engine
service docker start
usermod -aG docker $(whoami)
chkconfig docker on

##############################
# Ansible
##############################
sudo yum install -y epel-release
sudo yum install -y ansible
ansible --version

sudo cp /vagrant/ansible/ansible.cfg /etc/ansible/
sudo cp /vagrant/ansible/hosts /etc/ansible/

##############################
# Maven install
##############################

sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn -v

##############################
# Install Artifactory OSS
##############################

wget https://bintray.com/jfrog/artifactory-rpms/rpm -O bintray-jfrog-artifactory-rpms.repo
sudo mv bintray-jfrog-artifactory-rpms.repo /etc/yum.repos.d/
sudo yum install -y jfrog-artifactory-oss
sudo systemctl start artifactory
sudo systemctl restart artifactory

##############################
# Env hostnames
##############################

sudo tee -a /etc/hosts << END
192.168.100.10 master
192.168.100.11 dev
192.168.100.12 stage
192.168.100.13 qa
END

##############################
# Python dependencies
##############################
sudo yum install -y epel-release
sudo yum install -y python2-pip
sudo pip install --upgrade pip
sudo pip uinstall docker
sudo pip install docker-py

sudo cp /vagrant/daemon.json /etc/docker/

##############################
# Run Ansible provisioning
##############################
# ansible-playbook 

echo "Success"

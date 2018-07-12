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
rm -rf /usr/java

wget --no-cookies \
--no-check-certificate \
--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz \
-O /opt/jdk-8u172-linux-x64.tar.gz
cd /opt && tar zxf jdk-8u172-linux-x64.tar.gz && mkdir /usr/java/ && mv /opt/jdk1.8.0_172 /usr/java && rm /opt/jdk-8u172-linux-x64.tar.gz
#Update alternatives section
update-alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_172/jre/bin/java 20000
update-alternatives --install /usr/bin/jar jar /usr/java/jdk1.8.0_172/bin/jar 20000
update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_172/bin/javac 20000
update-alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0_172/jre/bin/javaws 20000
update-alternatives --set java /usr/java/jdk1.8.0_172/jre/bin/java
update-alternatives --set javaws /usr/java/jdk1.8.0_172/jre/bin/javaws
update-alternatives --set javac /usr/java/jdk1.8.0_172/bin/javac
update-alternatives --set jar /usr/java/jdk1.8.0_172/bin/jar
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

tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

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

sudo tee /etc/ansible/hosts <<-'EOF'
192.168.100.10
192.168.100.11
192.168.100.12
192.168.100.13
EOF

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

echo "Success"
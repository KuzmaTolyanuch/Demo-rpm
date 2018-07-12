# Demo-rpm
CI/CD lab 
Java, Jenkins, Docker, Ansible, Maven, Artifactory

This code will run instance on CentOS 7 using vagrant on public IP address:
```bash
http://192.168.100.10:8080/ - Jenkins
```
```bash
http://192.168.100.10:8081/ - Artifactory
```
And 3 environments:
```bash
Dev - 192.168.100.11
Stage - 192.168.100.12
QA - 192.168.100.13
```
## Prerequisites
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

Usage
-----

```bash
$ git clone https://github.com/KuzmaTolyanuch/Demo-rpm
$ cd Demo-rpm
$ vagrant up --provision
```

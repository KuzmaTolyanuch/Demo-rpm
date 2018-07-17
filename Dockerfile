FROM openjdk
LABEL maintainer="kuzma"
ADD http://192.168.100.10:8081/artifactory/demo/demo-0.0.1-SNAPSHOT.jar /home/
CMD ["java","-jar","/home/demo-0.0.12-SNAPSHOT.jar"]

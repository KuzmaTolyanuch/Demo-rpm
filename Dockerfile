FROM openjdk
LABEL maintainer="kuzma"
COPY demo-0.0.1-SNAPSHOT.jar /home
CMD ["java","-jar","/home/demo-0.0.1-SNAPSHOT.jar"]

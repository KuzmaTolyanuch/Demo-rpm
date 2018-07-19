FROM openjdk
LABEL maintainer="kuzma"
COPY app.jar /home
CMD ["java","-jar","/home/app.jar"]

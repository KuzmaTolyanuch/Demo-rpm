FROM java:8
COPY app.jar /opt/app/
WORKDIR /opt/app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]

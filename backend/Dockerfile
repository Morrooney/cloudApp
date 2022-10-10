FROM maven:3.8.5-openjdk-11
LABEL maintainer = "stefano.morrone@gmail.com"
COPY target/demo-0.0.1-SNAPSHOT.jar springboot-docker-demo.jar
ENTRYPOINT ["java","-jar","/springboot-docker-demo.jar"]
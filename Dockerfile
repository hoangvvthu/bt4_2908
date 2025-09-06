# Stage 1: build WAR
FROM maven:3.9.8-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: deploy WAR vào Tomcat 11
FROM tomcat:11.0.10-jdk21
# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy WAR vừa build vào ROOT.war
COPY --from=builder /app/target/demo-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

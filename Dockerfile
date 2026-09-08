# Step 1: Build file .war bằng Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Step 2: Chạy ứng dụng trên Apache Tomcat 10
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Khai báo rõ ràng biến môi trường PORT cho Render
ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
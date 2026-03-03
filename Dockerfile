# ---------- Stage 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-11-alpine AS build

WORKDIR /app
RUN apk add --no-cache git

RUN git clone https://github.com/pelthepu/todo-api.git .

RUN mvn clean package -DskipTests


# ---------- Stage 2: Runtime ----------
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
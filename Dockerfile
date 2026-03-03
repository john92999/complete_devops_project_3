# ---------- Stage 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-11-alpine AS build

WORKDIR /app

# Install git only
RUN apk add --no-cache git

# Clone repository
RUN git clone https://github.com/pelthepu/todo-api.git .

# Build jar
RUN mvn clean package -DskipTests


# ---------- Stage 2: Runtime ----------
FROM eclipse-temurin:11-jre-alpine

# Install MongoDB (light Alpine version)
RUN apk add --no-cache mongodb

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Create Mongo DB directory
RUN mkdir -p /data/db

EXPOSE 8080 27017

# Start Mongo + Spring Boot
CMD mongod --fork --logpath /var/log/mongod.log --dbpath /data/db && \
    java -Dspring.data.mongodb.uri=mongodb://localhost:27017/tododb \
    -jar app.jar
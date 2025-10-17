# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

COPY mvnw .
COPY .mvn/ .mvn
COPY pom.xml .
COPY src ./src

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy the jar file — make sure the name matches the real jar
COPY --from=builder /app/target/*SNAPSHOT.jar app.jar

EXPOSE 2000
ENTRYPOINT ["java", "-jar", "app.jar"]
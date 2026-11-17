# Use a Java 21 runtime image
FROM eclipse-temurin:21-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the executable Spring Boot JAR into the image
COPY target/app-service.jar app.jar

# Document the application port
EXPOSE 8080

# Start the microservice
ENTRYPOINT ["java", "-jar", "app.jar"]

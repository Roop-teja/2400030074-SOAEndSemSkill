# App Service — Docker Containerization Lab

A small Spring Boot REST microservice for the lab experiment.

## Requirements
- JDK 21
- Maven 3.6.3 or later
- Docker Desktop (running)

## Import into Spring Tool Suite (STS)
1. Extract the ZIP file.
2. Open STS and choose **File → Import → Maven → Existing Maven Projects**.
3. Browse to the extracted `app-service` folder.
4. Select the project and click **Finish**.
5. Wait for Maven dependencies to download.

## Run locally in STS
1. Right-click `AppServiceApplication.java`.
2. Choose **Run As → Spring Boot App**.
3. Open http://localhost:8080/api/data

Expected JSON:
```json
{
  "message": "Microservice is running successfully!"
}
```

Stop the local application in the STS Console before running the Docker container,
so port 8080 is available.

## Build the executable JAR
Open Command Prompt in the project root (the folder containing `pom.xml`).

If you want Maven to use JDK 21 in the current Command Prompt, run:
```cmd
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.0.13.9-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
mvn -version
```

Then build:
```cmd
mvn clean package
```

The executable JAR will be created at:
`target/app-service.jar`

## Build the Docker image
Make sure Docker Desktop is running, then run from the project root:
```cmd
docker build -t app-service:v1 .
```

## Run the container
```cmd
docker run --name app-service-container -p 8080:8080 app-service:v1
```

Open:
http://localhost:8080/api/data

Expected JSON:
```json
{
  "message": "Microservice is running successfully!"
}
```

## Verify and stop
In another Command Prompt:
```cmd
docker ps
```

To stop the container, press `Ctrl+C` in the terminal running it, or use:
```cmd
docker stop app-service-container
```

To remove the stopped container:
```cmd
docker rm app-service-container
```

If the container name is already in use, remove the old stopped container before running
the `docker run --name ...` command again:
```cmd
docker rm -f app-service-container
```

## Important
- Run Maven package before `docker build`, because the Dockerfile copies `target/app-service.jar`.
- Do not run the local STS application and Docker container on port 8080 at the same time.
- The first Maven and Docker builds need internet access to download dependencies/base images.

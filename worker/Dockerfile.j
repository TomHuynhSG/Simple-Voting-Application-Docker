# Use Maven image to build the application
FROM maven:3.5-jdk-8-alpine AS build

# Set the working directory
WORKDIR /code

# Copy the Maven configuration file and resolve dependencies
COPY pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Copy the source code and package it into a fat jar
COPY ["src/main", "/code/src/main"]
RUN ["mvn", "package"]

# Use OpenJDK image to run the application
FROM openjdk:8-jre-alpine

# Copy the packaged jar from the build stage
COPY --from=build /code/target/worker-jar-with-dependencies.jar /

# Run the application with specific JVM options
CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/worker-jar-with-dependencies.jar"]

# Use the .NET SDK image to build the application
FROM microsoft/dotnet:2.1-sdk-nanoserver-sac2016 as builder

# Set the working directory
WORKDIR /Worker

# Copy the project file and restore dependencies
COPY Worker/Worker.csproj .
RUN dotnet restore

# Copy the remaining source code and publish the application
COPY /Worker .
RUN dotnet publish -c Release -o /out Worker.csproj

# Use the .NET runtime image for the application
FROM microsoft/dotnet:2.1-runtime-nanoserver-sac2016

# Set the working directory
WORKDIR /app

# Set the entry point for the application
ENTRYPOINT ["dotnet", "Worker.dll"]

# Copy the published output from the build stage
COPY --from=builder /out .
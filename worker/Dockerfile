# Use the .NET Core SDK image to build the application
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder

# Set the working directory inside the container
WORKDIR /Worker

# Copy the project file and restore dependencies
COPY src/Worker/Worker.csproj .
RUN dotnet restore

# Copy the remaining source code and publish the application
COPY src/Worker/ .
RUN dotnet publish -c Release -o /out Worker.csproj

# Use the .NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/core/runtime:3.1

# Set the working directory for the runtime container
WORKDIR /app

# Set the entry point for the application
ENTRYPOINT ["dotnet", "Worker.dll"]

# Copy the published output from the build stage
COPY --from=builder /out .
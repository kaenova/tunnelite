# Stage 1: Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy everything to the build container
COPY src/Tunnelite.Server/. ./

# Publish the project as a single file and self-contained
RUN dotnet publish -c Release -o out

# Stage 2: Runtime Stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app

# Copy the build artifacts from the build container
COPY --from=build /app/out ./

# Specify the command to run the application
ENTRYPOINT ["./Tunnelite.Server"]

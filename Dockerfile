#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

# FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
# WORKDIR /app
# EXPOSE 80
# EXPOSE 443

# FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
# WORKDIR /src
# COPY ["DevOps_Assignment.csproj", ""]
# RUN dotnet restore "./DevOps_Assignment.csproj"
# COPY . .
# WORKDIR "/src/."
# RUN dotnet build "DevOps_Assignment.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "DevOps_Assignment.csproj" -c Release -o /app/publish

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "DevOps_Assignment.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
 
WORKDIR /app
 
COPY DevOps_Assignment/DevOps_Assignment.csproj ./
RUN dotnet restore
 
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
 
WORKDIR /app
 
COPY --from=build-env /app/out .
 
ENTRYPOINT ["dotnet", "DevOps_Assignment.dll"]

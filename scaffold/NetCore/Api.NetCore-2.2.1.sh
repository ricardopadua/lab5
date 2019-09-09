#!/bin/bash

## api .netcore-2.2
## Ricardo Pádua - ricardo.padua4@gmail.com


## Solution name
solution=$1

## Create solution
dotnet new sln --name ${solution}

## Create solution folder
mkdir src && cd src
## Create project Api
dotnet new api --no-https --name ${solution}.Api
## Create project Domain
dotnet new classlib --name ${solution}.Domain
## Create project Application
dotnet new classlib --name ${solution}.Infra

## Create project Test
cd ..
mkdir test && cd test
dotnet new xunit --name ${solution}.Test


## joining project in solution
 cd ..
 ## joining Api project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Api
 # joining classlib project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Domain
 # joining classlib project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Infra
## joining project in a solution
dotnet sln  ${solution}.sln add test/${solution}.Test



## Api

## Create references Api
 cd src
dotnet add ${solution}.Api/${solution}.Api.csproj reference ${solution}.Domain/${solution}.Domain.csproj
dotnet add ${solution}.Api/${solution}.Api.csproj reference ${solution}.Infra/${solution}.Infra.csproj
## install packages nuget Api
cd ${solution}.Api
dotnet add package Swashbuckle.AspNetCore --version 4.0.1
dotnet add package IdentityServer4.AccessTokenValidation --version 2.7.0 
dotnet add package log4net --version 2.0.8
dotnet add package Microsoft.AspNetCore.ResponseCompression --version 2.2.0
dotnet add package Microsoft.Extensions.Configuration.Json --version 2.2.0
cd ..


## Infra

## Create references Infra
dotnet add ${solution}.Infra/${solution}.Infra.csproj reference ${solution}.Domain/${solution}.Domain.csproj
## install packages nuget Infra
cd ${solution}.Infra
dotnet add package Microsoft.EntityFrameworkCore --version 2.2.0 
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL --version 2.2.0
dotnet add package Microsoft.EntityFrameworkCore.Tools --version 2.2.0 
dotnet add package Microsoft.EntityFrameworkCore.Design --version 2.2.0 
cd ..


## Domain

## install packages nuget Infra
cd ${solution}.Domain
dotnet add package FluentValidation.AspNetCore --version 8.4.0
dotnet add package FluentValidator --version 2.0.4
cd ..

## Test

## Create references Test
cd .. && cd test
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Domain/${solution}.Domain.csproj
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Api/${solution}.Api.csproj
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Infra/${solution}.Infra.csproj
## install packages nuget Test
cd ${solution}.Test
dotnet add package SpecFlow --version 3.0.225
dotnet add package SpecFlow.xUnit --version 3.0.225
cd .. && cd ..

 cd src && cd ${solution}.Api

## Create Dockerfile in Api Project
cd src && cd ${solution}.Api

touch Dockerfile 

echo FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base > Dockerfile
echo WORKDIR /app >> Dockerfile
echo EXPOSE 80 >> Dockerfile

echo FROM microsoft/dotnet:2.2-sdk AS build >> Dockerfile
echo WORKDIR /src >> Dockerfile
echo COPY ["src/${solution}.Api/${solution}.Api.csproj", "src/${solution}.Api/"] >> Dockerfile
echo COPY ["src/${solution}.Domain/${solution}.Domain.csproj", "src/${solution}.Domain/"] >> Dockerfile
echo COPY ["src/${solution}.Infra/${solution}.Infra.csproj", "src/${solution}.Infra/"] >> Dockerfile
echo RUN dotnet restore "src/${solution}.Api/${solution}.Api.csproj" >> Dockerfile
echo COPY . . >> Dockerfile
echo WORKDIR "/src/src/${solution}.Api" >> Dockerfile
echo RUN dotnet build "${solution}.Api.csproj" -c Release -o /app >> Dockerfile

echo FROM build AS publish >> Dockerfile
echo RUN dotnet publish "${solution}.Api.csproj" -c Release -o /app >> Dockerfile

echo FROM base AS final >> Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY --from=publish /app . >> Dockerfile
echo ENTRYPOINT ["dotnet", "${solution}.Api.dll"] >> Dockerfile

## Create docker-compose.yml for backend solution
cd .. && cd .. 





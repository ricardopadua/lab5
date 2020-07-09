#!/bin/bash
## Ricardo Pádua
## api .netcore-3.1
## Solution name
solution=$1
## Create solution
mkdir src && dotnet new sln --name ${solution} && 
## Create solution folder
cd src
## Create project Api
dotnet new webapi --no-https --name ${solution}.Api
## Create project Application
dotnet new classlib --name ${solution}.Application
## Create project Domain
dotnet new classlib --name ${solution}.Domain
## Create project Infra
dotnet new classlib --name ${solution}.Infra
##Serviço para executar em backgroud o envio de mensagens
dotnet new Worker --name ${solution}.Workers
## Create project Test
cd ..
mkdir test && cd test
dotnet new xunit --name ${solution}.Test
## joining project in solution
 cd ..
 ## joining WebApi project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Api
 # joining classlib project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Application
 # joining classlib project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Domain
 # joining classlib project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Infra
  # joining Workers project in a solution
 dotnet sln  ${solution}.sln add src/${solution}.Workers
## joining project in a solution
dotnet sln  ${solution}.sln add test/${solution}.Test
## Api
## Create references Api
 cd src
dotnet add ${solution}.Api/${solution}.Api.csproj reference ${solution}.Application/${solution}.Application.csproj
## install packages nuget Api
cd ${solution}.Api
dotnet add package Swashbuckle.AspNetCore.Swagger --version 5.5.1
dotnet add package Microsoft.AspNetCore.ResponseCompression --version 2.2.0
dotnet add package Microsoft.Extensions.Configuration.Json --version 2.2.0
dotnet add package AutoMapper --version 10.0.0
dotnet add package AutoMapper.Extensions.Microsoft.DependencyInjection --version 7.0.0
dotnet add package MediatR --version 8.0.2
dotnet add package MediatR.Extensions.Microsoft.DependencyInjection --version 8.0.1
dotnet add package RabbitMQ.Client --version 6.1.0
cd ..
## Infra
## Create references Infra
dotnet add ${solution}.Infra/${solution}.Infra.csproj reference ${solution}.Domain/${solution}.Domain.csproj
## install packages nuget Infra
cd ${solution}.Infra
dotnet add package Dapper --version 2.0.35
dotnet add package Dapper.SqlBuilder --version 2.0.35
dotnet add package Npgsql --version 4.1.3.1
dotnet add package Microsoft.EntityFrameworkCore --version 3.1.5
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL --version 3.1.4
dotnet add package Npgsql.Json.NET --version 4.1.3
dotnet add package MailKit --version 2.7.0
dotnet add package AutoMapper --version 10.0.0
cd ..
## Application
## install packages nuget Application
cd ${solution}.Application
dotnet add package Microsoft.Extensions.Logging --version 3.1.5
dotnet add package MediatR --version 8.0.2
dotnet add package AutoMapper --version 10.0.0
cd ..
## Domain
## install packages nuget Domain
cd ${solution}.Domain
dotnet add package FluentValidation --version 9.0.0
dotnet add package MediatR --version 8.0.2
cd ..
## Workers
## Create references Workers
dotnet add ${solution}.Workers/${solution}.Workers.csproj reference ${solution}.Application/${solution}.Application.csproj
## install packages nuget Workers
cd ${solution}.Workers
dotnet add package RabbitMQ.Client --version 6.1.0
cd ..
## Test
## Create references Test
cd .. && cd test
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Domain/${solution}.Domain.csproj
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Api/${solution}.Api.csproj
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Infra/${solution}.Infra.csproj
dotnet add ${solution}.Test/${solution}.Test.csproj reference ../src/${solution}.Application/${solution}.Application.csproj
## install packages nuget Test
cd ${solution}.Test
dotnet add package SpecFlow --version 3.0.225
dotnet add package SpecFlow.xUnit --version 3.0.225
cd .. && cd ..


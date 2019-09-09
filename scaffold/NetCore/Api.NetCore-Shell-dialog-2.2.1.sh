#!/bin/sh -x
# Design a DDD-oriented microservice
# Ricardo Pádua
# https://github.com/ricardopadua/WebApi


main(){
	clear
	echo 
	echo "Qual o nome do projeto ?"
	read SOLUTION
		if [ ! -z $SOLUTION ]
			then
				clear
				echo "Criando diretorio do projeto ..."
				echo "mkdir backend && cd backend"
				mkdir backend && cd backend
				sleep 1
				echo	
				echo "Criando solução do projeto ..."
				dotnet new sln --name ${SOLUTION}
				sleep 1
				echo
				echo "Criando projeto e camadas (Microsserviço orientado a DDD) ..."
				echo "https://docs.microsoft.com/pt-br/dotnet/standard/microservices-architecture/microservice-ddd-cqrs-patterns/ddd-oriented-microservice"
				echo
				sleep 1
				mkdir src && cd src
				dotnet new webapi --name ${SOLUTION}.WebApi 
				dotnet new classlib --name ${SOLUTION}.Domain
				dotnet new classlib --name ${SOLUTION}.Infrastructure
				echo
				echo "Referêncindo camadas do projeto ..."
				sleep 1
				dotnet add ${SOLUTION}.WebApi/${SOLUTION}.WebApi.csproj reference ${SOLUTION}.Infrastructure/${SOLUTION}.Infrastructure.csproj
				dotnet add ${SOLUTION}.Infrastructure/${SOLUTION}.Infrastructure.csproj reference ${SOLUTION}.Domain/${SOLUTION}.Domain.csproj
				
				echo
				echo "Instalando pacotes necessários ..."
				cd ${SOLUTION}.WebApi
				dotnet add package Swashbuckle.AspNetCore --version 2.5.0
				cd ..
				cd ${SOLUTION}.Domain
				echo "mkdir Entities"
				mkdir Entities
				## Package Install Not Found
				cd ..
				cd ${SOLUTION}.Infrastructure
				echo "mkdir Repositories Interfaces Utils"
				mkdir Repositories Interfaces Utils
				dotnet add package Microsoft.EntityFrameworkCore --version 2.2.0 
				dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL --version 2.2.0
				dotnet add package Microsoft.EntityFrameworkCore.Tools --version 2.2.0 
				dotnet add package Microsoft.EntityFrameworkCore.Design --version 2.2.0 
				cd .. && cd ..
				dotnet sln ${SOLUTION}.sln add src/${SOLUTION}.WebApi src/${SOLUTION}.Domain src/${SOLUTION}.Infrastructure
				sleep 1
				echo "Criando NugetConfig"
				dotnet new nugetconfig
				sleep 1	
				echo "Criando Dockerfile"
				sleep 1	
				touch Dockerfile 
				echo '##Dockerfile Default Project .Net Core 2.2' > Dockerfile
				echo FROM microsoft/dotnet:2.2-sdk AS build-env >> Dockerfile
				echo WORKDIR /app >> Dockerfile
				echo COPY . . >> Dockerfile
				echo RUN dotnet restore --configfile ./NuGet.Config >> Dockerfile
				echo WORKDIR /app/src/${SOLUTION}.WebApi >> Dockerfile
				echo RUN dotnet publish -c Release -o /out >> Dockerfile
				echo FROM microsoft/dotnet:2.2-aspnetcore-runtime >> Dockerfile
				echo WORKDIR /app >> Dockerfile
				echo COPY --from=build-env /out . >> Dockerfile
				echo ENTRYPOINT ["dotnet", "${SOLUTION}.WebApi.dll"] >> Dockerfile
				echo EXPOSE 80 >> Dockerfile

				echo "Iniciando o projeto no VS Code."
				code .
				sleep 1
				exit 0;
		else
			exit 0;
fi
}
main;

FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["src/ProjectName.Api/ProjectName.Api.csproj", "src/ProjectName.Api/"]
COPY ["src/ProjectName.Infra/ProjectName.Infra.csproj", "src/ProjectName.Infra/"]
COPY ["src/ProjectName.Domain/ProjectName.Domain.csproj", "src/ProjectName.Domain/"]
RUN dotnet restore "src/ProjectName.Api/ProjectName.Api.csproj"
COPY . .
WORKDIR "/src/src/ProjectName.Api"
RUN dotnet build "ProjectName.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ProjectName.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ProjectName.Api.dll"]
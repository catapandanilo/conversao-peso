FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

LABEL maintainer="Catapan SA"

COPY ConversaoPeso.Web/*.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet publish ConversaoPeso.sln -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]
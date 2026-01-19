**Перед подключением:**

1. Установите зависимости:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https dotnet-sdk-6.0
   ```

1. Создайте директорию для проекта:

    ```bash
    cd ~/ && mkdir cs-project && cd cs-project
    ```

1. Создайте конфигурационный файл:

    {% cut "RedisClient.csproj" %}

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
      </PropertyGroup>
      <ItemGroup>
        <PackageReference Include="StackExchange.Redis" Version="2.8.58" />
      </ItemGroup>
    </Project>
    ```

    {% endcut %}

1. Для подключения с SSL [получите SSL-сертификат](../../../../../managed-valkey/operations/connect/index.md#get-ssl-cert).

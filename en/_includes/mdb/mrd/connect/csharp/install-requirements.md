**Before connecting:**

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https dotnet-sdk-6.0
   ```

1. Create a directory for the project:

    ```bash
    cd ~/ && mkdir cs-project && cd cs-project
    ```

1. Create a configuration file:

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

1. To connect with SSL, [get an SSL certificate](../../../../../managed-redis/operations/connect/index.md#get-ssl-cert).

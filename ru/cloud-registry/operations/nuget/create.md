---
title: Создать NuGet-пакет
description: Следуя данной инструкции, вы создадите NuGet-пакет для загрузки в {{ cloud-registry-name }}.
---

# Создать NuGet-пакет

В этой инструкции описано, как создать [NuGet-пакет](../../concepts/artifacts/nuget.md) для последующей загрузки в реестр {{ cloud-registry-name }}.

## Структура NuGet-пакета {#package-structure}

Пример структуры проекта:

```
MyPackage/               # Корневая директория проекта
│
├── MyPackage.csproj     # Файл проекта с метаданными пакета
├── Class1.cs            # Исходный код библиотеки
├── README.md            # Описание проекта
└── bin/Release/         # Результат сборки
    └── MyPackage.0.0.1.nupkg
```

## Создание пакета {#create-package}

{% list tabs group=nuget_tools %}

- dotnet CLI {#dotnet}

    1. Установите [.NET SDK](https://dotnet.microsoft.com/download).

    1. Создайте проект библиотеки:

        ```bash
        dotnet new classlib -n MyPackage && cd MyPackage
        ```

    1. Создайте файл `README.md`:

        ```bash
        cat > README.md << 'EOF'
        # MyPackage
        A small example package.
        EOF
        ```

    1. Добавьте метаданные пакета в файл `MyPackage.csproj`:

        ```xml
        <Project Sdk="Microsoft.NET.Sdk">

          <PropertyGroup>
            <TargetFramework>net10.0</TargetFramework>
            <PackageId>MyPackage</PackageId>
            <Version>0.0.1</Version>
            <Authors>Example Author</Authors>
            <Description>A small example package</Description>
            <PackageReadmeFile>README.md</PackageReadmeFile>
          </PropertyGroup>

          <ItemGroup>
            <None Include="README.md" Pack="true" PackagePath="\" />
          </ItemGroup>

        </Project>
        ```

    1. Измените файл `Class1.cs`:

        ```csharp
        namespace MyPackage;

        public class Class1
        {
            public static string Hello() => "Hello from my package!";
        }
        ```

    1. Соберите пакет:

        ```bash
        dotnet pack -c Release
        ```

        Результат:

        ```text
        Successfully created package '/home/user/MyPackage/bin/Release/MyPackage.0.0.1.nupkg'.
        ```

- NuGet CLI {#nuget-cli}

    1. Установите [NuGet CLI](https://learn.microsoft.com/ru-ru/nuget/install-nuget-client-tools#nugetexe-cli).

    1. Создайте проект библиотеки по инструкции для dotnet CLI или используйте существующий и соберите его:

        ```bash
        dotnet build -c Release
        ```

    1. Создайте файл спецификации `MyPackage.nuspec`:

        ```xml
        <?xml version="1.0" encoding="utf-8"?>
        <package>
          <metadata>
            <id>MyPackage</id>
            <version>0.0.1</version>
            <authors>Example Author</authors>
            <description>A small example package</description>
            <readme>README.md</readme>
            <dependencies>
              <group targetFramework="net10.0" />
            </dependencies>
          </metadata>
          <files>
            <file src="bin\Release\net10.0\MyPackage.dll" target="lib\net10.0" />
            <file src="README.md" target="" />
          </files>
        </package>
        ```

        {% note info %}

        Файл `.nuspec` явно перечисляет файлы, которые попадут в пакет. Если не указать раздел `files`, в пакет будут добавлены все файлы из текущей директории.

        {% endnote %}

    1. Соберите пакет:

        ```bash
        nuget pack MyPackage.nuspec -OutputDirectory out
        ```

        Результат:

        ```text
        Successfully created package '/home/user/MyPackage/out/MyPackage.0.0.1.nupkg'.
        ```

{% endlist %}

## Что дальше {#what-is-next}

* [{#T}](push.md)
* [{#T}](pull.md)
* [{#T}](installation.md)

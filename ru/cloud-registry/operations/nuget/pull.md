---
title: Скачать NuGet-пакет из реестра {{ cloud-registry-name }}
description: Следуя данной инструкции, вы скачаете NuGet-пакет из реестра {{ cloud-registry-name }}.
---

# Скачать NuGet-пакет из реестра {{ cloud-registry-name }}

Для скачивания [NuGet-пакета](../../concepts/artifacts/nuget.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

1. [Настройте](installation.md) NuGet для работы с реестром {{ cloud-registry-name }}.

1. Скачайте пакет:

    {% list tabs group=nuget_tools %}

    - dotnet CLI {#dotnet}

      Выполните команду в директории проекта, в который нужно добавить пакет:

      ```bash
      dotnet add package <имя_пакета> \
        --version <версия_пакета> \
        --source "https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json"
      ```

      Где:

      * `<имя_пакета>` — имя устанавливаемого пакета.
      * `<версия_пакета>` — версия пакета. Если параметр не указан, будет установлена последняя стабильная версия.
      * `<идентификатор_реестра>` — идентификатор реестра.

      {% note info %}

      В параметре `--source` команды `dotnet add package` нужно указывать URL источника, а не его имя в конфигурации.

      {% endnote %}

      Результат:

      ```text
      info : Ссылка PackageReference для пакета "MyPackage" версии "0.0.1" добавлена в файл "/home/user/Consumer/Consumer.csproj".
      ```

      Если источник `cloud-registry` уже добавлен в конфигурацию NuGet, пакет можно добавить без параметра `--source`:

      ```bash
      dotnet add package <имя_пакета> --version <версия_пакета>
      ```

      {% note info %}

      Пакет можно скачать и неявно. Добавьте ссылку на пакет в файл проекта `.csproj`:

      ```xml
      <ItemGroup>
        <PackageReference Include="<имя_пакета>" Version="<версия_пакета>" />
      </ItemGroup>
      ```

      При восстановлении зависимостей проекта dotnet CLI скачает пакет из источника, добавленного в конфигурацию NuGet. Восстановление выполняется командой `dotnet restore`, а также автоматически при выполнении `dotnet build` и `dotnet run`.

      {% endnote %}

    - NuGet CLI {#nuget-cli}

      ```bash
      nuget install <имя_пакета> \
        -Version <версия_пакета> \
        -Source cloud-registry \
        -OutputDirectory packages
      ```

      Где:

      * `<имя_пакета>` — имя устанавливаемого пакета.
      * `<версия_пакета>` — версия пакета. Если параметр не указан, будет установлена последняя версия.
      * `cloud-registry` — имя источника пакетов, [добавленного в конфигурацию](installation.md).
      * `packages` — директория, в которую будет сохранен пакет.

      Результат:

      ```text
      Successfully installed 'MyPackage 0.0.1' to /home/user/Consumer/packages
      ```

    {% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](installation.md)
* [{#T}](create.md)
* [{#T}](push.md)

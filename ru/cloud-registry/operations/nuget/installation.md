---
title: Настроить NuGet
description: Следуя данной инструкции, вы настроите NuGet.
---

# Настроить NuGet

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Выполните настройки файла конфигурации [NuGet](../../concepts/artifacts/nuget.md):

    {% list tabs %}

    - dotnet CLI

      Чтобы внести изменения в файл конфигурации NuGet с помощью [dotnet CLI](https://learn.microsoft.com/ru-ru/nuget/reference/dotnet-commands), выполните команду:

      ```bash
      dotnet nuget add source "https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json" \
        -n "cloud-registry" \
        -u %REGISTRY_USERNAME% \
        -p %REGISTRY_PASSWORD% \
        --store-password-in-clear-text --protocol-version 3
      ```

    - NuGet CLI

      Чтобы внести изменения в файл конфигурации NuGet с помощью [NuGet CLI](https://learn.microsoft.com/ru-ru/nuget/reference/nuget-exe-cli-reference), запустите файл `nuget.exe` со следующими параметрами:

      ```
      nuget sources add -Name "cloud-registry" \
        -Source "https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json" \
        -Username "%REGISTRY_USERNAME%" \
        -Password "%REGISTRY_PASSWORD%" \
        -StorePasswordInClearText -ProtocolVersion 3
      ```

    - Вручную

      1. Откройте [файл конфигурации](https://learn.microsoft.com/en-us/nuget/consume-packages/configuring-nuget-behavior#config-file-locations-and-uses) NuGet.

          {% note info %}

          При использовании dotnet CLI файл конфигурации расположен по пути `~/.nuget/NuGet/NuGet.Config`, при использовании NuGet CLI — по пути `~/.config/NuGet/NuGet.Config`.

          {% endnote %}

      1. Замените конфигурацию файла на следующую:

          ```xml
          <?xml version="1.0" encoding="utf-8"?>
          <configuration>
            <packageSources>
              <add key="cloud-registry" value="https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json" protocolVersion="3" />
            </packageSources>

            <packageSourceCredentials>
              <cloud-registry>
                <add key="Username" value="%REGISTRY_USERNAME%" />
                <add key="ClearTextPassword" value="%REGISTRY_PASSWORD%" />
              </cloud-registry>
            </packageSourceCredentials>
          </configuration>
          ```

    {% endlist %}
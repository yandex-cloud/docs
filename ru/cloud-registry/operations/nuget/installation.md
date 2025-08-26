---
title: Настроить NuGet
description: Следуя данной инструкции, вы настроите NuGet.
---

# Настроить NuGet

1. Выполните настройки файла конфигурации [NuGet](../../concepts/art-nuget.md):

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

1. В зависимости от способа аутентификации:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которых вы будете выполнять аутентификацию.
      1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`, содержащие данные для аутентификации по IAM-токену:

          ```bash
          export REGISTRY_USERNAME="iam"
          export REGISTRY_PASSWORD="<IAM-токен>"
          ```

          Где `<IAM-токен>` — полученный ранее IAM-токен.

    - OAuth-токен {#oauth-token}

      1. [Получите]({{ link-cloud-oauth }}) OAuth-токен для аккаунта на Яндексе, от имени которого вы будете выполнять аутентификацию.
      1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`, содержащие данные для аутентификации по OAuth-токену:

          ```bash
          export REGISTRY_USERNAME="oauth"
          export REGISTRY_PASSWORD="<OAuth-токен>"
          ```

          Где `<OAuth-токен>` — полученный ранее [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

    {% endlist %}
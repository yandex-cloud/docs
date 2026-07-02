[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > NuGet-артефакт > Настроить NuGet

# Настроить NuGet

1. Создайте переменные окружения в зависимости от способа аутентификации:
   
   {% list tabs group=registry_auth %}
   
   - IAM-токен {#iam-token}
   
     1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="iam"
         export REGISTRY_PASSWORD="<IAM-токен>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов.
   
     {% endnote %}
   
   - API-ключ {#api-key}
   
     1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="api_key"
         export REGISTRY_PASSWORD="<API-ключ>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md).
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
   
     {% endnote %}
   
   {% endlist %}
1. Выполните настройки файла конфигурации [NuGet](../../concepts/artifacts/nuget.md):

    {% list tabs %}

    - dotnet CLI

      Чтобы внести изменения в файл конфигурации NuGet с помощью [dotnet CLI](https://learn.microsoft.com/ru-ru/nuget/reference/dotnet-commands), выполните команду:

      ```bash
      dotnet nuget add source "https://registry.yandexcloud.net/nuget/v3/<идентификатор_реестра>/index.json" \
        -n "cloud-registry" \
        -u %REGISTRY_USERNAME% \
        -p %REGISTRY_PASSWORD% \
        --store-password-in-clear-text --protocol-version 3
      ```

    - NuGet CLI

      Чтобы внести изменения в файл конфигурации NuGet с помощью [NuGet CLI](https://learn.microsoft.com/ru-ru/nuget/reference/nuget-exe-cli-reference), запустите файл `nuget.exe` со следующими параметрами:

      ```
      nuget sources add -Name "cloud-registry" \
        -Source "https://registry.yandexcloud.net/nuget/v3/<идентификатор_реестра>/index.json" \
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
              <add key="cloud-registry" value="https://registry.yandexcloud.net/nuget/v3/<идентификатор_реестра>/index.json" protocolVersion="3" />
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
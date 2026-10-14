---
title: Загрузить NuGet-пакет в реестр {{ cloud-registry-name }}
description: Инструкция описывает, как загрузить локальный NuGet-пакет в реестр {{ cloud-registry-name }}.
---

# Загрузить NuGet-пакет в локальный реестр {{ cloud-registry-name }}

Инструкция описывает, как загрузить [NuGet-пакет](../../concepts/artifacts/nuget.md) в [локальный реестр](../../concepts/registry.md#local-registry).

Для загрузки NuGet-пакета в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

1. Если у вас еще нет собранного пакета, [создайте](create.md) его.

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Загрузите пакет:

    {% list tabs group=nuget_tools %}

    - dotnet CLI {#dotnet}

      ```bash
      dotnet nuget push bin/Release/MyPackage.0.0.1.nupkg \
        --source "https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json" \
        --api-key "$REGISTRY_PASSWORD" \
        --skip-duplicate
      ```

      Где `<идентификатор_реестра>` — идентификатор вашего локального реестра.

      Или [настройте](installation.md) источник пакетов `cloud-registry` и укажите его по имени:

      ```bash
      dotnet nuget push bin/Release/MyPackage.0.0.1.nupkg --source cloud-registry --skip-duplicate
      ```

      {% note info %}

      Если учетные данные заданы в конфигурации источника, dotnet CLI может вывести предупреждение `Ключ API не указан` (`No API key was provided`). Загрузка пакета при этом выполняется успешно, предупреждение можно игнорировать.

      {% endnote %}

      Результат:

      ```text
      Pushing MyPackage.0.0.1.nupkg to 'https://{{ cloud-registry }}/nuget/v3/e5o6a2blpkb6********/index.json'...
      Your package was pushed.
      ```

    - NuGet CLI {#nuget-cli}

      ```bash
      nuget push MyPackage.0.0.1.nupkg \
        -Source "https://{{ cloud-registry }}/nuget/v3/<идентификатор_реестра>/index.json" \
        -ApiKey "$REGISTRY_PASSWORD" \
        -SkipDuplicate
      ```

      Где `<идентификатор_реестра>` — идентификатор вашего локального реестра.

      Или [настройте](installation.md) источник пакетов `cloud-registry` и укажите его по имени:

      ```bash
      nuget push MyPackage.0.0.1.nupkg -Source cloud-registry -SkipDuplicate
      ```

      {% note info %}

      Если учетные данные заданы в конфигурации источника, NuGet CLI может вывести предупреждение `No API Key was provided`. Загрузка пакета при этом выполняется успешно, предупреждение можно игнорировать.

      {% endnote %}

      Результат:

      ```text
      Pushing MyPackage.0.0.1.nupkg to 'https://{{ cloud-registry }}/nuget/v3/e5o6a2blpkb6********/index.json'...
      Your package was pushed.
      ```

    {% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](create.md)
* [{#T}](pull.md)
* [{#T}](installation.md)

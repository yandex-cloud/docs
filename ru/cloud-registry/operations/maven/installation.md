---
title: Настроить Maven
description: Следуя данной инструкции, вы настроите Maven.
---

# Настроить Maven

1. Откройте файл с глобальными настройками Maven.

    По умолчанию файл с настройками расположен в директории `.m2` текущего пользователя (`~/.m2/settings.xml` для Unix-подобных ОС и `%USERPROFILE%\.m2\settings.xml` для Windows). Подробнее о структуре файла настроек см. в [документации Maven](https://maven.apache.org/settings.html).
1. В раздел `repositories` файла с настройками добавьте новый репозиторий:

    ```xml
    <repository>
        <id>local</id>
        <url>{{ cloud-registry }}/maven/<идентификатор_реестра></url>
    </repository>
    ```
1. В зависимости от способа аутентификации:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которых вы будете выполнять аутентификацию.
      1. В раздел `servers` настроек Maven добавьте новый сервер:

          ```xml
          <server>
              <id>local</id>
              <username>${env.REGISTRY_USERNAME}</username>
              <password>${env.REGISTRY_PASSWORD}</password>
          </server>
          ```
      1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`, содержащие данные для аутентификации по IAM-токену:

          ```bash
          export REGISTRY_USERNAME="iam"
          export REGISTRY_PASSWORD="<IAM-токен>"
          ```

          Где `<IAM-токен>` — полученный ранее IAM-токен.

    - OAuth-токен {#oauth-token}

      1. [Получите]({{ link-cloud-oauth }}) OAuth-токен для аккаунта на Яндексе, от имени которого вы будете выполнять аутентификацию.
      1. В раздел `servers` настроек Maven добавьте новый сервер:

          ```xml
          <server>
              <id>local</id>
              <username>${env.REGISTRY_USERNAME}</username>
              <password>${env.REGISTRY_PASSWORD}</password>
          </server>
          ```
      1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`, содержащие данные для аутентификации по OAuth-токену:

          ```bash
          export REGISTRY_USERNAME="oauth"
          export REGISTRY_PASSWORD="<OAuth-токен>"
          ```

          Где `<OAuth-токен>` — полученный ранее [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

    {% endlist %}

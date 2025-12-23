---
title: Настроить Maven
description: Следуя данной инструкции, вы настроите Maven.
---

# Настроить Maven

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Откройте файл с глобальными настройками Maven.

    По умолчанию файл с настройками расположен в директории `.m2` текущего пользователя (`~/.m2/settings.xml` для Unix-подобных ОС и `%USERPROFILE%\.m2\settings.xml` для Windows). Подробнее о структуре файла настроек см. в [документации Maven](https://maven.apache.org/settings.html).

1. В раздел `repositories` файла с настройками Maven добавьте новый репозиторий:

    ```xml
    <repository>
        <id>local</id>
        <url>{{ cloud-registry }}/maven/<идентификатор_реестра></url>
    </repository>
    ```

1. В раздел `servers` файла с настройками Maven добавьте новый сервер:

    ```xml
    <server>
        <id>local</id>
        <username>${env.REGISTRY_USERNAME}</username>
        <password>${env.REGISTRY_PASSWORD}</password>
    </server>
    ```

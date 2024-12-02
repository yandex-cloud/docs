# Настроить Maven

1. Откройте файл с глобальными настройками Maven `settings.xml`.

1. Добавьте новый сервер в раздел `servers`:

    ```
    <server>

        <id>local</id>

        <username>${env.REGISTRY_USERNAME}</username>

        <password>${env.REGISTRY_PASSWORD}</password>

    </server>
    ```

1. Добавьте новый репозиторий в раздел `repositories`:

    ```
    <repository>

        <id>local</id>

        <url>registry.cloud.yandex.net/maven/<идентификатор_реестра></url>

    </repository>
    ```

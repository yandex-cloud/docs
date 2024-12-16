# Setting up Maven

1. Open the `settings.xml` file with the global Maven settings.

1. Add a new server to the `servers` section:

    ```
    <server>

        <id>local</id>

        <username>${env.REGISTRY_USERNAME}</username>

        <password>${env.REGISTRY_PASSWORD}</password>

    </server>
    ```

1. Add a new repository to the `repositories` section:

    ```
    <repository>

        <id>local</id>

        <url>registry.cloud.yandex.net/maven/<registry_ID></url>

    </repository>
    ```

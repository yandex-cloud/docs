# Setting up Maven

1. Open the file with the global Maven settings.

    By default, the configuration file is located in the current user's `.m2` directory (`~/.m2/settings.xml` for Unix-like OSes and `%USERPROFILE%\.m2\settings.xml` for Windows). You can learn more about the configuration file structure in the [Maven documentation](https://maven.apache.org/settings.html).
1. Add a new repository to the configuration file's `repositories` section:

    ```xml
    <repository>
        <id>local</id>
        <url>{{ cloud-registry }}/maven/<registry_ID></url>
    </repository>
    ```
1. Depending on the authentication method:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
      1. Add a new server to the `servers` section of the Maven settings:

          ```xml
          <server>
              <id>local</id>
              <username>${env.REGISTRY_USERNAME}</username>
              <password>${env.REGISTRY_PASSWORD}</password>
          </server>
          ```
      1. Create environment variables named `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` containing data for IAM token authentication:

          ```bash
          export REGISTRY_USERNAME="iam"
          export REGISTRY_PASSWORD="<IAM_token>"
          ```

          Where `<IAM_token>` is the IAM token you got earlier.

    - OAuth token {#oauth-token}

      1. [Get]({{ link-cloud-oauth }}) an OAuth token for the Yandex account you are going to use for authentication.
      1. Add a new server to the `servers` section of the Maven settings:

          ```xml
          <server>
              <id>local</id>
              <username>${env.REGISTRY_USERNAME}</username>
              <password>${env.REGISTRY_PASSWORD}</password>
          </server>
          ```
      1. Create environment variables named `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` containing data for OAuth token authentication:

          ```bash
          export REGISTRY_USERNAME="oauth"
          export REGISTRY_PASSWORD="<OAuth_token>"
          ```

          Where `<OAuth_token>` is the [OAuth token](../../../iam/concepts/authorization/oauth-token.md) you got earlier.

    {% endlist %}
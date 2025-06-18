---
title: Setting up NuGet
description: Follow this guide to set up NuGet.
---

# Setting up NuGet

1. Set up the [NuGet](../../concepts/art-nuget.md) configuration file:

    {% list tabs %}

    - dotnet CLI

      To edit the NuGet configuration file using the [dotnet CLI](https://learn.microsoft.com/en-us/nuget/reference/dotnet-commands), run this command:

      ```bash
      dotnet nuget add source "https://{{ cloud-registry }}/nuget/v3/<registry_ID>/index.json" \
        -n "cloud-registry" \
        -u %REGISTRY_USERNAME% \
        -p %REGISTRY_PASSWORD% \
        --store-password-in-clear-text --protocol-version 3
      ```

    - NuGet CLI

      To edit the NuGet configuration file using the [NuGet CLI](https://learn.microsoft.com/en-us/nuget/reference/nuget-exe-cli-reference), run the `nuget.exe` file with the following parameters:

      ```
      nuget sources add -Name "cloud-registry" \
        -Source "https://{{ cloud-registry }}/nuget/v3/<registry_ID>/index.json" \
        -Username "%REGISTRY_USERNAME%" \
        -Password "%REGISTRY_PASSWORD%" \
        -StorePasswordInClearText -ProtocolVersion 3
      ```

    - Manually

      1. Open the NuGet [configuration file](https://learn.microsoft.com/en-us/nuget/consume-packages/configuring-nuget-behavior#config-file-locations-and-uses):

          {% note info %}

          When using the dotnet CLI, the configuration file is located at `~/.nuget/NuGet/NuGet.Config`, while for the NuGet CLI, at `~/.config/NuGet/NuGet.config`.

          {% endnote %}
      1. Update the configuration in the file as follows:

          ```xml
          <?xml version="1.0" encoding="utf-8"?>
          <configuration>
            <packageSources>
              <add key="cloud-registry" value="https://{{ cloud-registry }}/nuget/v3/<registry_ID>/index.json" protocolVersion="3" />
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

1. Depending on the authentication method:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
      1. Create environment variables named `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` containing data for IAM token authentication:

          ```bash
          export REGISTRY_USERNAME="iam"
          export REGISTRY_PASSWORD="<IAM_token>"
          ```

          Where `<IAM_token>` is the IAM token you got earlier.

    - OAuth token {#oauth-token}

      1. [Get]({{ link-cloud-oauth }}) an OAuth token for the Yandex account you are going to use for authentication.
      1. Create environment variables named `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` containing data for OAuth token authentication:

          ```bash
          export REGISTRY_USERNAME="oauth"
          export REGISTRY_PASSWORD="<OAuth_token>"
          ```

          Where `<OAuth_token>` is the [OAuth token](../../../iam/concepts/authorization/oauth-token.md) you got earlier.

    {% endlist %}
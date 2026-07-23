---
title: Authentication in {{ cloud-registry-full-name }}
description: Follow this guide to authenticate for the required interface.
---

# Authentication in {{ cloud-registry-name }}

Before you start using {{ cloud-registry-name }}, you need to [configure Docker](installation.md) and get authenticated for the appropriate interface:
* For the management console, the minimum required [role](../../../iam/concepts/access-control/roles.md) for a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) is `viewer`.
* For the Docker CLI or {{ managed-k8s-full-name }}, the minimum required role for a [registry](../../concepts/registry.md) is `cloud-registry.artifacts.puller`.

Assign the required role to the {{ yandex-cloud }} user. Read about [authentication methods](#method) and select the one that works best for you.

For more information about roles, see [{#T}](../../security/index.md).

## Authentication methods {#method}

You can get authenticated:

* [As a user](#user):
  * With an IAM token. IAM token lifetime cannot exceed {{ iam-token-lifetime }}.
  * With an API key and a service account. API key [lifetime](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) is limited manually when creating the key.

* [With a Docker credential helper](#cred-helper).

## Authenticating as a user {#user}

{% list tabs group=registry_auth %}

- Using an IAM token {#iam-token}

  {% note info %}

  {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

  {% endnote %}

  1. If you do not have Docker yet, [install it](installation.md).
  1. [Get an IAM token](../../../iam/operations/iam-token/create.md).
  1. Run this command:

      ```bash
      echo <IAM_token> | docker login \
        --username iam \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Where:
      * `<IAM_token>`: Body of the previously obtained IAM token.
      * `--username`: Token type. `iam` means that an IAM token is used for authentication.
      * `{{ cloud-registry }}`: Endpoint that Docker will access when working with the Docker image registry. If it not specified, the request will be sent to the default service, [Docker Hub](https://hub.docker.com).

- With an API key {#api-key}

  1. If you do not have Docker yet, [install it](installation.md).
  1. [Create](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the [service account](../../../iam/concepts/users/service-accounts.md) you are going to use for authentication.
  1. Run this command:

      ```bash
      echo <API_key> | docker login \
        --username api_key \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Where:
      * `<API_key>`: Body of the previously created API key.
      * `--username`: Token type. `api_key` means that an API key is used for authentication.
      * `{{ cloud-registry }}`: Endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to the default service, [Docker Hub](https://hub.docker.com).

{% endlist %}

If the command returns the `docker login is not supported with yc credential helper` error message, [disable your Docker credential helper](#ch-not-use).

## Authenticating with a Docker credential helper {#cred-helper}

Docker Engine can keep user credentials in an external credential store. This is a more secure option than using a Docker configuration file. To use a credential store, you need an external program, [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

The [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) provides `docker-credential-yc` as a Docker credential helper for {{ yandex-cloud }}. It stores user credentials and enables you to use private {{ yandex-cloud }} registries without running the `docker login` command.

### Configuring a credential helper {#ch-setting}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Configure Docker to use `docker-credential-yc`:

   ```bash
   yc cloud-registry configure-docker
   ```

   Result:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   The current user’s profile stores the settings.

   {% include [credential-helper](../../../_includes/credential-helper.md) %}

1. Make sure Docker is configured.

   The `${HOME}/.docker/config.json` configuration file should now contain this line:

   ```json
   "{{ cloud-registry }}": "yc"
   ```

1. You can now use Docker, e.g., to [push Docker images](push.md).

### Additional credential helper features {#ch-feature}

#### Using the credential helper for a different {{ yandex-cloud }} CLI profile {#ch-profile}

You can use the credential helper for another profile, without switching from the current one, by running the following command:

```bash
yc cloud-registry configure-docker --profile <profile_name>
```

For more information about profile management, see [these {{ yandex-cloud }} CLI step-by-step guides](../../../cli/operations/index.md#profile).

#### Disabling a credential helper {#ch-not-use}

To stop using a credential helper for authentication, delete the `{{ cloud-registry }}` domain line from the `credHelpers` section in the `${HOME}/.docker/config.json` configuration file.

---
title: "Authentication in {{ container-registry-full-name }}"
description: "Before you start using {{ container-registry-name }}, you need to get authenticated for the appropriate interface."
---

# Authentication in {{ container-registry-name }}

Before you start using {{ container-registry-name }}, you need to [configure Docker](./configure-docker.md) and get authenticated to use the appropriate interface:
* In the **management console**, the minimum required [role](../../iam/concepts/access-control/roles.md) for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) is `viewer`.
* In the **Docker CLI** or **{{ managed-k8s-full-name }}**, the minimum required role for a [registry](../concepts/registry.md) or [repository](../concepts/repository.md) is `container-registry.images.puller`.

Assign the required role to the {{ yandex-cloud }} user. Read about [authentication methods](#method) and choose the appropriate one.

For more information about roles, see [{#T}](../security/index.md).


## Authentication methods {#method}

You can authenticate:

* [As a user](#user):
  * Using an OAuth token (with a 12-month lifetime).
  * Using an IAM token (with a {{ iam-token-lifetime }} lifetime or less).

* [Using a Docker credential helper](#cred-helper).

## Authenticating as a user {#user}

{% list tabs group=registry_auth %}

- Using an OAuth token {#oauth-token}

  {% note info %}

  {% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

  {% endnote %}

  1. If you do not have Docker yet, [install it](./configure-docker.md).
  1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
  1. Run this command:

     ```bash
     echo <OAuth_token> | docker login \
       --username oauth \
       --password-stdin \
      {{ registry }}
     ```

      Where:
      * `<OAuth_token>`: Body of the previously obtained OAuth token.
      * `--username`: Token type. `oauth` means that an OAuth token is used for authentication.
      * `{{ registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

- Using an IAM token {#iam-token}

  {% note info %}

  {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

  {% endnote %}

  1. If you do not have Docker yet, [install it](./configure-docker.md).
  1. Get an [IAM token](../../iam/operations/iam-token/create.md).
  1. Run this command:

      ```bash
      echo <IAM_token> | docker login \
        --username iam \
        --password-stdin \
        {{ registry }}
      ```

      Where:
      * `<IAM_token>`: Body of the previously obtained IAM token.
      * `--username`: Token type. `iam` means that an IAM token is used for authentication.
      * `{{ registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

{% endlist %}

When running the command, you may get this error message: `docker login is not supported with yc credential helper`.

In such a case, [disable Docker credential helper](#ch-not-use). For more information, see [Troubleshooting in {{ container-registry-name }}](../error/index.md).

## Authenticate using a Docker credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credential store, you need external [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers) software.

[{{ yandex-cloud }} CLI](../../cli/quickstart.md) uses `docker-credential-yc` as a Docker credential helper for {{ yandex-cloud }}. It stores user credentials and allows you to use private {{ yandex-cloud }} registries without running the `docker login` command.

### Configuring a credential helper {#ch-setting}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Configure Docker to use `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Result:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Settings are saved in the current user's profile.

   {% note warning %}

   The credential helper only works if you use Docker without `sudo`. To learn how to configure Docker to run under the current user without `sudo`, see the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Make sure that Docker is configured.

   The following line must appear in the `${HOME}/.docker/config.json` configuration file:

   ```json
   "{{ registry }}": "yc"
   ```

1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md).

### Additional credential helper features {#ch-feature}

#### Using a credential helper for a different {{ yandex-cloud }} CLI profile {#ch-profile}

You can use the credential helper for another profile, without switching from the current one, by running the following command:

```bash
yc container registry configure-docker --profile <profile_name>
```

For more information about {{ yandex-cloud }} CLI profile management, see the [step-by-step instructions](../../cli/operations/index.md#profile).

#### Disabling a credential helper {#ch-not-use}

To avoid using a credential helper for authentication, edit the `${HOME}/.docker/config.json` configuration file to delete the `{{ registry }}` domain line from the `credHelpers` section.
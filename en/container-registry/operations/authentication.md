---
title: "Authentication in {{ container-registry-full-name }}"
description: "Before you start using {{ container-registry-name }}, you need to authenticate for the corresponding interface."
---

# Authentication in {{ container-registry-name }}

Before you start using {{ container-registry-name }}, you need to authenticate for the corresponding interface:
* In the **Management console**, the minimum required [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) [role](../../iam/concepts/access-control/roles.md) is `viewer`.
* In the **Docker CLI** or **{{ managed-k8s-full-name }}**, the minimum required role for the [registry](../concepts/registry.md) or [repository](../concepts/repository.md) is `container-registry.images.puller`.

Assign the proper role to a {{ yandex-cloud }} user or [service account](../../iam/concepts/users/service-accounts.md). Read about [authentication methods](#method) and choose the appropriate one.

For more information about roles, see [{#T}](../security/index.md).

## Authentication methods {#method}

You can authenticate:


* As a user:
   * [Using an OAuth token](#user-oauth) (lifetime is **one year**).
   * [Using an {{ iam-full-name }} token](#user-iam) (maximum lifetime is **{{ iam-token-lifetime }}**).



* [Using a Docker credential helper credential store](#cred-helper).

The authentication command looks like this:

```bash
docker login \
  --username <token_type> \
  --password <token> \
  {{ registry }}
```

Where:
* `--username`: Token type. Acceptable values: `oauth`, `iam`, or `json_key`.
* `--password`: Token body.
* `{{ registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

## Authenticate as a user {#user}


### Authentication using an OAuth token {#user-oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
1. Run this command:

   ```bash
   docker login \
     --username oauth \
     --password <OAuth token> \
     {{ registry }}
   ```


### Authentication using an {{ iam-name }} token {#user-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an {{ iam-name }} token](../../iam/operations/iam-token/create.md).
1. Run this command:

   ```bash
   docker login \
     --username iam \
     --password <IAM token> \
     {{ registry }}
   ```

## Authenticate using a Docker credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credential store, you need external [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers) software.

The {{ yandex-cloud }} CLI uses `docker-credential-yc` as a Docker credential helper for {{ yandex-cloud }}. It stores user credentials and allows you to use private {{ yandex-cloud }} registries without running the `docker login` command. This authentication method supports operations on behalf of a user and service account.

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

   Credential helper only works when using Docker without `sudo`. You can learn how to configure Docker to run under current user without `sudo` in the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Make sure that Docker is configured.

   The `${HOME}/.docker/config.json` configuration file must include the following line:

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

To avoid using a credential helper for authentication, edit the `${HOME}/.docker/config.json` configuration file to remove the `{{ registry }}` domain line under `credHelpers`.
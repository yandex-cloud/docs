---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Authentication in {{ container-registry-short-name }}

Before you start using {{ container-registry-short-name }}, you need to authenticate for the corresponding interface:

* In the **Management console**, the minimum required folder role is `viewer`.
* In the **Docker CLI**, the minimum required role for the [registry](../concepts/registry.md) or [repository](../concepts/repository.md) is `container-registry.images.puller`.

For more information about roles, see [{#T}](../security/index.md).

You can authenticate as a user or service account. Read about [authentication methods](#method) and choose the appropriate one.

## Authentication methods {#method}

You can authenticate:

- As a user:
    - [Using an OAuth token](#oauth) (lifetime is **one year**).
    - [Using an IAM token](#iam) (lifetime is no longer than **{{ iam-token-lifetime }}**).
- As a service account:
    - [Using authorized keys](#sa-json) (no expiration).
    - [Using an IAM token](#sa-iam) (lifetime is no longer than **{{ iam-token-lifetime }}**).
- [Using a credentials store via a Docker Credential helper](#cred-helper).

The authentication command looks like this:

```
docker login \
       --username <token type> \
       --password <token> \
       cr.yandex
```

- Pass the token type in `<token type>` to the `username` parameter. Acceptable values: `oauth`, `iam`, or `json_key`.
- Pass the token itself to the `password` parameter.
- After specifying all the parameters, set `cr.yandex` as the address for authentication. Otherwise, the request will be sent to the default service, [Docker Hub](https://hub.docker.com).

## Authenticate as a user {#user}

### Authentication using an OAuth token {#oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. If you don't have an OAuth token, get one via [link]({{ link-cloud-oauth }}).

1. Run the command:

    ```
    docker login \
           --username oauth \
           --password <OAuth token> \
             cr.yandex
    ```

### Authentication using an IAM token {#iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an IAM token](../../iam/operations/iam-token/create.md).

1. Run the command:

    ```
    docker login \
           --username iam \
           --password <IAM token> \
             cr.yandex
    ```

## Authenticate as a service account {#sa}

### Authentication using authorized keys {#sa-json}

{% note info %}

Authorized keys do not expire, but you can always get new authorized keys and authenticate again if something goes wrong.

{% endnote %}

Using a [service account](../../iam/concepts/users/service-accounts.md), your programs can access {{ yandex-cloud }} resources. Get a file with authorized keys for your service account via the CLI.

1. Get [authorized keys](../../iam/concepts/users/service-accounts.md#sa-key) for your service account:

    ```
    yc iam key create --service-account-name default-sa -o key.json
    id: aje8a87g4e...
    service_account_id: aje3932acd...
    created_at: "2019-05-31T16:56:47Z"
    key_algorithm: RSA_2048
    ```

1. Run the command:

    ```
    cat key.json | docker login \
    --username json_key \
    --password-stdin \
    cr.yandex
    
    Login Succeeded
    ```

    - The `cat key.json` command writes the contents of the key file to the output stream.
    - The `--password-stdin` flag allows the password to be read from the input stream.

### Authentication using an IAM token {#sa-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).

1. Run the command:

    ```
    docker login \
           --username iam \
           --password <IAM token> \
           cr.yandex
    ```

## Authenticate using a Docker Credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credentials store, you need an external [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

{{ yandex-cloud }} uses `docker-credential-yc` as a Docker Credential helper. It stores user credentials and lets you use private {{ yandex-cloud }} registries without running the `docker login` command. This authentication method supports operations on behalf of a user and service account. To work with `docker-credential-yc`, you need the {{ yandex-cloud }} command-line interface: [YC CLI](../../cli/quickstart.md).

You don't need to install the `docker-credential-yc` separately: just install the YC CLI and configure the Credential helper following the description below.

### Configuring a Credential helper {#ch-setting}

1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).

1. Configure Docker to use `docker-credential-yc`:

    ```bash
    yc container registry configure-docker
    Credential helper is configured in '/home/<user>/.docker/config.json'
    ```

    Settings are saved in the current user's profile.

    {% note warning %}

    The Credential helper only works when using Docker without `sudo`. For information about how to configure Docker to run as the current user without using the `sudo` command, see the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

    {% endnote %}

1. Make sure that Docker is configured.

    The `/home/<user>/.docker/config.json` file must contain the following line:

    ```json
    "cr.yandex": "yc"
    ```

1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

### Additional Credential helper features {#ch-feature}

#### Using a Credential helper for a different YC CLI profile {#ch-profile}

You can use the Credential helper for another profile, without switching from the current one, by running the following command:

```
yc container registry configure-docker --profile <profile name>
```

For more information about YC CLI profile management, see the [step-by-step instructions](../../cli/operations/index.md#profile).

#### Disabling a Credential helper {#ch-not-use}

To avoid using Credential helpers for authentication, remove the `cr.yandex` domain string from the `credHelpers` block in the `/home/<user>/.docker/config.json` file.

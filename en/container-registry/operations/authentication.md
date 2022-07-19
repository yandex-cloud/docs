# Authentication in {{ container-registry-name }}

Before you start using {{ container-registry-name }}, you need to authenticate for the corresponding interface:
* In the **Management console**, the minimum required folder role is `viewer`.
* In the **Docker CLI**, the minimum required role for the [registry](../concepts/registry.md) or [repository](../concepts/repository.md) is `container-registry.images.puller`.

For more information about roles, see [{#T}](../security/index.md).

You can authenticate as a user or service account. Read about [authentication methods](#method) and choose the appropriate one.

## Authentication methods {#method}

You can authenticate:

{% if product == "yandex-cloud" %}

* As a user:
   * [Using an OAuth token](#oauth) (lifetime is **one year**).
   * [Using an IAM token](#iam) (maximum lifetime is **{{ iam-token-lifetime }}**).

{% endif %}

{% if product == "cloud-il" %}

* As a user, [using an IAM token](#iam) (maximum lifetime is **{{ iam-token-lifetime }}**).

{% endif %}

* As a service account:
   * [Using authorized keys](#sa-json) (unlimited lifetime).
   * [Using an IAM token](#sa-iam) (maximum lifetime is **{{ iam-token-lifetime }}**).
* [Using a Docker Credential helper credential store](#cred-helper).

The authentication command looks like this:

```
docker login \
  --username <token type> \
  --password <token> \
  {{ registry }}
```

Where:

* Legal values for `<token type>`: {% if product == "yandex-cloud" %}`oauth`, {% endif %}`iam`, or `json_key`.
* `<token>`: Token.
* `{{ registry }}`: Authentication address. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

## Authenticate as a user {#user}

{% if product == "yandex-cloud" %}

### Authentication using an OAuth token {#oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. If you don't have an OAuth token, get one by following this [link]({{ link-cloud-oauth }}).
1. Run the command:

   ```
   docker login \
     --username oauth \
     --password <OAuth token> \
     {{ registry }}
   ```

{% endif %}

### Authentication using an IAM token {#iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Get an IAM token]{% if product == "yandex-cloud" %}(../../iam/operations/iam-token/create.md){% endif %}{% if product == "cloud-il" %}(../../iam/operations/iam-token/create-for-federation.md){% endif %}.
1. Run the command:

   ```
   docker login \
     --username iam \
     --password <IAM token> \
     {{ registry }}
   ```

## Authenticate as a service account {#sa}

### Authentication using authorized keys {#sa-json}

{% note info %}

Authorized keys do not expire, but you can always get new authorized keys and authenticate again if something goes wrong.

{% endnote %}

Using a [service account](../../iam/concepts/users/service-accounts.md), your programs can access {{ yandex-cloud }} resources. Get a file with authorized keys for your service account via the CLI.
1. Get [authorized keys](../../iam/concepts/users/service-accounts.md#sa-key) for your service account:

   ```bash
   yc iam key create --service-account-name default-sa -o key.json
   ```

   Result:

   ```bash
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
     {{ registry }}
   ```

   Where:

   * The `cat key.json` command writes the contents of the key file to the output stream.
   * The `--password-stdin` flag allows the password to be read from the input stream.

   Result:

   ```
   Login succeeded
   ```

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
     {{ registry }}
   ```

## Authenticate using a Docker Credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credential store, you need external [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers) software.

{{ yandex-cloud }} uses `docker-credential-yc` as a Docker Credential helper. It stores user credentials and lets you use private {{ yandex-cloud }} registries without running the `docker login` command. This authentication method supports operations on behalf of a user and service account. To work with `docker-credential-yc`, you need the {{ yandex-cloud }} command-line interface: [YC CLI](../../cli/quickstart.md).

You don't need to install the `docker-credential-yc` separately: just install the YC CLI and configure the Credential helper following the description below.

### Configuring a Credential helper {#ch-setting}

1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).
1. Configure Docker to use `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Result:

   ```bash
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Settings are saved in the current user's profile.

   {% note warning %}

   The Credential helper only works when using Docker without `sudo`. Configuring Docker to run as the current user without using `sudo` is described in the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Make sure that Docker is configured.

   The `/home/<user>/.docker/config.json` configuration file must include the following line:

   ```json
   "{{ registry }}": "yc"
   ```

1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

### Additional Credential helper features {#ch-feature}

#### Using a Credential helper for a different YC CLI profile {#ch-profile}

You can use the Credential helper for another profile, without switching from the current one, by running the following command:

```bash
yc container registry configure-docker --profile <profile name>
```

For more information about YC CLI profile management, see the [step-by-step instructions](../../cli/operations/index.md#profile).

#### Disabling a Credential helper {#ch-not-use}

To avoid using Credential helper for authentication, edit the `/home/<user>/.docker/config.json` configuration file to remove the `{{ registry }}` domain line under `credHelpers`.
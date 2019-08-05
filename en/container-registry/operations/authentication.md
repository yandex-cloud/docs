# Authentication in {{ container-registry-short-name }}

Before you start using {{ container-registry-short-name }} through the Docker CLI, you need to authenticate.

{% note info %}

The required folder role is `viewer`. For more information about roles, see [{#T}](../security/index.md).

{% endnote %}

You can authenticate as a user or service account. Read about [authentication methods](#method) and choose the appropriate one.

## Authentication methods {#method}

You can authenticate:

- As a user:
    - [Using an OAuth token](#oauth) (the validity period is **one year**).
    - [Using an IAM token](#iam) (the validity period is **12 hours**).
- As a service account:
    - [Using authorized keys](#sa-json) (does not expire).
    - [Using an IAM token](#sa-iam) (the validity period is **12 hours**).
- [Using a credentials store via a Docker Credential helper ](#cred-helper).

The authentication coomand looks like this:

```
$ docker login \
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

The validity period of an OAuth token is one year. Then you need to [get a new OAuth token](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) and authenticate again.

{% endnote %}

1. If you don't have an OAuth token, get one at this [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

1. Run the command:

    ```
    $ docker login \
             --username oauth \
             --password <OAuth token> \
             cr.yandex
    ```

### Authentication using an IAM token {#iam}

{% note info %}

The validity period of an IAM token is 12 hours. Then you need to get a new IAM token and authenticate again.

{% endnote %}

1. If you don't have an IAM token yet, run the following command to get one:

    ```
    $ yc iam create-token
    ```

1. Run the command:

    ```
    $ docker login \
             --username iam \
             --password <IAM token> \
             cr.yandex
    ```

## Authenticate as a service account {#sa}

### Authentication using authorized keys {#sa-json}

{% note info %}

Authorized keys do not expire, but you can always get new authorized keys and authenticate again if something goes wrong.

{% endnote %}

Using a [service account](../../iam/concepts/users/service-accounts.md), your programs can access Yandex.Cloud resources. Get a file with authorized keys for your service account via the CLI.

1. Get [authorized keys](../../iam/concepts/users/service-accounts.md#sa-key) for your service account:

    ```
    $ yc iam key create --service-account-name default-sa -o key.json
    id: aje8a87g4e...
    service_account_id: aje3932acd...
    created_at: "2019-05-31T16:56:47Z"
    key_algorithm: RSA_2048
    ```

1. Run the command:

    ```
    $ cat key.json | docker login \
    --username json_key \
    --password-stdin \
    cr.yandex

    Login Succeeded
    ```
    - The `cat key.json` command writes the contents of the key file to the input stream.
    - The `--password-stdin` flag allows the password to be read from the input stream.

### Authentication using an IAM token {#sa-iam}

{% note info %}

The validity period of an IAM token is 12 hours. Then you need to get a new IAM token and authenticate again.

{% endnote %}

1. Get [authorized keys](../../iam/concepts/users/service-accounts.md#sa-key) for your service account:

    ```
    $ yc iam key create --service-account-name default-sa -o key.json
    id: aje8a87g4e...
    service_account_id: aje3932acd...
    created_at: "2019-05-31T16:56:47Z"
    key_algorithm: RSA_2048
    ```

1. Add the authorized key file to your CLI profile:

   ```
   $ yc config set service-account-key key.json
   ```

   When the `service-account-key` parameter is set, the `token` parameter is reset to zero. For more information about parameters, see [CLI configuration](../../cli/concepts/core-propreties.md).

1. Get an IAM token:

    ```
    $ yc iam create-token
    ```

1. Run the command:

    ```
    $ docker login \
             --username iam \
             --password <IAM token> \
             cr.yandex
    ```

## Authenticate using a Docker Credential helper {#cred-helper}

The Docker Engine can keep user credentials in an external credentials store. This is more secure than storing credentials in the Docker configuration file. To use a credentials store, you need an external [Docker Credential helper program](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

Yandex.Cloud uses `docker-credential-yc` as a Docker Credential helper. It stores user credentials and allows using Docker without running the `docker login` command. This authentication method supports operations on behalf of a user and service account. To work with `docker-credential-yc`, you need the Yandex.Cloud command-line interface: [YC CLI](../../cli/quickstart.md).

### Configuring a Credential helper {#ch-setting}

1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).

1. Configure Docker to use `docker-credential-yc`:

    ```
    $ yc container registry configure-docker
    Credential helper is configured in '/home/<user>/.docker/config.json'
    ```

    During setup, information about the current user profile is saved.

1. Make sure that Docker is configured.

    The `/home/<user>/.docker/config.json` file must contain the following line:

    ```
    "cr.yandex": "yc"
    ```

1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

### Additional Credential helper features {#ch-feature}

#### Using a Credential helper for a different YC CLI profile {#ch-profile}

You can use the Credential helper for another profile, without switching from the current one, by running the following command:

```
$ yc container registry configure-docker --profile <profile name>
```

For more information about YC CLI profiles, see [Profiles](../../cli/concepts/profile.md).

#### Disabling a Credential helper {#ch-not-use}

To avoid using Credential helpers for authentication, remove the `cr.yandex` domain string from the `credHelpers` block in the `/home/<user>/.docker/config.json` file.


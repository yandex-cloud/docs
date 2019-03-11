# Authentication in [!KEYREF container-registry-short-name]

Before you start using [!KEYREF container-registry-short-name] through the Docker CLI, you need to authenticate.

Find out how to:

* [Choose the appropriate authentication method](#method)
* [Authenticate using an OAuth token](#oauth)
* [Authenticate using an IAM token](#iam)

## Authentication methods {#method}

There are several ways to set up authentication. Whichever you choose, keep in mind that different tokens have different validity periods:

* Via an OAuth token (valid for **one year**).
* Via an IAM token (valid for **12 hours**).

If you don't use any keystore, you can store a configuration file on a VM. In this case,
when working with the Docker CLI from that VM, you will not have to authenticate.

> [!IMPORTANT]
> 
> Attention! Be careful when distributing key files: anyone who can access your VM will be able to execute commands in the Docker CLI on your behalf.

Once you have selected the authentication method, proceed directly to the execution of the command.

> [!NOTE]
> 
> The required folder role is `viewer`. For more information about roles, see the section [[!TITLE]](../security/index.md).

---

**[!TAB CLI]**

> [!IMPORTANT]
>  
> After specifying all the parameters, don't forget to set as the address for authentication `container-registry.cloud.yandex.net`, otherwise
> the request will be sent to the default service, [Docker Hub](https://hub.docker.com).

From the command line, run:

```
$ docker login \
--username <token type> \
--password <token> \
container-registry.cloud.yandex.net
```

* Pass the token type in `<token type>` for the `username` parameter. Acceptable values: `oauth` or `iam`.
* Pass the token itself in the `password` parameter.

For a regular user it is easier to use an OAuth token, while service accounts need an IAM token.

---

## Authentication using an OAuth token {#oauth}

If you don't have an OAuth token yet, get one at this [link](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

---

**[!TAB CLI]**

Run the command:

```
$ docker login \
--username oauth \
--password <OAuth token> \
container-registry.cloud.yandex.net
```

---

## Authentication using an IAM token {#iam}

---

**[!TAB CLI]**

1. If you don't have an IAM token yet, run the following command to get one:

    ```
    yc iam create-token
    ```

1. To authenticate, run the command:

    ```
    $ docker login \
    --username iam \
    --password <IAM token> \
    container-registry.cloud.yandex.net
    ```

---


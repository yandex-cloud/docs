# Getting started with {{ mmg-short-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed, where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ MG }} hosts, request access to port 27018.

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-mg }} cluster list
   ```

{% else %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:
   - To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same cloud network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).
   - To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install MongoDB Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```

{% endif %}

## Create a cluster {#cluster-create}

1. In [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select **{{ mmg-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. [Configure security groups](operations/connect.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

1. Get an SSL certificate:

    {% if audience != "internal" %}

    1. Create a folder:

        ```bash
        $ mkdir ~/.mongodb
        ```

    1. Get a certificate:

        ```bash
        $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.mongodb/root.crt
        ```

    {% else %}

    1. Create a folder:

        ```bash
        $ mkdir ~/.mongodb
        ```

    1. Get a certificate:

        ```bash
        $ wget "{{ pem-path }}" -O ~/.mongodb/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.mongodb/root.crt
        ```

    {% endif %}

1. Connect to the cluster using the {{ MG }} CLI:

    {% if audience != "internal" %}

    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <username> \
            -p <user password> \
            <DB name>
    ```

    {% else %}

    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --ipv6 \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <username> \
            -p <user password> \
            <DB name>
    ```

    {% endif %}

## What's next {#whats-next}

- Read about [service concepts](concepts/index.md).
- Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
- Read [questions and answers](qa/general.md).


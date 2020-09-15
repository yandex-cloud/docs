# Getting started with {{ mpg-short-name }}

To get started with the service:

- [Create a DB cluster](#cluster-create).
- [Connect to the DB](#connect).

{% if audience == "internal" %}

For the internal MDB service, the [web interface](https://yc.yandex-team.ru) is deployed where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ PG }} clusters, you need access to port 6432.

{% include [cli-setup](../_includes/mdb/internal/cli-setup.md) %}

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-pg }} cluster list
   ```

{% else %}

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if you don't have an account.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

You can connect to DB clusters from both inside and outside of the Cloud:

1. To connect to a DB cluster from inside Yandex.Cloud, create a VM in the same network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).
1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

{% endif %}

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mpg-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status on the {{ mpg-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. To connect to the DB server, get an SSL certificate:

    {% if audience != "internal" %}

    1. Create a folder:

        ```bash
        $ mkdir ~/.postgresql
        ```

    1. Get a certificate:

        ```bash
        $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.postgresql/root.crt
        ```

    {% else %}

    1. Create a folder:

        ```bash
        $ mkdir ~/.postgresql
        ```

    1. Get a certificate:

        ```bash
        $ wget "{{ pem-path }}" -O ~/.postgresql/root.crt
        ```

    1. Configure permissions to the certificate:

        ```bash
        $ chmod 0600 ~/.postgresql/root.crt
        ```

    {% endif %}

1. Use the `psql` command to connect:

    ```bash
    $ psql "host=<host address> \
          port=6432 \
          sslmode=verify-full \
          dbname=<DB name> \
          user=<DB user name>"
    ```

## What's next

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating a cluster](./operations/cluster-create.md) and [connecting to the database](./operations/connect.md).
- Read [questions and answers](./qa/general.md).


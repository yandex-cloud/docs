# Getting started with {{ mpg-short-name }}

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

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))
   1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

{% endif %}

1. In the management console, select the folder where you want to create a DB cluster.

1. Select **{{ mpg-name }}**.

2. Click **Create cluster** and select the necessary DBMS.

3. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

4. When the cluster is ready, its status on the {{ mpg-short-name }} dashboard will change to **RUNNING**.

5. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    {% if audience != "internal" %}

    ```bash
    $ mkdir ~/.postgresql
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt
    $ chmod 0600 ~/.postgresql/root.crt
    ```

    {% else %}

    ```bash
    $ mkdir ~/.postgresql
    $ wget "{{ pem-path }}" -O ~/.postgresql/root.crt
    $ chmod 0600 ~/.postgresql/root.crt
    ```

    {% endif %}

1. You can connect to the database using the `psql` command (for more information, see [{#T}](operations/connect.md)):

    ```
    $ psql "host=<host address> \
          port=6432 \
          sslmode=verify-full \
          dbname=<DB name> \
          user=<DB user name>"
    ```


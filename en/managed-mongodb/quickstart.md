# Getting started with {{ mmg-short-name }}

{% if audience == "internal" %}

For the internal MDB service, the [web interface](https://yc.yandex-team.ru) is deployed where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ MG }} hosts, request access to port 27018.

{% include [cli-setup](../_includes/mdb/internal/cli-setup.md) %}

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-mg }} cluster list
   ```

{% endif %}

{% if audience != "internal" %}

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster. If you plan to connect to the database from outside Yandex.Cloud, request external IP addresses for hosts when creating a cluster.
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))
   1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

{% endif %}

1. In [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

1. Select **{{ mmg-name }}**.

1. Click **Create cluster** and select the necessary DBMS.

1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

1. When the cluster is ready, its status on the {{ mmg-short-name }} dashboard will change to **RUNNING**.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    {% if audience != "internal" %}

    ```bash
    $ mkdir ~/.mongodb
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
    ```

    {% else %}

    ```bash
    $ mkdir ~/.mongodb
    $ wget "{{ pem-path }}" -O ~/.mongodb/CA.pem
    ```

    {% endif %}

1. You can now connect to the cluster:

    {% if audience != "internal" %}

    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <user name> \
            -p <user password> \
            <DB name>
    ```

    {% else %}

    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --ipv6 \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <user name> \
            -p <user password> \
            <DB name>
    ```

    {% endif %}


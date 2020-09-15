# Getting started with {{ mrd-short-name }}

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{console-link}}) is deployed where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters {#access}

The rules for accessing MDB clusters are already given in [Puncher](https://puncher.yandex-team.ru/): from [Yandex server networks](https://puncher.yandex-team.ru/tasks?id=5cb878a6d5626d264a13ff8a) and [for developers](https://puncher.yandex-team.ru/tasks?id=5d0254aad89cb03fee5006d4).

If you need more rules, request access to the `_PGAASINTERNALNETS_` macro. To connect to {{ RD }} clusters, you need access to ports 26379 (Sentinel) and 6379 (Redis).

{% include [cli-setup](../_includes/mdb/internal/cli-setup.md) %}

   If you did everything correctly, the list clusters query should now work:

   ```bash
   {{ yc-mdb-rd }} cluster list
   ```

{% else %}

To use the service, create a cluster and virtual machine to access the server from:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster.

{% endif %}

Quickly create a cluster and test your connection to it:

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mrd-full-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**.
1. When the cluster is ready, its status on the {{ mrd-short-name }} dashboard will change to **RUNNING**.
1. You can connect to the database using the [redis-cli](https://redis.io/topics/rediscli) program:

    ```
    $ redis-cli -h <FQDN of any host> \
                -p 26379
    $ <host FQDN>:26379> sentinel get-master-addr-by-name <cluster name>
    1) "<master name>"
    2) "6379"
    
    $ redis-cli -h <master FQDN> \
                -p 6379
    $ <master FQDN>:6379> auth <cluster password>
    OK
    $ <master FQDN>:6379> set foo bar
    OK
    ```


# Getting started with Managed Service for Redis

Before creating a database cluster:

1. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster.

Follow the instructions below to quickly create a cluster and test your connection to it.

1. In the management console, select the folder where you want to create a DB cluster.
1. Select the **Yandex Managed Service for Redis** service.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**.
1. When the cluster is ready to operate, its status on the Managed Service for Redis dashboard will change to **RUNNING**.
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


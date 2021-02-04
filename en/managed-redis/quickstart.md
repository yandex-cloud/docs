# Getting started with {{ mrd-short-name }}


To use the service, create a cluster and virtual machine to access the server from:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster.

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


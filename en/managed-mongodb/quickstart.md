# Getting started with [!KEYREF mmg-short-name]

Before creating a database cluster:

1. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster. If you plan to connect to the database from outside the Cloud, request external IP addresses for hosts when creating a cluster.

Follow the instructions below to quickly create a cluster and test your connection to it.

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on **[!KEYREF mmg-name]**.
1. Click **Create cluster** and select the necessary DBMS.
1. Set the cluster parameters and click **Create cluster**. The process is described in detail in the section [[!TITLE]](operations/cluster-create.md).
1. When the cluster is ready to operate, its status on the [!KEYREF mmg-short-name] dashboard will change to **RUNNING**.
1. To connect to the DB server, an SSL certificate is required. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.mongodb
    $ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]" -O ~/.mongodb/CA.pem
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --ipv6 \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <user name> \
            -p <user password> \
            <DB name>
    ```


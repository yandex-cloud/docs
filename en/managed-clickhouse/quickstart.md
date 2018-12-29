# Getting started with [!KEYREF mch-short-name]

1. To create a DB cluster, all you need is a folder available to you in Yandex.Cloud. If you already have one, open the page of that folder in the management console. If there is no folder yet, create one:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows md))
   1. To enable connection to a cluster over the internet, request external IP addresses for hosts when creating the cluster.

1. In the management console, select the folder where you want to create a DB cluster.

1. Click **Create resource** and select **Cluster [!KEYREF CH]**.

1. Set the cluster parameters and click **Create cluster**. The process is described in detail in the section [[!TITLE]](operations/cluster-create.md).

1. When the cluster is ready to operate, its status on the [!KEYREF mch-name] dashboard will change to **RUNNING**.

1. To connect to the database server, an SSL certificate is required. Download it:

    ```bash
    $ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]"
    ```

1. Send a request specifying the path to the received SSL certificate, database attributes, and the request text in urlencoded format:

    ```
    $ curl --cacert <path to the SSL certificate> \
         -H "X-ClickHouse-User: <DB user name>" \
         -H "X-ClickHouse-Key: <DB user password>" \
         'https://<host address>:8443/?database=<DB name>&query=SELECT%20now ()'
    ```


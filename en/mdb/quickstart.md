# Getting started with [!KEYREF mdb-short-name]

Before creating a database cluster:

1. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)) that you will use for accessing the DB cluster. If you plan to connect to the database from outside the Cloud, request external IP addresses for hosts when creating a cluster.

Follow the instructions below to quickly create a cluster and test your connection to it.

---

**[!TAB [!KEYREF PG]]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on the tile **Yandex Managed Databases**.
1. Click **Create a cluster** and select the necessary DBMS.
1. Set the cluster settings and click **Create a cluster**. The process is described in detail in the section [[!TITLE]](operations/postgresql/cluster-create.md).
1. When the cluster is ready to operate, its status on the [!KEYREF mdb-short-name] dashboard will change to **RUNNING**.
1. To connect to the DB server, an SSL certificate is required. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.postgresql
    $ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]" -O ~/.postgresql/root.crt
    $ chmod 0600 ~/.postgresql/root.crt
    ```
1. You can connect to the database using the `psql` command (for more information, see [[!TITLE]](operations/postgresql/connect.md)):

    ```
    $ psql "host=<host address> \
          port=6432 \
          sslmode=verify-full \
          dbname=<DB name> \
          user=<DB user name>"
    ```

**[!TAB [!KEYREF CH]]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on the tile **Yandex Managed Databases**.
1. Click **Create a cluster** and select the necessary DBMS.
1. Set the cluster settings and click **Create a cluster**. The process is described in detail in the section [[!TITLE]](operations/clickhouse/cluster-create.md).
1. When the cluster is ready to operate, its status on the [!KEYREF mdb-short-name] dashboard will change to **RUNNING**.
1. To connect to the database server, an SSL certificate is required. Download it:

    ```bash
    $ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]"
    ```
1. Send a request specifying the path to the received SSL certificate, database attributes, and the request text in urlencoded format:

    ```
    $ curl --cacert <path to the SSL certificate> \
         -H "X-ClickHouse-User: <DB user name>" \
         -H "X-ClickHouse-Key: <DB user's password>" \
         'https://<host address>:8443/?database=<DB name>&query=SELECT%20now()'
    ```

**[!TAB [!KEYREF MG]]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on the tile **Yandex Managed Databases**.
1. Click **Create a cluster** and select the necessary DBMS.
1. Set the cluster settings and click **Create a cluster**. The process is described in detail in the section [[!TITLE]](operations/mongodb/cluster-create.md).
1. When the cluster is ready to operate, its status on the [!KEYREF mdb-short-name] dashboard will change to **RUNNING**.
1. To connect to the DB server, an SSL certificate is required. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.mongodb
    $ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]" -O ~/.mongodb/CA.pem
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --ipv6 \
            --host 'rs01/<address of host 1>: 27018,<address of host 2>:27018,<address of host N>: 27018' \
            -u <user name> \
            -p <user password> \
            <DB name>
    ```

---


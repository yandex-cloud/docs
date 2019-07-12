# How to get started with Managed Service for MySQL<sup>®</sup>

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows md)).
   1. To enable connection to a cluster over the internet, request external IP addresses for hosts when creating the cluster.

Follow the instructions below to quickly create a cluster and test your connection to it.

1. In the management console, select the folder where you want to create a DB cluster.

1. Click **Managed Service for MySQL**.

1. Click **Create cluster** and select the necessary DBMS.

1. Set the cluster parameters and click **Create cluster**. The process is described in detail in the section [#T](operations/cluster-create.md).

1. When the cluster is ready to operate, its status on the Managed Service for MySQL dashboard will change to **RUNNING**.

1. To connect to the DB server, an SSL certificate is required. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.mysql
    $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.mysql/root.crt
    $ chmod 0600 ~/.mysql/root.crt
    ```

1. You can connect to the database using the `mysql` command (for more information, see [#T](operations/connect.md)):

    ```
    $ mysql --host=<host address>
            --port=3306
            --ssl-ca=~/.mysql/root.crt
            --ssl-mode=REQUIRED
            --user=<name of the database user>
            --password <DB name>
    ```


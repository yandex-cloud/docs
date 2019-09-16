# Getting started with {{ mpg-short-name }}

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))
   1. To enable connection to a cluster over the internet, request external IP addresses for hosts when creating the cluster.

1. In the management console, select the folder where you want to create a DB cluster.

1. Select **{{ mpg-name }}**.

2. Click **Create cluster** and select the necessary DBMS.

3. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

4. When the cluster is ready, its status on the {{ mpg-short-name }} dashboard will change to **RUNNING**.

5. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.postgresql
    $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.postgresql/CA.pem
    ```

1. You can connect to the database using the `psql` command (for more information, see [{#T}](operations/connect.md)):

    ```
    $ psql "host=<host address> \
          port=6432 \
          sslmode=verify-full \
          dbname=<DB name> \
          user=<DB username>"
    ```


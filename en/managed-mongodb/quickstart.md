# Getting started with {{ mmg-short-name }}

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).
   1. To enable connection to a cluster over the internet, request external IP addresses for hosts when creating the cluster.

1. In [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

1. Select **{{ mmg-name }}**.

1. Click **Create cluster** and select the necessary DBMS.

1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

1. When the cluster is ready, its status on the {{ mmg-short-name }} dashboard will change to **RUNNING**.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    ```bash
    $ mkdir ~/.mongodb
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
    ```

1. You can now connect to the cluster:

    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --ipv6 \
            --host 'rs01/<address of host 1>:27018,<address of host 2>:27018,<address of host N>:27018' \
            -u <username> \
            -p <user password> \
            <DB name>
    ```


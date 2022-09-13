# Getting started with {{ mmy-short-name }}®

Before creating a database cluster:

1. If you already have a folder in {{ yandex-cloud }}, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Create a VM (based on [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} or [Windows](../compute/quickstart/quick-create-windows.md){% endif %}) that you will use for accessing the DB cluster. If you plan to connect to the database from outside {{ yandex-cloud }}, request external IP addresses for hosts when creating a cluster.

Follow the instructions below to quickly create a cluster and test your connection to it.

1. In the management console, select the folder where you want to create a DB cluster.

1. Select **{{ mmy-name }}**.

1. Click **Create cluster** and select the necessary DBMS.

1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

1. When the cluster is ready, its status on the {{ mmy-short-name }} dashboard will change to **RUNNING**.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    ```bash
    mkdir ~/.mysql
    wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
    chmod 0600 ~/.mysql/root.crt
    ```

1. You can connect to the database using the command `mysql` (for more information, see [{#T}](operations/connect.md)):

    ```
    mysql --host=<host address>
            --port=3306
            --ssl-ca=~/.mysql/root.crt
            --ssl-mode=REQUIRED
            --user=<name of database user>
            --password <DB name>
    ```


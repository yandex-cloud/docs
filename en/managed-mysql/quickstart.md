# Getting started with {{ mmy-short-name }}<sup>®</sup>

To get started with the service:

- [Create a DB cluster](#cluster-create).
- [Connect to the DB](#connect)


## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if you don't have an account.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

You can connect to DB clusters from both inside and outside Yandex.Cloud:

1. To connect to a DB cluster from inside Yandex.Cloud, create a VM in the same network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).
1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mmy-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status on the {{ mmy-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. To connect to the DB server, get an SSL certificate:


      1. Create a folder:

         ```bash
         $ mkdir ~/.mysql
         ```

      1. Get a certificate:

         ```bash
         $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
         ```

      1. Configure permissions to the certificate:

         ```bash
         $ chmod 0600 ~/.mysql/root.crt
         ```

1. Use the `mysql` command to connect:

   ```bash
   $ mysql --host=<host address> \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=REQUIRED \
      --user=<name of database user> \
      --password <DB name>
   ```

## What's next

- Read about [service concepts](./concepts/index.md).
- Learn more about [creating a cluster](./operations/cluster-create.md) and [connecting to the database](./operations/connect.md).
- Read [questions and answers](./qa/general.md).


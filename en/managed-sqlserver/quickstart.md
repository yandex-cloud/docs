# Getting started with {{ mms-short-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

1. To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md)).
1. To connect to a cluster from the internet, request public access to the hosts when creating the cluster.

## Create a cluster {#cluster-create}

1. In [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. Select **{{ mms-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. [Create a Linux VM](../compute/quickstart/quick-create-linux.md) in the same [virtual network](../vpc/concepts/network.md) as the cluster.

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the dependencies and the `mssql-cli` client application:

   ```bash
   $ sudo apt update
   $ sudo apt install python3-pip python-is-python3
   $ pip3 install mssql-cli
   $ source ~/.profile
   ```

1. Connect to a database:

   ```bash
   $ mssql-cli -U <username> \
             -d <database name> \
             -S <FQDN of the host>,1433
   ```

   After running the command, enter the user password to complete the connection procedure.

## What's next

- Read about [service concepts](concepts/index.md).
- Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
- Read [questions and answers](qa/general.md).


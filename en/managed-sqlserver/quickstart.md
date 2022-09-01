# Getting started with {{ mms-short-name }}

{% include [ms-licensing-personal-data](../_includes/ms-licensing-personal-data.md) %}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect).

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:
   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)-based VM in the same network as the DB cluster.
   * To be able to connect to the cluster from the internet, request public access to hosts when creating or modifying the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the virtual machine over SSH.
1. Install the dependencies and the `mssql-cli` client:

   ```bash
   sudo apt update && \
   sudo apt install python3-pip python-is-python3 && \
   pip3 install mssql-cli && \
   source ~/.profile
   ```

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ mms-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. When the cluster is ready, its status changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

1. To connect to the DB server, get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mms/install-certificate.md) %}

1. Use the `mssql-cli` command below to connect:

   {% include [default-connstring](../_includes/mdb/mms/default-connstring.md) %}

1. After running the command, enter the user password to complete the connection procedure.

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect.md).
* Read [questions and answers](qa/general.md).

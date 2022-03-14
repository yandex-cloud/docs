# Getting started with {{ mgp-short-name }}

To get started with the service:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can only connect to the cluster from within {{ yandex-cloud }}. To do this, [create](../compute/operations/vm-create/create-linux-vm.md) an intermediate VM running Linux on the same cloud network as the {{ GP }} cluster.

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install the necessary dependencies and the PostgreSQL client:

    ```bash
    sudo apt update && sudo apt install postgresql-client --yes
    ```

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ mgp-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mgp-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the cluster {#connect}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the intermediate VM via SSH.

1. Connect to the {{ GP }} cluster master host using `psql`:

    ```bash
    psql --host <master host FQDN> \
         --username <username> \
         --dbname postgres
    ```

    To get the master host FQDN:
    1. Go to the folder page and select **{{ mgp-name }}**.
    1. Click on the name of the cluster you need and select the **Hosts** tab.

1. After connecting, run the following query:

    ```sql
    SELECT version();
    ```

    The cluster will return the {{ PG }} and {{ GP }} versions used.

## What's next {#whats-next}

* Read about [service concepts](./concepts/index.md).
* Learn more about [creating clusters](./operations/cluster-create.md) and [connecting to clusters](./operations/connect.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}

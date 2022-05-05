# Migrating data to {{ mmg-name }}

To migrate your database to {{ mmg-name }}, you need to transfer the data, acquire a write lock for the old database, and transfer the load on the database cluster in {{ yandex-cloud }}.

There are two ways to migrate data from a third-party _source cluster_ to a {{ mmg-name }} _target cluster_:

* [{#T}](#data-transfer).

    This migration method lets you:
    * Migrate the database without interrupting user service.
    * Migrate from older {{ MG }} versions, starting from 4.0, to newer ones.
    * Go without creating an intermediate VM or granting online access to your {{ mmg-name }} target cluster.

    To use this migration method, allow connecting to the source cluster from the internet.

    For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [{#T}](#dump-and-restore).

    _A dump_ is a set of files using which you can restore the state of a database. To migrate data to a {{ mmg-name }} cluster, create a database dump using `mongodump` and restore it in the target cluster using `mongorestore`. To ensure that a dump is complete, before creating it, switch the source cluster to <q>read-only</q> mode.

## Before you start {#before-you-begin}

[Create a {{ mmg-name }}](./cluster-create.md) target cluster with the computing capacity and storage size appropriate for the environment where the migrated database is deployed.

The database name in the target cluster must be the same as the source database name.

## Migrating data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-mg).

1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-mg).

1. [Create a source endpoint](../../data-transfer/operations/source-endpoint.md#create-endpoint) with the following parameters:
    * **Database type**: `MongoDB`.
    * **Endpoint parameters** → **Connection settings**: `Custom installation`.
        Specify the parameters for connecting to the source cluster.

1. [Create a target endpoint](../../data-transfer/operations/target-endpoint.md#create-endpoint) with the following parameters:
    * **Database type**: `MongoDB`.
    * **Endpoint parameters** → **Connection settings**: `MDB cluster`.
        Specify the ID of the target cluster.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create-transfer) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

1. [Activate](../../data-transfer/operations/transfer.md#activate-transfer) it.

    {% note info %}

    Abstain from making any changes to the data schema in the source and target clusters when the data transfer is running. If the data schema in the source cluster changed, [restart](../../data-transfer/operations/transfer.md#reupload) the transfer.

    {% endnote %}

1. Wait for the transfer to change to the `Replicated` status.

1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.

1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait for it to transition to the `Stopped` status.

    For more information about the transfer lifecycle, see the appropriate [section](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../../data-transfer/operations/transfer.md#delete-transfer) the stopped transfer.

1. [Delete the source endpoint](../../data-transfer/operations/source-endpoint.md#delete).

1. [Delete the target endpoint](../../data-transfer/operations/target-endpoint.md#delete-endpoint).

## Migrating a database using a dump {#dump-and-restore}

Sequence of actions:

1. [Create a dump](#dump) of the database you want to migrate using `mongodump`.
1. If necessary, [create a VM](#create-vm) in {{ compute-name }} to restore the database from a dump in the {{ yandex-cloud }} infrastructure.
1. [Restore data from the dump](#restore) in the cluster using `mongorestore`.

### Create a dump {#dump}

You can create a database dump using `mongodump`. For more information about this utility, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/program/mongodump/).

1. Install `mongodump` and other utilities for working with MongoDB. Example for Ubuntu 20.04 LTS:

    ```bash
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt install mongodb-org-shell mongodb-org-tools
    ```

    Instructions for other platforms, as well as more information about installing utilities, can be found on the [Install MongoDB](https://docs.mongodb.com/manual/installation/) page.

1. Before creating a dump, we recommend switching the DBMS to &quot;read-only&quot; to avoid losing data that might appear while the dump is created.

1. Create a database dump:

    ```bash
    mongodump --host <DBMS server address> \
              --port <port> \
              --username <username> \
              --password "<password>" \
              --db <database name> \
              --out ~/db_dump
    ```

   If you can use multiple processor cores to create a dump, use the `- j` flag with the number of cores available:

    ```bash
    mongodump --host <DBMS server address> \
              --port <port> \
              --username <username> \
              --password "<password>" \
              -j <number of cores> \
              --db <database name> \
              --out ~/db_dump
    ```

1. Archive the dump:

    ```bash
    tar -cvzf db_dump.tar.gz ~/db_dump
    ```

### (optional) Create a VM for loading a dump {#create-vm}

You need an intermediate virtual machine in {{ compute-full-name }} if:

* Your {{ mmg-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

To prepare the virtual machine to restore the dump:

1. In the management console, [create a new virtual machine](../../compute/operations/vm-create/create-linux-vm.md) from the Ubuntu 20.04 LTS image. The required amount of RAM and processor cores depends on the amount of data to migrate and the required migration speed.

   The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a database that's up to 1 GB in size. The bigger the database being migrated, the more RAM and storage space you need (at least twice the size of the database).

   The virtual machine must be in the same network and availability zone as the {{ mmg-name }} cluster master host. The VM must be also assigned an external IP address so that you can upload the dump file from outside {{ yandex-cloud }}.

1. Install the {{ MG }} client and additional utilities for working with the DBMS:

    ```bash
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt install mongodb-org-shell mongodb-org-tools
    ```

1. Move the DB dump from your server to the VM. For example, you can use the `scp` utility:

    ```bash
    scp ~/db_dump.tar.gz <VM username>@<VM public address>:/tmp/db_dump.tar.gz
    ```

1. Unpack the dump on the virtual machine:

    ```bash
    tar -xzf /tmp/db_dump.tar.gz
    ```

As a result, you'll get a VM with a database dump that is ready to be restored to the {{ mmg-name }} cluster.

### Recover data {#restore}

Use the [mongorestore](https://docs.mongodb.com/manual/reference/program/mongorestore/) utility to restore your DB dump.

* If you restore a dump from the VM in {{ yandex-cloud }}:

    ```bash
    mongorestore --host <DBMS server address> \
                 --port <port> \
                 --username <username> \
                 --password "<password>" \
                 -j <number of cores> \
                 --authenticationDatabase <database name> \
                 --nsInclude '*.*' /tmp/db_dump
    ```

* If you restore from a dump stored on a server outside {{ yandex-cloud }}, SSL parameters must be explicitly set for `mongorestore`:

    ```bash
    mongorestore --host <DBMS server address> \
                 --port <port> \
                 --ssl \
                 --sslCAFile <path to certificate file> \
                 --username <username> \
                 --password "<password>" \
                 -j <number of cores> \
                 --authenticationDatabase <database name> \
                 --nsInclude '*.*' ~/db_dump
    ```

* If you only want to transfer specific collections, set the `--nsInclude` and `--nsExclude` flags, specifying the namespaces to include or exclude for the set of collections being restored.


# Migrating data to {{ mmg-name }}


To migrate your data to {{ mmg-name }}, follow these steps: transfer the data, switch the legacy database to read-only mode, transfer the workload over to the target cluster in {{ yandex-cloud }}.

You can migrate data from a third-party _source cluster_ to a {{ mmg-name }} _target cluster_ using the following two methods:

* [Migrating data via {{ data-transfer-full-name }}](#data-transfer).

    This migration method allows you to:

    * Migrate your database with zero downtime.
    * Migrate from older to newer versions of {{ MG }}.
    * Eliminate the need for an intermediate VM or for exposing your {{ mmg-name }} target cluster to the internet.

    To use this method, enable public access to the source cluster.

* [Migration via database dump](#dump-and-restore).

    A _dump_ is a collection of files allowing you to restore a database to a specific state. To migrate data to a {{ mmg-name }} cluster, create a database dump using `mongodump` and restore it on the target cluster using `mongorestore`. To ensure dump integrity, switch the source cluster to <q>read-only</q> mode before creating the dump.

    Use this method only if data migration via {{ data-transfer-full-name }} is impossible.

## Migrating data using {{ data-transfer-full-name }} {#data-transfer}

To transfer data:

1. [Create a target cluster](#create-cluster).
1. [Prepare source and target clusters](#prepare-source-target).
1. [Set up the endpoints and transfer](#prepare-endpoints-transfer).
1. [Transfer data](#transfer).

If you no longer need the resources you created, [delete them](#clear-out).


### Getting started {#before-you-begin-transfer}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

##### **Required paid resources** {#paid-resources-transfer}

* {{ mmg-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


### Create a target cluster {#create-cluster}

[Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) with computing capacity and storage size matching the source database’s environment.

The source and target database names must be the same.


### Prepare source and target clusters {#prepare-source-target}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-mg).
1. Make sure the source cluster’s network settings allow cluster connections from the internet.
1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-mg).


### Set up the endpoints and transfer {#prepare-endpoints-transfer}

1. {% include [source endpoint](../_tutorials_includes/storedoc-source-endpoint.md) %}
1. {% include [target endpoint](../_tutorials_includes/storedoc-target-endpoint.md) %}
1. {% include [storedoc transfer](../_tutorials_includes/storedoc-transfer.md) %}

### Transfer the data {#transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and transfer the workload over to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.

### Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Ensure the transfer is stopped, then delete it](../../data-transfer/operations/transfer.md#delete).
1. [Delete](../../data-transfer/operations/endpoint/index.md#delete) the source and target endpoints.
1. [Delete the {{ mmg-name }} cluster](../../storedoc/operations/cluster-delete.md).

## Migration via database dump {#dump-and-restore}

To transfer data via database dump:

1. [Create a target cluster](#create-cluster-dump).
1. [Create a dump](#dump) of the source database using `mongodump`.
1. If necessary, [create a VM](#create-vm) in {{ compute-name }} to restore the database from the dump within the {{ yandex-cloud }} infrastructure.
1. [Restore the data from the dump](#restore) to the cluster using `mongorestore`.

If you no longer need the resources you created, [delete them](#clear-out-dump).


### Getting started {#before-you-begin-dump}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

##### **Required paid resources** {#paid-resources-dump}

* {{ mmg-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../compute/pricing.md)).


### Create a target cluster {#create-cluster-dump}

[Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) with computing capacity and storage size matching the source database’s environment.

The source and target database names must be the same.

### Create a dump {#dump}

Use `mongodump` to create a database dump.

1. Install `mongodump` and other MongoDB tools. Example for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts):

    ```bash
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt install mongodb-org-shell mongodb-org-tools
    ```


1. Before creating a dump, we recommend switching your database to read-only mode to avoid losing any data that might be written during the dump process.

1. Create a database dump:

    ```bash
    mongodump --host <DBMS_server_address> \
              --port <port> \
              --username <username> \
              --password "<password>" \
              --db <DB_name> \
              --out ~/db_dump
    ```

   If you can use multiple CPU cores for the dump, specify the `-j` flag with the number of available cores:

    ```bash
    mongodump --host <DBMS_server_address> \
              --port <port> \
              --username <username> \
              --password "<password>" \
              -j <number_of_cores> \
              --db <DB_name> \
              --out ~/db_dump
    ```

1. Archive the dump:

    ```bash
    tar -cvzf db_dump.tar.gz ~/db_dump
    ```

### Optionally, create a VM for dump upload {#create-vm}

You will need an intermediate VM in {{ compute-full-name }} under the following conditions:

* Your {{ mmg-name }} cluster is not reachable from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

To prepare your virtual machine for dump recovery:

1. In the management console, [create a new VM](../../compute/operations/vm-create/create-linux-vm.md) from an [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image. The necessary amount of RAM and the number of CPU cores depend on the volume of data transferred and the required transfer speed.


   The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient for migrating a database of up to 1 GB. The larger the database being migrated, the more disk space and RAM are required, with the available disk space at least twice the database size.

   The VM must reside in the same network and availability zone as the {{ mmg-name }} cluster’s master host. The VM must have an external IP address, which will allow you to upload the dump from outside {{ yandex-cloud }}.

1. Install the {{ MG }} client and additional database utilities:

    ```bash
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt install mongodb-org-shell mongodb-org-tools
    ```

1. Move the database dump from your server to the VM with the help of `scp` or a similar tool:

    ```bash
    scp ~/db_dump.tar.gz <VM_username>@<VM_public_address>:/tmp/db_dump.tar.gz
    ```

1. Extract the dump on the virtual machine:

    ```bash
    tar -xzf /tmp/db_dump.tar.gz
    ```

Now you have a VM with a database dump, ready to be restored to the {{ mmg-name }} cluster.


### Restore the data {#restore}

Restore your database from the dump via `mongorestore`.

* If you are restoring a dump from a VM located in {{ yandex-cloud }}:

    ```bash
    mongorestore --host <DBMS_server_address> \
                 --port <port> \
                 --username <username> \
                 --password "<password>" \
                 -j <number_of_streams> \
                 --authenticationDatabase <DB_name> \
                 --nsInclude '*.*' /tmp/db_dump
    ```

* If you are restoring a dump from a server outside {{ yandex-cloud }}, you must explicitly specify the SSL settings for `mongorestore`:

    ```bash
    mongorestore --host <DBMS_server_address> \
                 --port <port> \
                 --ssl \
                 --sslCAFile <path_to_certificate_file> \
                 --username <username> \
                 --password "<password>" \
                 -j <number_of_streams> \
                 --authenticationDatabase <DB_name> \
                 --nsInclude '*.*' ~/db_dump
    ```

* To transfer only specific collections, use the `--nsInclude` and `--nsExclude` flags to specify the namespaces that should be included and excluded from the collections being restored.


### Delete the resources you created {#clear-out-dump}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ mmg-name }} cluster](../../storedoc/operations/cluster-delete.md).
1. If you created a virtual machine to upload the dump to, [delete it](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address, release and [delete it](../../vpc/operations/address-delete.md).

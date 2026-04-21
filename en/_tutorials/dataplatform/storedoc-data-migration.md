# Migrating data to {{ mmg-name }}


To migrate your data to {{ mmg-name }}, follow these steps: transfer the data, switch the legacy database to read-only mode, transfer the workload over to the target cluster in {{ yandex-cloud }}.

You can migrate data from a third-party _source cluster_ to a {{ mmg-name }} _target cluster_ using the following two methods:

* [Migrating data via {{ data-transfer-full-name }}](#data-transfer).

    This migration method allows you to:

    * Migrate your database with zero downtime.
    * Migrate from older to newer versions of {{ MG }}.
    * Eliminate the need for an intermediate VM or for exposing your {{ mmg-name }} target cluster to the internet.

    To use this migration method, enable internet access to the source cluster.

    For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [Migration via database dump](#dump-and-restore).

    A _dump_ is a collection of files allowing you to restore a database to a specific state. To migrate data to a {{ mmg-name }} cluster, create a database dump using `mongodump` and restore it on the target cluster using `mongorestore`. To ensure dump integrity, switch the source cluster to <q>read-only</q> mode before creating the dump.


## Required paid resources {#paid-resources}

When migrating data using {{ data-transfer-name }}, you pay for the following resources:

* {{ mmg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).

When migrating data using a database dump, you pay for the following resources:

* {{ mmg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Getting started {#before-you-begin}

[Create a {{ mmg-name }} target cluster](../../storedoc/operations/cluster-create.md) with computing capacity and storage size matching the source database’s environment.

The source and target database names must be the same.

## Migrating data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [MongoDB migration with Data Transfer](datatransfer/storedoc.md) %}

## Migration via database dump {#dump-and-restore}

Procedure:

1. [Create a dump](#dump) of the source database using `mongodump`.
1. If necessary, [create a VM](#create-vm) in {{ compute-name }} to restore the database from the dump within the {{ yandex-cloud }} infrastructure.
1. [Restore the data from the dump](#restore) to the cluster using `mongorestore`.

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

1. Move the database dump from your server to the VM via `scp` or a similar tool:

    ```bash
    scp ~/db_dump.tar.gz <VM_user_name>@<VM_public_address>:/tmp/db_dump.tar.gz
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

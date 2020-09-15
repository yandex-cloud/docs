# Migrating data to {{ mmg-name }}

To migrate your database to {{ mmg-name }}, you need to transfer the data directly, close the old database for writing, and then transfer the load to the database cluster in Yandex.Cloud.

To transfer data to a {{ mmg-name }} cluster, you can use `mongodump` and `mongorestore`: create a dump of a working database and restore it in the desired cluster.

Before importing your data, check whether the DBMS versions of the existing database and your cluster in Yandex.Cloud match. If not, you won't be able to restore the created dump.

Sequence of actions:

1. [Create a dump](#dump) of the database you want to migrate using `mongodump`.
1. If necessary, [create a virtual machine](#create-vm) in {{ compute-name }} to restore the database from the dump in the Yandex.Cloud infrastructure.
1. [Create a {{ mmg-name }} cluster](#create-cluster) where the restored database will be deployed.
1. [Restore data from the dump](#restore) in the cluster using`mongorestore`.

### Create a dump {#dump}

You can create a database dump using `mongodump`. For more information about this utility, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/program/mongodump/).

1. Install `mongodump` and other utilities for working with MongoDB. Example for Ubuntu and Debian distributions:

    ```
    $ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ...
    $ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    ...
    $ sudo apt-get update
    ...
    $ sudo apt-get install mongodb-org-shell mongodb-org-tools
    ```

    Instructions for other platforms, as well as more information about installing utilities, can be found on the [Install MongoDB](https://docs.mongodb.com/manual/installation/) page.

1. Before creating a dump, we recommend switching the DBMS to "read-only" to avoid losing data that might appear while the dump is created.

1. Create a database dump:

    ```
    $ mongodump --host <DBMS server address> --port <port> --username <username> --password "<password>" --db <database name> --out ~/db_dump
    ```

   If you can use multiple processor cores to create a dump, use the `- j` flag with the number of cores available:

    ```
    $ mongodump --host <DBMS server address> --port <port> --username <username> --password "<password>" -j <number of cores> --db <database name> --out ~/db_dump
    ```

1. Archive the dump:

    ```
    $ tar -cvzf db_dump.tar.gz ~/db_dump
    ```

### (optional) Create a virtual machine for loading the dump {#create-vm}

You need an intermediate virtual machine in {{ compute-full-name }} if:

* Your {{ mmg-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in Yandex.Cloud is not very reliable.

To prepare the virtual machine to restore the dump:

1. In the management console, [create a new virtual machine](../../compute/operations/vm-create/create-linux-vm.md) from the Ubuntu 18.04 image. The required amount of RAM and processor cores depends on the amount of data to migrate and the required migration speed.

   The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a DB up to 1 GB in size. The bigger the database being migrated, the more RAM and storage space you need (at least twice the size of the database).

   The virtual machine must be in the same network and availability zone as the {{ mmg-name }} cluster master host. Additionally, the VM must be assigned an external IP address so that you can load the dump file from outside Yandex.Cloud.

1. Install the {{ MG }} client and additional utilities for working with the DBMS:

    ```
    $ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ...
    $ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    ...
    $ sudo apt-get update
    ...
    $ sudo apt-get install mongodb-org-shell mongodb-org-tools
    ```

1. Move the DB dump from your server to the VM. For example, you can use the `scp` utility:

    ```
    scp ~/db_dump.tar.gz <VM username>@<VM public address>:/tmp/db_dump.tar.gz
    ```

1. Unpack the dump on the virtual machine:

    ```
    tar -xzf /tmp/db_dump.tar.gz
    ```

You get a virtual machine with a database dump that is ready to be restored to the {{ mmg-name }} cluster.

## Create a cluster {{ mmg-name }} {#create-cluster}

Create a cluster with the computing power and storage size appropriate for the environment where the existing database is deployed. More information about creating {{ mmg-name }} clusters can be found here: [{#T}](cluster-create.md) .

### Recover data {#restore}

Use the [mongorestore](https://docs.mongodb.com/manual/reference/program/mongorestore/) utility to restore your DB dump.

* If you restore a dump from a Yandex.Cloud virtual machine:

    ```
    $ mongorestore --host <DBMS server address> \
                   --port <port> \
                   --username <username> \
                   --password "<password>" \
                   -j <number of cores> \
                   --authenticationDatabase <database name> \
                   --nsInclude '*.*' /tmp/db_dump
    ```

* If you restore a dump from a server outside Yandex.Cloud, SSL parameters must be explicitly set for `mongorestore`:

    ```
    $ mongorestore --host <DBMS server address> \
                   --port <port> \
                   --ssl \
                   --sslCAFile <path to certificate file> \
                   --username <username> \
                   --password "<password>" \
                   -j <number of cores> \
                   --authenticationDatabase <database name> \
                   --nsInclude '*.*' ~/db_dump
    ```

* If you only want to transfer specific collections, set the `--nsInclude` and `--nsExclude` flags, specifying the namespaces to include or exclude for the collection being restored.


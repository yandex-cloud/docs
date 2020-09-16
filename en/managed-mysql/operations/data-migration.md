# Migrating data to {{ mmy-name }}

To migrate your database to {{ mmy-name }}, you need to transfer the data directly, close the old database for writing, and then transfer the load to the database cluster in Yandex.Cloud.

To migrate data to a {{ mmy-name }} cluster, you can use `mysqldump` and `mysql`: create a dump of a working database and restore it in the desired cluster.

Before importing your data, check whether the DBMS versions of the existing database and your cluster in Yandex.Cloud match. Since the dump is logical and a set of SQL queries, transferring data between clusters with different versions is possible, but not guaranteed. For more information, see [MySQL 5.7 FAQ Migration](https://dev.mysql.com/doc/refman/5.7/en/faqs-migration.html).

Below, the DBMS server you are migrating data from is called the _source server_, and the {{ mmy-name }} cluster that you are migrating to is the _destination server_.

Migration stages:

1. [Create a dump](#dump) of the database you want to migrate.
1. If necessary, [create a virtual machine](#create-vm) in Yandex.Cloud and upload your data to it.
1. [Create a cluster {{ mmy-name }}](#create-cluster).
1. [Restore data from the dump](#restore).

## Creating a dump {#dump}

You can create a database dump using `mysqldump`, which is described in detail in the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqlpump.html).

1. Before creating a dump, we recommend switching the database to <q>read-only</q> to avoid losing data that might appear while the dump is created. Create the database dump itself using the following command:

    ```bash
    $ mysqldump -h <source server address> \
                --user=<username> \
                --password \
                --port=<port> \
                --set-gtid-purged=OFF \
                --quick \
                --single-transaction <database name> \
                > ~/db_dump.sql
    ```

   If the source server uses InnoDB tables, use the `--single-transaction` option to guarantee data consistency. For MyISAM tables, there's no point in using this option because transactions are not supported. You should also consider the following flags:
   * `--events` — If there are recurring events in your database.
   * `--routines` — If your database contains functions and stored procedures.

1. Archive the dump:

    ```
    $ tar -cvzf db_dump.tar.gz ~/db_dump.sql
    ```

## (optional) Creating a VM in Yandex.Cloud and uploading a dump {#create-vm}

Transfer your data to an intermediate VM in {{ compute-full-name }} if:

* Your {{ mmy-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in Yandex.Cloud is not very reliable.

The required amount of RAM and processor cores depends on the amount of data to migrate and the required migration speed.

To prepare the virtual machine to restore the dump:

1. In the management console, create a new VM from Ubuntu image 18.04. The VM parameters depend on the size of the DB you want to migrate. The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a DB up to 1 GB in size. The size of the DB you are migrating determines how much RAM and disk space is necessary (you need at least twice the size of the DB).

    The virtual machine must be in the same network and availability zone as the {{ MY }} cluster master host. Additionally, the VM must be assigned an external IP address so that you can load the dump from outside Yandex.Cloud.

1. Install the {{ MY }} client and additional utilities for working with the DBMS. For Debian and Ubuntu, `mysqldump` and `mysql` are available in the [`mysql-client`](https://packages.ubuntu.com/search?keywords=mysql-client) package. To install it:

   ```
   $ sudo apt-get install mysql-client
   ```

1. Move the DB dump to the VM. For example, you can use `scp`:

    ```
    scp ~/db_dump.tar.gz <VM username>@<VM public address>:/tmp/db_dump.tar.gz
    ```

1. Unpack the dump:

    ```
    tar -xzf /tmp/db_dump.tar.gz
    ```

## Creating clusters {{ mmy-name }} {#create-cluster}

For instructions on creating a cluster, see [{#T}](./cluster-create.md).

## Restoring data {#restore}

Use [mysql](https://dev.mysql.com/doc/refman/5.7/en/mysql.html) to restore a database dump. To get more information in the event of an error, we recommend performing recovery with the `--line-numbers` flag.

* If you restore a dump from a Yandex.Cloud virtual machine:

    ```
    $ mysql -h <DBMS server address> \
            --user=<username> \
            --password \
            --port=3306 \
            --line-numbers <database name> \
            < /tmp/db_dump.sql
    ```

* If you restore a dump from your own server, download a certificate and set the `--ssl-cal` and `--ssl-mode` SSL parameters. You can find the commands for connecting to the cluster as well as a link to the certificate by clicking **Connect** in the management console.

  Command for restoring a database from a dump:

   ```
   $ mysql -h <DBMS server address> --user=<username> --password --port=3306 --ssl-ca=~/.mysql/root.crt --ssl-mode=VERIFY_IDENTITY --line-numbers <database name> < ~/db_dump.sql
   ```


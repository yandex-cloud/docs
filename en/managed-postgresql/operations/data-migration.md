# Migrating databases to {{ mpg-name }}

To migrate your database to {{ mpg-name }}, you need to directly transfer the data, acquire a write lock for the old database, and transfer the load on the database cluster in {{ yandex-cloud }}.

There are two ways to migrate data to a {{ mpg-name }} cluster:

* Logical replication is the recommended method ([subscriptions](https://www.postgresql.org/docs/current/sql-createsubscription.html)). The subscription mechanism that logical replication is built on lets data be transferred to the {{ mpg-name }} cluster with minimal downtime.
* Restoring a database from a dump using `pg_dump`.

Below, the DBMS server you are migrating data from is called the _source server_, and the {{ mpg-name }} cluster that you are migrating to is the _destination server_.

The instructions assume that you are familiar with basic Linux administration.

## Logical replication {#logical_replication}

Logical replication is supported as of {{ PG }} version 10. In addition to migrating data between the same DBMS versions, logical replication lets you migrate to later {{ PG }} versions: set up replication from the source server to the destination server running a later {{ PG }} version following the migration steps.

In {{ mpg-name }} clusters, subscriptions can be used by the database owner (a user created simultaneously with the cluster) and users with the `mdb.admin` role for the cluster.

Migration stages:

1. [Configure the source server](#source-setup).
1. [Export the database schema on the source](#source-schema-export).
1. [Create a destination cluster and restore the database schema](#restore-schema).
1. [Create a publication and subscription {{ PG }}](#create-publication-subscription).
1. [Move the {{ PG }} sequence after replication](#transfer-sequences).
1. [Disable replication and transfer the load](#transfer-load).

### Configure the data source server {#source-setup}

1. Specify the necessary SSL and WAL settings in the `postgresql.conf` file. In Debian and Ubuntu, the default path to this file is `/etc/postgresql/10/main/postgresql.conf`.

   1. We recommend using SSL for migrating data: this will not only help encrypt data, but also compress it. For more information, see [SSL Support](https://www.postgresql.org/docs/current/libpq-ssl.html) and [Database Connection Control Functions](https://www.postgresql.org/docs/current/libpq-connect.html) in the {{ PG }} documentation.

      To enable SSL, set the desired value in the configuration:

      ```ini
      ssl = on                   # on, off
      ```

   1. Change the logging level for [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html) to add the information needed for logical replication. To do this, set the value of the [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) as `logical`.

      The setting can be changed in `postgresql.conf`. Find the line with the `wal_level` setting, comment it out if necessary, and set the value as `logical`:

      ```ini
      wal_level = logical                    # minimal, replica, or logical
      ```

1. Configure host authentication on the source. To do this, add the cluster hosts in {{ yandex-cloud }} to the file `pg_hba.conf` (on Debian and Ubuntu distributions, the file is located at `/etc/postgresql/10/main/pg_hba.conf` by default).

   For this the lines that will allow incoming connections to the database from the specified hosts should be added.

   * If you use SSL:

     ```txt
     hostssl         all            all             <host address>      md5
     hostssl    replication         all             <host address>      md5
     ```

   * If you don't use SSL:

     ```txt
     host         all            all             <host address>      md5
     host    replication         all             <host address>      md5
     ```

1. If the source server has a firewall, allow incoming connections from the {{ mpg-name }} cluster hosts. For example, for Ubuntu 18:

   ```bash
   sudo ufw allow from <host address> to any port 5432
   ```

1. Restart the database server to apply all these settings:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Check the {{ PG }} status after restarting:

   ```bash
   sudo systemctl status postgresql
   ```

### Export the DB schema from the source {#source-schema-export}

Using the `pg_dump` utility, create a file with the database schema to be applied in the {{ mpg-name }} cluster.

```bash
pg_dump -h <DBMS server address> -U <username> -p <port> --schema-only --no-privileges --no-subscriptions -d <database name> -Fd -f /tmp/db_dump
```

This export command skips all data associated with privileges and roles to avoid conflicts with the database settings in {{ yandex-cloud }}. If your database requires additional users, [create them](cluster-users.md#adduser).

### Create a {{ mpg-name }} cluster and restore the database schema {#restore-schema}

If you don't have a {{ PG }} cluster in {{ yandex-cloud }}, [create a {{ mpg-name }} cluster](cluster-create.md). When creating a cluster, specify the same database name that's on the source server.

Restore the schema in the new cluster:

```bash
pg_restore -Fd -v --single-transaction -s --no-privileges \
          -h <target address> \
          -U <username> \
          -p 6432 \
          -d <database name> /tmp/db_dump
```

### Create a publication and subscription {#create-publication-subscription}

For logical replication to work, you need to define a publication (a group of logically replicated tables) on the source server and a subscription (a description of a connection to another database) on the receiving server.

1. On the source server, create a publication for all database tables. When migrating multiple databases, you need to create a separate publication for each of them.

   {% note info %}

   You need superuser rights to create publications to all tables, but not to transfer the selected tables. For more information about creating publications, see the [documentation {{ PG }}]( https://www.postgresql.org/docs/current/sql-createpublication.html).

   {% endnote %}

   Request:

   ```sql
   CREATE PUBLICATION p_data_migration FOR ALL TABLES;
   ```

1. On the {{ mpg-name }} cluster host, create a subscription with a connection string to the publication. For more information about creating subscriptions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/10/sql-createsubscription.html).

   Request with SSL enabled:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source server address> port=<port> user=<username> sslmode=verify-full dbname=<database name>' PUBLICATION p_data_migration;
   ```

   Without SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source server address> port=<port> user=<username> sslmode=disable dbname=<database name>' PUBLICATION p_data_migration;
   ```

1. You can monitor replication status from folders `pg_subscription_rel`. You can get the general replication status of the receiving server using `pg_stat_subscription` and on the source server using `pg_stat_replication`.

   ```sql
   select * from pg_subscription_rel;
   ```

   First of all, you should monitor replication status on the receiving server with the `srsubstate` field. `r` in the `srsubstate` field means that synchronization has ended and the databases are ready to be replicated.

### Migrate {{ PG }} sequences after replication {#transfer-sequences}

To fully complete synchronization between the source and the destination, disable writing new data on the source server and transfer the {{ PG }} sequences to the {{ mpg-name }} cluster:

1. Export {{ PG }} sequences from the source:

   ```bash
   pg_dump -h <DBMS server address> -U <username> -p <port> -d <database name> \
           --data-only -t '*.*_seq' > /tmp/seq-data.sql
   ```

   Pay attention to the pattern used: if the database you're migrating has sequences that don't match the `*.*_seq` pattern, you have to enter a different pattern to upload them. For more information about patterns, see the [documentation {{ PG }}]( https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Restore sequences on the {{ mpg-name }} host:

   ```bash
   psql -h <DBMS server address> -U <username> -p 6432 -d <database name> \
        < /tmp/seq-data.sql
   ```

### Disable replication and switch over the load {#transfer-load}

When replication is complete and you move the sequences, remove the subscription on the destination server (in the {{ mpg-name }} cluster):

   ```sql
   DROP SUBSCRIPTION s_data_migration;
   ```

Afterwards, the load can be transferred to the receiving server. Since transferring sequences is a relatively quick and easily automated process, migrating to {{ mpg-name }} is possible with minimal downtime.

## Restore database from dump {#backup}

To migrate data from an existing {{ PG }} database to {{ mpg-name }}, use `pg_dump` and `pg_restore`: create a dump of your running database and restore it to the {{ PG }} cluster in {{ yandex-cloud }}.

{% note info %}

To use `pg-restore`, you might need the `pg_repack` database extension.

{% endnote %}

Before trying to import your data, check whether the DBMS versions of the existing database and your cluster in {{ yandex-cloud }} match. If not, you won't be able to restore the created dump. To migrate to {{ PG }} version 11 or 12, you can use [logical replication](#logical_replication).

Migration stages:

1. [Create a dump of the database you want to migrate](#dump).
1. [(optional) Create a virtual machine in {{ yandex-cloud }} and upload the database dump to it](#create-vm).
1. [Create a cluster {{ mpg-name }}](#create-cluster).
1. [Restore data from the dump to the cluster](#restore).

### Create a database dump {#dump}

Use [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) to create a database dump.

1. Before creating a dump, we recommend switching the database to <q>read-only</q> to avoid losing data that might appear while creating the dump. The database dump itself is created using the following command:

    ```bash
    pg_dump -h <DBMS server address> -U <username> -Fd -d <database name> -f ~/db_dump
    ```

1. To speed up the process, you can start dumping with multiple processor cores. To do this, set the `-j` flag with the number equal to the number of cores available to the DBMS:

    ```bash
    pg_dump -h <DBMS server address> -U <username> -j 4 -Fd -d <database name> -f ~/db_dump
    ```

1. Archive the dump:

    ```bash
    tar -cvzf db_dump.tar.gz ~/db_dump
    ```

For more information about `pg_dump`, see the [documentation {{ PG }}](https://www.postgresql.org/docs/current/app-pgdump.html).

### (optional) Create a virtual machine in {{ yandex-cloud }} and upload the dump to it {#create-vm}

Transfer your data to an intermediate VM in {{ compute-name }} if:

* Your {{ mpg-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

The required amount of RAM and processor cores depends on the amount of data to migrate and the required migration speed.

To prepare the virtual machine to restore the dump:

1. In the management console, [create a new virtual machine](../../compute/operations/vm-create/create-linux-vm.md) from the [Ubuntu 20.04](https://cloud.yandex.com/en-ru/marketplace/products/f2eanb2gaki4us67hn9q) image. The VM parameters depend on the size of the database you want to migrate. The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a database that's up to 1 GB in size. The bigger the database being migrated, the more RAM and storage space you need (at least twice as large as the size of the database).

    The virtual machine must be in the same network and availability zone as the {{ PG }} cluster. Additionally, the VM must be assigned an external IP address so that you can load the dump from outside {{ yandex-cloud }}.

1. Set up the [{{ PG }} apt repository](https://www.postgresql.org/download/linux/ubuntu/).

1. Install the {{ PG }} client and additional utilities for working with the DBMS:

   ```bash
   $ sudo apt install postgresql-client-common
   
   # For PostgreSQL 10
   $ sudo apt install postgresql-client-10
   
   # For PostgreSQL 11
   $ sudo apt install postgresql-client-11
   
   # For PostgreSQL 12
   $ sudo apt install postgresql-client-12
   
   # For PostgreSQL 13
   $ sudo apt install postgresql-client-13
   ```

1. Move the DB dump to the VM. For example, you can use `scp`:

    ```bash
    scp ~/db_dump.tar.gz <VM username>@<VM public address>:/tmp/db_dump.tar.gz
    ```

1. Unpack the dump:

    ```bash
    tar -xzf /tmp/db_dump.tar.gz
    ```

### Create a {{ mpg-name }} cluster {#create-cluster}

Make sure that the computing capacity and storage size of the cluster are appropriate for the environment where the existing databases are deployed and [create a cluster](cluster-create.md).

### Restore data in the new environment {#restore}

Use the [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html) utility to restore your DB dump.

The version of `pg_restore` must match the `pg_dump` version, and the major version must be at least as high as on the DB where the dump is deployed.

In other words, to restore a dump of {{ PG }} 10, {{ PG }} 11, {{ PG }} 12, or {{ PG }} 13, use `pg_restore 10`, `pg_restore 11`, `pg_restore 12`, or `pg_restore 13`, respectively.

If you only need to restore a single schema, add the `-n <schema name>` flag (without it, the command only runs on behalf of the database owner). Best practice is to restore data with the `--single-transaction` flag to avoid an inconsistent state of the database if an error occurs:

```bash
pg_restore -Fd \
           -v \
           -h <pgsql_host_address> \
           -U <username>
           -d <database_name> \
           -p 6432 \
           /tmp/db_dump \
           --single-transaction \
           --no-privileges
```

For more information about `pg_restore`, see the [documentation {{ PG }}](https://www.postgresql.org/docs/current/app-pgrestore.html).


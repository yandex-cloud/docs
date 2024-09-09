---
title: "How to use pg_repack in {{ mpg-name }}"
description: "This guide describes how to install pg_repack and its client with an example of how to use the extension."
---

# Using pg_repack in {{ mpg-name }}

{{ PG }} tables and indexes may get bloated. When running transactions that update data in tables and indexes, its older version is retained in case you need to roll back the transactions. This causes tables and indexes to bloat during bulk data updates. You can use the [pgstattuple](./cluster-extensions.md#postgresql) extension or the [pgsql-bloat-estimation](https://github.com/ioguix/pgsql-bloat-estimation) queries to estimate the amount of bloat.

Older data versions are not deleted automatically. To free up storage space and remove bloat, you can delete the data you no longer need using the built-in [VACUUM FULL]({{ pg-docs }}/sql-vacuum.html) or [CLUSTER]({{ pg-docs }}/sql-cluster.html) commands. However, these commands require an exclusive lock on the processed tables, which may not be convenient or possible.

The [pg_repack](https://github.com/reorg/pg_repack) extension allows you to remove bloat in tables and indexes by repacking them. Unlike other methods, `pg_repack` works without holding an exclusive lock on the tables. For more information, see the [extension page](https://reorg.github.io/pg_repack/).

## Installing pg_repack in a {{ PG }} cluster {#install-extension}

1. [Add](./cluster-extensions.md#update-extensions) the `pg_repack` extension to the selected database.

1. [Assign](../grant.md#grant-role) the `mdb_admin` role to the owner of this database, if not assigned yet.

   You can get the owner's name with the [list of databases in the cluster](../databases.md#list-db).

1. [Set](../update.md#change-postgresql-config) the following {{ PG }} cluster parameters to zero:

   * [statement_timeout](../../concepts/settings-list.md#setting-statement-timeout)
   * [idle_in_transaction_session_timeout](../../concepts/settings-list.md#setting-idle-session-timeout)

   {% note warning %}

   Other values for these settings may cause long-running commands to interrupt or idle transactions to terminate. If so, a `pg_repack` run may fail to complete correctly.

   {% endnote %}

## Installing the pg_repack client {#install-client}

You need the same-name client to use the extension. The client must be installed on a host that can [connect to the {{ PG }} cluster](../connect.md).

To install the client:

1. [Check](./cluster-extensions.md#postgresql) the `pg_repack` version installed in the {{ PG }} cluster.
1. [Install](https://reorg.github.io/pg_repack/#installation) the `pg_repack` client.

   {% note warning %}

   The client and extension versions must match; otherwise, the connection will return the following error:

   ```text
   ERROR: pg_repack failed with error: program 'pg_repack ...' does not match database library 'pg_repack ...'
   ```

   {% endnote %}

   Depending on your operating system and connected repositories, you can install the client using a package manager, such as `apt` or `yum`. If the required client version is not available in the repositories, build it from the source files yourself.

   {% cut "How to build the pg_repack client on Ubuntu 22.04 LTS" %}

   1. Connect the [{{ PG }} Apt repository ](https://wiki.postgresql.org/wiki/Apt), which contains some of the required dependencies:

      ```bash
      sudo apt install -y postgresql-common && \
      sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y $(lsb_release -cs)
      ```

   1. Install the dependencies.

      Select the `postgresql-server-dev-*` package version that matches the version of the {{ PG }} cluster you plan to connect to using the client. This will improve the stability of the client you built.

      Here is an example of the command to install such a package for {{ PG }} 16 and other packages:

      ```bash
      sudo apt install git build-essential \
                       zlib1g-dev libzstd-dev liblz4-dev \
                       libreadline-dev \
                       postgresql-server-dev-16
      ```

   1. Clone the `pg_repack` Git repository by selecting the [relevant version tag](https://github.com/reorg/pg_repack/tags) and open the local directory containing the repository.

      Example of the command for the `ver_1.4.8` tag:

      ```bash
      git clone https://github.com/reorg/pg_repack.git \
          --branch ver_1.4.8 --depth 1 && \
      cd pg_repack
      ```

   1. Run the build:

      ```bash
      make
      ```

      Wait for the build process to complete.

   1. Place the `pg_repack` executable file in any directory listed in the `PATH` environment variable for the current user.

      Example of the command to move the file to `/usr/local/bin`:

      ```bash
      sudo install bin/pg_repack /usr/local/bin
      ```

   1. Check the client version:

      ```bash
      pg_repack --version
      ```

      This should output the version matching the tag you selected earlier, e.g.:

      ```text
      pg_repack 1.4.8
      ```

   {% endcut %}

## Running pg_repack {#run}

{% note tip %}

Run `pg_repack` when the {{ PG }} cluster load is minimum: database object repacking adds extra load to the cluster.

[Cluster and host state](../monitoring.md) data is available in the management console.

{% endnote %}

To run `pg_repack` and repack database objects:

1. [Make sure the cluster has enough free storage space](../monitoring.md#monitoring-cluster): at least twice the total size of the tables and indexes to repack.

   `pg_repack` works with copies of tables and indexes, which requires additional storage space for repacking.

1. Run the `pg_repack` client with the required parameters.

   Below are examples of commands for running the client with common parameter combinations. For a description of all supported parameters, see the [extension page](https://reorg.github.io/pg_repack/).

   {% note tip %}

   Add the `--dry-run` parameter to dry run `pg_repack` and review the planned updates.

   This will output the list of objects to repack when running `pg_repack` in the regular mode.

   {% endnote %}

   Run the command you need:

   * Command to repack the specified tables in the database:

      {% list tabs group=connection %}

      - Repacking with connection without SSL {#without-ssl}

         ```bash
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name> \
                   -t <table_name>
         ```

      - Repacking with connection via SSL {#with-ssl}

         ```bash
         PGSSLMODE='verify-full' \
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name> \
                   -t <table_name>
         ```

      {% endlist %}

      If you need to repack multiple tables, provide the required number of `-t` parameters, one for each table.

   * Command to repack the specified indexes in the database:

      {% list tabs group=connection %}

      - Repacking with connection without SSL {#without-ssl}

         ```bash
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name> \
                   -i <index_name>
         ```

      - Repacking with connection via SSL {#with-ssl}

         ```bash
         PGSSLMODE='verify-full' \
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name> \
                   -i <index_name>
         ```

      {% endlist %}

      If you need to repack multiple indexes, provide the required number of `-i` parameters, one for each index.

   * Command to repack all tables and indexes in the database:

      {% list tabs group=connection %}

      - Repacking with connection without SSL {#without-ssl}

         ```bash
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name>
         ```

      - Repacking with connection via SSL {#with-ssl}

         ```bash
         PGSSLMODE='verify-full' \
         pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                   -U <username> \
                   -d <database_name>
         ```

      {% endlist %}

## Usage example {#usage-example}

{% note info %}

The example was tested in the following environment:

* {{ PG }} `16` cluster where:

   * A [database](../databases.md#add-db) named `db1` is created with `user1` as its owner.
   * `pg_repack` version `1.4.8` is [installed](#install-extension) in the `db1` database.

* {{ yandex-cloud }} VM running Ubuntu 22.04 LTS where:

   * `pg_repack` client version `1.4.8` built from source files is [installed](#install-client).
   * [SSL](../connect.md#get-ssl-cert) [connections to the cluster](../connect.md) are enabled.

{% endnote %}

This example uses [pgbench]({{ pg-docs }}/pgbench.html), a tool designed for {{ PG }} load testing which allows you to automate the following operations:

* Create test tables and indexes and populate the tables with test data.
* Running multiple queries to test tables, including `INSERT` and `DELETE` queries that update the table contents.

After the`pgbench` operation is complete, test tables and their relevant indexes become bloated as a result of running a large number of queries. Also, `pgbench` runs the `VACUUM` command, which removes table and index bloat, at the beginning rather than the end of its operation. So we will use `pgbench` to create bloated tables and indexes to demonstrate how `pg_repack` works.

To test `pg_repack` on the `pgbench` test tables and indexes:

1. [Get the {{ PG }} cluster ID](../cluster-list.md#list-clusters).

1. [Add](./cluster-extensions.md#update-extensions) the `pgstattuple` extension to the `db1` database.

   This extension allows you to estimate table and index bloat to see how `pg_repack` works.

1. Install `pgbench` on your VM:

   ```bash
   sudo apt install postgresql-contrib
   ```

   {% note info %}

   The {{ PG }} Apt repository contains the `postgresql-contrib` package.

   If you deleted this repository from the virtual machine after [building](#install-client) the `pg_repack` client on Ubuntu 22.04 LTS, reconnect the repository.

   {% endnote %}

1. Create test tables and indexes in the `db1` database by connecting to it as its owner (`user1`):

   ```bash
   PGSSLMODE='verify-full' \
   pgbench -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
           -U user1 -i -s 1 db1
   ```

   This will create the following tables and indexes:

   | Table | Index |
   | ------- | ------ |
   | `pgbench_accounts` | `pgbench_accounts_pkey` |
   | `pgbench_branches` | `pgbench_branches_pkey` |
   | `pgbench_tellers` | `pgbench_tellers_pkey` |
   | `pgbench_history` | — |

1. View the statistics for the `pgbench_*` tables and indexes:

   1. [Connect](../connect.md#bash) to the `db1` database as the owner (`user1`). Use `psql` to connect.

   1. Request table statistics:

      ```sql
      SELECT * FROM pgstattuple('pgbench_accounts');
      SELECT * FROM pgstattuple('pgbench_branches');
      SELECT * FROM pgstattuple('pgbench_tellers');
      SELECT * FROM pgstattuple('pgbench_history');
      ```

   1. Request index statistics:

      ```sql
      SELECT * FROM pgstattuple('pgbench_accounts_pkey');
      SELECT * FROM pgstattuple('pgbench_branches_pkey');
      SELECT * FROM pgstattuple('pgbench_tellers_pkey');
      ```

   The `dead_tuple_count` columns must show zero for all query results. This means there are no bloated tables and indexes.

   > **Here is an example of partial output for the `pgbench_accounts` table:**
   >
   > ```sql
   >  table_len | tuple_count | ... | dead_tuple_count | ... | free_space | free_percent
   > -----------+-------------+-...-+------------------+-...-+------------+--------------
   >   13434880 |      100000 | ... |                0 | ... |     188960 |         1.41
   > ```

1. Run `pgbench` once:

   ```bash
   PGSSLMODE='verify-full' \
   pgbench -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
           -U user1 -c 5 -j 2 -t 1000 db1
   ```

   Wait for the `pgbench` run to complete. This may take several minutes.

1. Recheck statistics for the `pgbench_*` tables and indexes:

   Non-zero values in the `dead_tuple_count` columns indicate table and index bloat. For test tables and indexes created by `pgbench`, the `pgbench_tellers` table will show the greatest bloating.

1. Dry run `pg_repack` to review the planned updates:

   ```bash
   PGSSLMODE='verify-full' \
   pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
             -U user1 \
             -d db1 \
             --dry-run
   ```

   Since some indexes and tables are not bloated, the output will not include all database objects.

   > **Output example:**
   >
   > ```text
   > INFO: repacking table "public.pgbench_accounts"
   > INFO: repacking table "public.pgbench_branches"
   > INFO: repacking table "public.pgbench_tellers"
   > ```

1. Run `pg_repack` in the regular mode to repack tables and indexes:

   ```bash
   PGSSLMODE='verify-full' \
   pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
             -U user1 \
             -d db1
   ```

   Wait for the `pg_repack` run to complete. This may take several minutes.

1. Recheck statistics for the `pgbench_*` tables and indexes:

   The `dead_tuple_count` columns must show zero for all query results. This means there are no bloated tables or indexes and `pg_repack` did its job correctly.

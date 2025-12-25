---
title: How to use pg_repack in {{ mpg-name }}
description: In this tutorial, you will learn how to install and use pg_repack and its client, with a practical example.
---

# Using pg_repack in {{ mpg-name }}

{{ PG }} tables and indexes may become bloated. During transactions that update data in tables and indexes, the old data is kept to allow for rollback if needed. This causes tables and indexes to bloat during bulk data updates. You can use the [pgstattuple](./cluster-extensions.md#postgresql) extension or the [pgsql-bloat-estimation](https://github.com/ioguix/pgsql-bloat-estimation) queries to assess bloat.

The system does not automatically purge old data versions. To free up storage space and eliminate bloat, you can purge data you no longer need using the [VACUUM FULL]({{ pg-docs }}/sql-vacuum.html) or [CLUSTER]({{ pg-docs }}/sql-cluster.html) commands. These commands require an exclusive table lock, which may not be convenient or acceptable.

The [pg_repack](https://github.com/reorg/pg_repack) extension allows you to remove bloat from tables and indexes by repacking them. `pg_repack` does not require an exclusive table lock, unlike other methods. For more information, see the [extension page](https://reorg.github.io/pg_repack/).

## Installing pg_repack in a {{ PG }} cluster {#install-extension}

1. [Enable](./cluster-extensions.md#update-extensions) the `pg_repack` extension in your database.

1. [Assign](../grant.md#grant-role) the `mdb_admin` or `mdb_superuser` role to the database owner, if not assigned yet.

    You can get the owner's name from the [cluster’s database list](../databases.md#list-db).

1. [Set](../update.md#change-postgresql-config) the following {{ PG }} cluster settings to zero:

    * [statement_timeout](../../concepts/settings-list.md#setting-statement-timeout)
    * [idle_in_transaction_session_timeout](../../concepts/settings-list.md#setting-idle-session-timeout)

    {% note warning %}

    Assigning other values to these settings may cause termination of long-running commands and idle transactions. This may result in `pg_repack` failure.

    {% endnote %}

## Installing the pg_repack client {#install-client}

To manage the extension you need the pg_repack client. You need to install the client on a host with [connectivity to the {{ PG }} cluster](../connect.md).

To install the client:

1. [Check](./cluster-extensions.md#postgresql) the `pg_repack` version installed in the {{ PG }} cluster.
1. [Install](https://reorg.github.io/pg_repack/#installation) the `pg_repack` client.

    {% note warning %}

    The client and extension versions must match; otherwise, the connection will terminate with this error:

    ```text
    ERROR: pg_repack failed with error: program 'pg_repack ...' does not match database library 'pg_repack ...'
    ```

    {% endnote %}

    Depending on your operating system and enabled repositories, you can install the client via a package manager, e.g., `apt` or `yum`. If the required client version is missing from your repositories, you can build it from source.

    {% cut "How to build the pg_repack client on Ubuntu 22.04 LTS" %}

    1. Add the [{{ PG }} Apt repository](https://wiki.postgresql.org/wiki/Apt), which contains some of the required dependencies:

        ```bash
        sudo apt install -y postgresql-common && \
        sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y $(lsb_release -cs)
        ```

    1. Install the dependencies.

        Select the `postgresql-server-dev-*` package version matching the version of your target {{ PG }} cluster for the client connection. This will improve the stability of the compiled client.

        Example command installing this package for {{ PG }} 16 alongside other packages:

        ```bash
        sudo apt install git build-essential \
                         zlib1g-dev libzstd-dev liblz4-dev \
                         libreadline-dev \
                         postgresql-server-dev-16
        ```

    1. Clone the `pg_repack` Git repository using the [relevant version tag](https://github.com/reorg/pg_repack/tags), then navigate to your local repository directory.

        Example command using the `ver_1.4.8` tag:

        ```bash
        git clone https://github.com/reorg/pg_repack.git \
            --branch ver_1.4.8 --depth 1 && \
        cd pg_repack
        ```

    1. Build the project:

        ```bash
        make
        ```

        Wait for the build to complete.

    1. Place the `pg_repack` binary in any directory listed in the current user’s `PATH` environment variable.

        Example command for moving the file to `/usr/local/bin`:

        ```bash
        sudo install bin/pg_repack /usr/local/bin
        ```

    1. Check the client version:

        ```bash
        pg_repack --version
        ```

        You should see the client version matching your previously selected tag, e.g.:

        ```text
        pg_repack 1.4.8
        ```

    {% endcut %}

## Running pg_repack {#run}

{% note tip %}

Run `pg_repack` when the {{ PG }} cluster is least busy, as database object repacking will create extra load.

[Cluster and host status](../monitoring.md) data is available in the management console.

{% endnote %}

To run `pg_repack` and repack database objects:

1. [Make sure the cluster has enough free storage space](../monitoring.md#monitoring-cluster): at least twice the total volume of all tables and indexes to be repacked.

    During its operation, `pg_repack` creates copies of tables and indexes, which requires additional storage space.

1. Run the `pg_repack` client with your preferred options.

    Here are example commands with frequently used option combinations for the client. For all supported options, see the [extension page](https://reorg.github.io/pg_repack/).

    {% note tip %}

    Add the `--dry-run` flag to dry-run `pg_repack` in order to review the planned updates.

    You will see the list of objects that will be repacked when `pg_repack` is run in regular mode.

    {% endnote %}

    Run one of the following commands:

    * Repacking the specified database tables:

        {% list tabs group=connection %}

        - Repacking via a non-SSL connection {#without-ssl}

            ```bash
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name> \
                      -t <table_name>
            ```

        - Repacking via an SSL connection {#with-ssl}

            ```bash
            PGSSLMODE='verify-full' \
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name> \
                      -t <table_name>
            ```

        {% endlist %}

        To repack multiple tables, provide one `-t` argument per table.

    * Repacking the specified database indexes:

        {% list tabs group=connection %}

        - Repacking via a non-SSL connection {#without-ssl}

            ```bash
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name> \
                      -i <index_name>
            ```

        - Repacking via an SSL connection {#with-ssl}

            ```bash
            PGSSLMODE='verify-full' \
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name> \
                      -i <index_name>
            ```

        {% endlist %}

        To repack multiple indexes, provide one `-i` argument per index.

    * Repacking all database tables and indexes:

        {% list tabs group=connection %}

        - Repacking via a non-SSL connection {#without-ssl}

            ```bash
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name>
            ```

        - Repacking via an SSL connection {#with-ssl}

            ```bash
            PGSSLMODE='verify-full' \
            pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
                      -U <username> \
                      -d <DB_name>
            ```

        {% endlist %}

## Usage example {#usage-example}

{% note info %}

This example was tested in the following environment:

* {{ PG }} `16` cluster containing the following resources:

    * [Database](../databases.md#add-db) `db1` owned by `user1`.
    * `pg_repack``1.4.8` [extension](#install-extension) installed for database `db1`.

* {{ yandex-cloud }} VM running Ubuntu 22.04 LTS, with the following configuration:

    * Installed `pg_repack` [client](#install-client) `1.4.8` built from source.
    * Enabled [SSL](../connect.md#get-ssl-cert) [connections to the cluster](../connect.md).

{% endnote %}

This example uses [pgbench]({{ pg-docs }}/pgbench.html), a {{ PG }} load-testing tool, allowing you to automate the following operations:

* Creating test tables and indexes, and populating tables with test data.
* Running multiple queries against test tables, including `INSERT` and `DELETE` queries.

After `pgbench` finishes, the test tables and indexes remain bloated from the high query load during its run, and because `pgbench` executes the bloat-removing `VACUUM` command at the beginning rather than the end of its operation. In our example, to demonstrate the operation of `pg_repack`, we will first create bloated tables and indexes by running `pgbench`.

To test `pg_repack` on the test tables and indexes used by `pgbench`, do the following:

1. [Get the {{ PG }} cluster ID](../cluster-list.md#list-clusters).

1. [Enable](./cluster-extensions.md#update-extensions) the `pgstattuple` extension in the `db1` database.

    This extension will let us assess the table and index bloat, allowing us to see the results of `pg_repack` operation.

1. Install `pgbench` on the VM:

    ```bash
    sudo apt install postgresql-contrib
    ```

    {% note info %}

    `postgresql-contrib` package is available in the {{ PG }} Apt repository.

    If you deleted this repository from the virtual machine after [building](#install-client) the `pg_repack` client on Ubuntu 22.04 LTS, please add it again.

    {% endnote %}

1. Connect to the database `db1` as its owner `user1` and create test tables and indexes:

    ```bash
    PGSSLMODE='verify-full' \
    pgbench -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
            -U user1 -i -s 1 db1
    ```

    This command will create the following tables and indexes:

    | Table | Index |
    | ------- | ------ |
    | `pgbench_accounts` | `pgbench_accounts_pkey` |
    | `pgbench_branches` | `pgbench_branches_pkey` |
    | `pgbench_tellers`  | `pgbench_tellers_pkey`  |
    | `pgbench_history`  | —                       |

1. Check the statistics for the `pgbench_*` tables and indexes:

    1. [Connect](../connect.md#bash) to the database `db1` as its owner `user1`. Use `psql` to connect.

    1. Query the table statistics:

        ```sql
        SELECT * FROM pgstattuple('pgbench_accounts');
        SELECT * FROM pgstattuple('pgbench_branches');
        SELECT * FROM pgstattuple('pgbench_tellers');
        SELECT * FROM pgstattuple('pgbench_history');
        ```

    1. Query the index statistics:

        ```sql
        SELECT * FROM pgstattuple('pgbench_accounts_pkey');
        SELECT * FROM pgstattuple('pgbench_branches_pkey');
        SELECT * FROM pgstattuple('pgbench_tellers_pkey');
        ```

    The `dead_tuple_count` columns should contain zeros for all query results, indicating that there are no bloated tables and indexes.

    > **Partial output example for the `pgbench_accounts` table:**
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

    Wait for `pgbench` to finish. This may take several minutes.

1. Check the `pgbench_*` table and index statistics once more.

    Non-zero values in the `dead_tuple_count` columns indicate table and index bloat. Among the test tables and indexes created by `pgbench`, the `pgbench_tellers` table will show the greatest bloat.

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

1. Run `pg_repack` in regular mode to repack tables and indexes:

    ```bash
    PGSSLMODE='verify-full' \
    pg_repack -k -h c-<cluster_ID>.rw.{{ dns-zone }} -p 6432 \
              -U user1 \
              -d db1
    ```

    Wait for `pg_repack` to finish. This may take several minutes.

1. Check the `pgbench_*` table and index statistics once more.

    The `dead_tuple_count` columns should contain zeros for all query results. This means that `pg_repack` has run correctly, debloating tables and indexes.

---
title: Connecting to a {{ SD }} cluster in {{ mmg-full-name }}
description: In this tutorial, you will learn how to connect to a database in a {{ SD }} cluster via command line tools, graphical IDEs, or Docker container.
---

# Connecting to a {{ SD }} cluster from applications

You can connect to a {{ SD }} cluster using [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), or [Docker containers](#connection-docker). For details on connecting from your application code, see [Code examples](code-examples.md).

In the following examples, we assume that the `root.crt` [SSL certificate](index.md#get-ssl-cert) is located in one of these directories:

* `~/.mongodb/` for Ubuntu
* `$HOME\.mongodb` for Windows

After you successfully connect to the cluster and run a test query, you will see the name of the database you connected to.

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

The setup method depends on whether [sharding](../../concepts/sharding.md) is enabled in the cluster:


### Linux (Bash) {#bash}

Before connecting, install [MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Connecting over SSL for {{ SD }} version 4.2 and above {#with-ssl}

    For a non-sharded cluster:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

    For a sharded cluster:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<MONGOINFRA_or_MONGOS_host_1_FQDN>:27017,...,<MONGOINFRA_or_MONGOS_host_N_FQDN>:27017' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

- Connecting over SSL for {{ SD }} version 4.0 {#with-ssl-4}

    For a non-sharded cluster:

    ```bash
    mongosh --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

    For a sharded cluster:

    ```bash
    mongosh --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --host '<MONGOINFRA_or_MONGOS_host_1_FQDN>:27017,...,<MONGOINFRA_or_MONGOS_host_N_FQDN>:27017' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

- Connecting without SSL {#without-ssl}

    For a non-sharded cluster:

    ```bash
    mongosh --norc \
            --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

    For a sharded cluster:

    ```bash
    mongosh --norc \
            --host '<MONGOINFRA_or_MONGOS_host_1_FQDN>:27017,...,<MONGOINFRA_or_MONGOS_host_N_FQDN>:27017' \
            --username <DB_user_name> \
            --password <DB_user_password> \
            <DB_name>
    ```

{% endlist %}

{% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

Once connected, run the `db` command.

### Windows (PowerShell) {#powershell}

Before connecting, install [MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Connecting over SSL for {{ SD }} version 4.2 and above {#with-ssl}

    For a non-sharded cluster:

    ```powershell
    mongosh.exe --norc `
                --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' `
                --tls `
                --tlsCAFile $HOME\.mongodb\root.crt `
                --username <DB_user_name> `
                --password <DB_user_password> `
                <DB_name>
    ```

    For a sharded cluster:

    ```powershell
    mongosh.exe --norc `
                --host '<MONGOINFRA_or_MONGOS_host_1_FQDN>:{{ port-mmg-sharded }},...,<MONGOINFRA_or_MONGOS_host_N_FQDN>:{{ port-mmg-sharded }}' `
                --tls `
                --tlsCAFile $HOME\.mongodb\root.crt `
                --username <DB_user_name> `
                --password <DB_user_password> `
                <DB_name>
    ```

- Connecting without SSL {#without-ssl}

    For a non-sharded cluster:

    ```powershell
    mongosh.exe --norc `
                --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' `
                --username <DB_user_name> `
                --password <DB_user_password> `
                <DB_name>
    ```

    For a sharded cluster:

    ```powershell
    mongosh.exe --norc `
                --host '<MONGOINFRA_or_MONGOS_host_1_FQDN>:{{ port-mmg-sharded }},...,<MONGOINFRA_or_MONGOS_host_N_FQDN>:{{ port-mmg-sharded }}' `
                --username <DB_user_name> `
                --password <DB_user_password> `
                <DB_name>
    ```

{% endlist %}

{% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

Once connected, run the `db` command.

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mmg-ide-envs.md) %}

From graphical IDEs, you can only connect to public cluster hosts using an [SSL certificate](index.md#get-ssl-cert).

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

### DataGrip {#datagrip}

1. Create a data source:
   1. Select **File** → **New** → **Data Source** → **{{ MG }}**.
   1. On the **General** tab:
      1. Configure the connection as follows:
         * **User**, **Password**: Database user name and password.
         * **URL**: Connection string.

              For a non-sharded cluster:

              ```http
              mongodb://<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},..,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}/<DB_name>
              ```

              For a [sharded](../../concepts/sharding.md) cluster:

              ```http
              mongodb://<MONGOINFRA_or_MONGOS_host_1_FQDN>:{{ port-mmg-sharded }},...<MONGOINFRA_or_MONGOS_host_N_FQDN>:{{ port-mmg-sharded }}/<DB_name>
              ```

              {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

      1. Click **Download** to get the database driver.
   1. On the **SSH/SSL** tab:
      1. Enable **Use SSL**.
      1. In the **CA file** field, specify the path to the [SSL certificate for your connection](./index.md#get-ssl-cert).
1. Click **Test Connection**. If the connection is successful, you will see the connection status, DBMS information, and driver details.
1. Click **OK** to save the data source.

### DBeaver {#dbeaver}

Connections to {{ SD }} clusters are only available in [DBeaver commercial editions](https://dbeaver.com/buy/).

To connect to your cluster:

1. Create a new database connection:
   1. In the **Database** menu, select **New connection**.
   1. Select **{{ MG }}** from the database list.
   1. Click **Next**.
   1. On the **Main** tab, specify the connection settings:
      1. Under **Address**, change **Type** to `URL` and specify the connection string.

           For a non-sharded cluster:

           ```http
           mongodb://<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},..,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}/<DB_name>
           ```

           For a [sharded](../../concepts/sharding.md) cluster:

           ```http
           mongodb://<MONGOINFRA_or_MONGOS_host_1_FQDN>:{{ port-mmg-sharded }},...<MONGOINFRA_or_MONGOS_host_N_FQDN>:{{ port-mmg-sharded }}/<DB_name>
           ```

           {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

      1. In the **Device** list, select the `SCRAM-SHA-256` password encryption type for the connection.
      1. Under **Authentication**, specify the database user name and password.
   1. On the **SSL** tab:
      1. Enable **Use SSL**.
      1. In the **Root certificate** field, specify the path to your saved [SSL certificate](./index.md#get-ssl-cert) file.
      1. Under **Settings**, check **Skip hostname validation**.
1. Click **Test connection ...**. If the connection is successful, you will see the connection status, DBMS information, and driver details.
1. Click **Ready** to save the database connection settings.

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mmg-name }} cluster from a Docker container over SSL, add the following lines to your Dockerfile:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir --parents ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

To connect without SSL, no additional Dockerfile configuration is required.

After starting the Docker container, access it and install `mongosh`, which you will need to connect to the cluster.

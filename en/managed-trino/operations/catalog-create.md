---
title: Creating a {{ TR }} catalog
description: Follow this guide to create a catalog in a {{ mtr-name }} cluster.
---

# Creating a {{ TR }} catalog

## Roles for creating a {{ TR }} catalog {#roles}

To create a [{{ TR }} catalog](../concepts/index.md#catalog) with the [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) connection type, your {{ yandex-cloud }} account needs an additional role, [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user), to use connections from {{ connection-manager-name }}.

Make sure you assign the [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) and [{{ roles-lockbox-payloadviewer }}](../../lockbox/security/index.md#lockbox-payloadViewer) roles to the cluster [service account](../../iam/concepts/users/service-accounts.md). The cluster will thus get the permissions it needs to work with connections from {{ connection-manager-name }}. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Creating a {{ TR }} catalog {#create-catalog}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Click **{{ ui-key.yacloud.trino.catalogs.create_action }}**.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** field, enter a name for the {{ TR }} catalog.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** field, select the [connector](../concepts/index.md#connector) type.
  1. Configure [{{ TR }} catalog settings](#catalog-settings).
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## {{ TR }} catalog settings {#catalog-settings}

{{ TR }} catalog settings depend on the connector you select.

{% note info %}

Connectors marked with {{ preview-stage }} are at the preview stage. Their stability is not guaranteed.

{% endnote %}

### {{ CH }} connector {#ch}

To tailor the settings, select the connection type: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

{% list tabs %}

- Connection Manager

  * **Connection ID**: Connection ID in {{ connection-manager-name }} for connection to the {{ CH }} cluster.
    
    To find out the connection ID:
      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

  * **Database**: DB name in the {{ CH }} cluster.
  * **Client parameters**: {{ CH }} client parameters in `key: value` format.

    {% cut "Available parameters" %}

    * `async`: Use of asynchronous mode, `true` or `false`.

    * `buffer_queue_variation`: How many times the buffer can be filled up before its size is increased.

    * `buffer_size`: Buffer size, increases to `max_buffer_size` on overflow.

    * `client_name`: Client name.

    * `compress`: Data compression in the server response, `true` or `false`.

    * `compress_algorithm`: Data compression algorithm. The possible values are: [BROTLI](https://en.wikipedia.org/wiki/Brotli), [BZ2](https://en.wikipedia.org/wiki/Bzip2), [DEFLATE](https://en.wikipedia.org/wiki/Deflate), [GZIP](https://en.wikipedia.org/wiki/Gzip), [LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)), [SNAPPY](https://en.wikipedia.org/wiki/Snappy_(compression)), [XZ](https://en.wikipedia.org/wiki/XZ_Utils), [ZSTD](https://en.wikipedia.org/wiki/Zstd), or `NONE`.

    * `compress_level`: Data compression level.

    * `connect_timeout`: Maximum server connection timeout, in milliseconds.

    * `decompress`: Decompressing data in client request, `true` or `false`.

    * `decompress_algorithm`: Data decompression algorithm. The possible values are: [BROTLI](https://en.wikipedia.org/wiki/Brotli), [BZ2](https://en.wikipedia.org/wiki/Bzip2), [DEFLATE](https://en.wikipedia.org/wiki/Deflate), [GZIP](https://en.wikipedia.org/wiki/Gzip), [LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)), [SNAPPY](https://en.wikipedia.org/wiki/Snappy_(compression)), [XZ](https://en.wikipedia.org/wiki/XZ_Utils), [ZSTD](https://en.wikipedia.org/wiki/Zstd), or `NONE`.

    * `decompress_level`: Data decompression level.

    * `failover`: Maximum number of attempts to connect to replicas if the server is unavailable.

    * `load_balancing_policy`: Replica selection algorithm for connection.
        
        * `firstAlive`: Request goes to the first available replica.
        * `random`: Request goes to a random replica.
        * `roundRobin`: Applies the [Round-robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) policy to select a replica.

    * `max_buffer_size`: Maximum buffer size.

    * `max_threads_per_client`: Maximum number of threads per client.

    * `product_name`: Product name in `User-Agent`.

    * `read_buffer_size`: Read buffer size, in bytes. The default value is `buffer_size`. When the buffer is full, the size gets increased to `max_buffer_size`.

    * `request_buffering`: Request buffering mode.

        * `RESOURCE_EFFICIENT`: Provides moderate performance with minimum use of CPU and RAM. This mode relies only on the buffer size, no queue is used.
        * `PERFORMANCE`: Maximizes performance by actively utilizing CPU and RAM.
        * `CUSTOM`: Allows manual buffering settings to balance out resource utilization and desired performance.

    * `request_chunk_size`: Request chunk size, in bytes.

    * `response_buffering`: Response buffering mode.

        * `RESOURCE_EFFICIENT`: Provides moderate performance with minimum use of CPU and RAM. This mode relies only on the buffer size, no queue is used.
        * `PERFORMANCE`: Maximizes performance by actively utilizing CPU and RAM.
        * `CUSTOM`: Allows manual buffering settings to balance out resource utilization and desired performance.

    * `server_time_zone`: Serve time zone.

    * `use_server_time_zone`: Use of the server time zone, `true` or `false`.

    * `use_server_time_zone_for_dates`: Use of the server time zone when processing the `Date` values, `true` or `false`.

    * `use_time_zone`: What time zone to use, i.e., `Europe/Amsterdam`. Applies if `use_server_time_zone` is `false`.

    * `write_buffer_size`: Write buffer size, in bytes. By default, equals `buffer_size`. When the buffer is full, the size gets increased to `max_buffer_size`.

    {% endcut %}

  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/clickhouse.html).

- On-premise

  * **URL**: URL for connecting to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
  * **Username**: Username for connecting to the {{ CH }} DB.
  * **Password**: User password for connecting to the {{ CH }} DB.
  * **Additional settings**: Provide in `key: value` format. For a list of settings available, see the [official documentation](https://trino.io/docs/current/connector/clickhouse.html).

{% endlist %}

### Delta Lake connector {#delta-lake}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/delta-lake.html).

### Hive connector {#hive}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/hive.html).

### Iceberg connector {#iceberg}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/iceberg.html).

### Oracle connector {{ preview-stage }} {#oracle}

  * **Connection type**: On-premise.
  * **URL**: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>`. `SID`: Oracle system ID.
  * **Username**: Username for connecting to the Oracle DB.
  * **Password**: User password for connecting to the Oracle DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/oracle.html).

### {{ PG }} connector {#pg}

To tailor the settings, select the connection type: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

{% list tabs %}

- Connection Manager

  * **Connection ID**: Connection ID in {{ connection-manager-name }} for connection to the {{ PG }} cluster.
    
    To find out the connection ID:
      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

  * **Database**: DB name in the {{ PG }} cluster.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/postgresql.html).

- On-premise

  * **URL**: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
  * **Username**: Username for connecting to the {{ PG }} DB.
  * **Password**: User password for connecting to the {{ PG }} DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/postgresql.html).

{% endlist %}

### MS SQL Server connector {{ preview-stage }} {#ms-sql}

  * **Connection type**: On-premise.
  * **URL**: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
  * **Username**: Username for connecting to the Microsoft SQL Server DB.
  * **Password**: User password for connecting to the Microsoft SQL Server DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/sqlserver.html).

### TPC-DS connector {#tpc-ds}

The TPC-DS connector has no required settings.

You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/tpcds.html).

### TPC-H connector {#tpc-h}

The TPC-H connector has no required settings.

You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/tpch.html).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
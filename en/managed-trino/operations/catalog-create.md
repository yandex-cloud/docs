---
title: Creating a catalog
description: Follow this guide to create a catalog in a {{ mtr-name }} cluster.
---

# Creating a catalog

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

## Creating a catalog {#create-catalog}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [resource catalog]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Click **{{ ui-key.yacloud.trino.catalogs.create_action }}**.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** field, enter the catalog name.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** field, select the [connector](../concepts/index.md#connector) type.
  1. Configure [catalog settings](#catalog-settings).
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Catalog settings {#catalog-settings}

The catalog settings depend on the connector you select.

### {{ CH }} connector {#ch}

To configure the settings, select the connection type: [Connection Manager](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

{% list tabs %}

- Connection Manager

  * **Connection ID**: Connection ID in Connection Manager for connection to the {{ CH }} cluster.
    
    To find out the connection ID:
      1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

    * `write_buffer_size`: Write buffer size, in bytes. The default value is `buffer_size`. When the buffer is full, the size gets increased to `max_buffer_size`.

    {% endcut %}

  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/clickhouse.html).

- On-premise

  * **URL**: URL for connecting to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
  * **Username**: Username for connecting to the {{ CH }} DB.
  * **Password**: User password for connecting to the {{ CH }} DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/clickhouse.html).

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

### Oracle connector {#oracle}

  * **Connection type**: On-premise.
  * **URL**: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>`. `SID` format, Oracle system ID.
  * **Username**: Username for connecting to the Oracle DB.
  * **Password**: User password for connecting to the Oracle DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/oracle.html).

### {{ PG }} connector {#pg}

To configure the settings, select the connection type: [Connection Manager](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

{% list tabs %}

- Connection Manager

  * **Connection ID**: Connection ID in Connection Manager for connection to the {{ PG }} cluster.

    To find out the connection ID:
      1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

  * **Database**: DB name in the {{ PG }} cluster.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/postgresql.html).

- On-premise

  * **URL**: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
  * **Username**: Username for connecting to the {{ PG }} DB.
  * **Password**: User password for connecting to the {{ PG }} DB.
  * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation](https://trino.io/docs/current/connector/postgresql.html).

{% endlist %}

### Microsoft SQL Server connector {#ms-sql}

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
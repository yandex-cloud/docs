---
title: How to use {{ YZ }} in {{ mgp-full-name }}
description: This guide describes how to use hybrid storage in {{ mgp-name }}.
---

# Using {{ YZ }} in {{ mgp-name }}

The {{ YZ }} extension allows you to use hybrid storage in a {{ mgp-name }} cluster for storing [append-optimized tables](../../concepts/tables.md).

You can [export](#offload-relation) rarely used tables of this type to cold storage and continue working with them as with ordinary tables. You can [upload tables back](#load-relation) to the cluster storage if you need to.

For more information about {{ YZ }} and storage types, see [Hybrid storage](../../concepts/hybrid-storage.md).

## Installing {{ YZ }} in a {{ GP }} cluster {#install-extension}

1. [Enable the hybrid storage option](../update.md#change-additional-settings) if you did not when [creating the cluster](../cluster-create.md).

    {% note warning %}

    You cannot disable this option after you save your cluster settings.

    {% endnote %}

1. [Connect](../connect/index.md) to the database as the owner or a user with the `CREATE` permission and send this request:

    ```sql
    CREATE EXTENSION yezzey;
    ```

1. Make sure the extension has been installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

## Getting a table's location info {#describe-relation}

To learn where a table or its segment files are placed (in cluster storage or cold storage):

1. [Connect](../connect/index.md) to the database as the owner or a user with the `SELECT` permission for the database.

1. Send one of the following requests to find out where the table is:

    * Stating the table name:

        ```sql
        SELECT * FROM yezzey_offload_relation_status('<table_name>');
        ```

    * Stating the schema the table is in and the table name:

        ```sql
        SELECT * FROM yezzey_offload_relation_status('<schema_name>', '<table_name>');
        ```

    You will get information about each segment of the {{ GP }} cluster the table's data resides in.

    The query result contains the following fields:

    | Field | Description |
    |------|----------|
    | `offload_reloid` | OID. |
    | `segindex` | Shard ID. `-1` indicates the master. |
    | `local_bytes` | Size of data in the cluster storage. If `0`, the table is offloaded. |
    | `external_bytes` | Size of data offloaded to cold storage. If all column values are zero, the table is in the cluster storage. If the column contains non-zero values, the table is in the cold storage.|
    | `external_bloat_bytes` | Size of data offloaded to cold storage that is no longer in use but not yet deleted. |

1. Send one of the following requests to learn where the table's segment files are:

    * Stating the table name:

        ```sql
        SELECT * FROM yezzey_offload_relation_status_per_filesegment('<table_name>');
        ```

    * Stating the schema the table is in and the table name:

        ```sql
        SELECT * FROM yezzey_offload_relation_status_per_filesegment('<schema_name>', '<table_name>');
        ```

    You will get information about each of the table's segment files. Review the `external_bytes` column:
    * If all column values are null, the files are in cluster storage.
    * If the column contains values other than null, the files are in cold storage.

## Figuring out how a table is placed in cold storage {#describe-relation-objstorage}

If the table [is in cold storage](#describe-relation), its segment files are stored in a service bucket.

To get info on how the table's segment files are placed in the bucket:

1. [Connect](../connect/index.md) to the database as the owner or a user with the `SELECT` permission for the database.

1. Send one of the following requests:

    * Stating the table name:

        ```sql
        SELECT * FROM yezzey_relation_describe_external_storage_structure('<table_name>');
        ```

    * Stating the schema the table is in and the table name:

        ```sql
        SELECT * FROM yezzey_relation_describe_external_storage_structure('<schema_name>', '<table_name>');
        ```

    The following information will be displayed about each of the table's segment files:

    * `offload_reloid`: Object ID (object identifier, OID) for the table.
    * `segindex`: Segment number.
    * `segfileindex`: Segment file number.
    * `external_storage_filepath`: Path to the segment file in the {{ objstorage-name }} bucket.

        The path to the segment file is generated automatically. It depends on the table structure and the number of segments in the {{ GP }} cluster.

    * `local_bytes` and `local_commited_bytes`: Number of segment file bytes in the cluster storage. The values must be null.
    * `external_bytes`: Segment file size.

## Offloading a table from cluster storage to cold storage {#offload-relation}

If the table is in cluster storage, you can offload it to cold storage. To figure out where the table is, [get its location info](#describe-relation).

{% note info %}

You cannot edit the table while offloading it.

After offloading is completed and the exclusive lock is removed, you will once again be able to edit the table.

{% endnote %}

To offload a table:

1. [Connect](../connect/index.md) to the database as the owner or a user with the `SELECT` permission for the database.

1. Invoke one of the following functions:

    * Stating the table name:

        ```sql
        SELECT yezzey_define_offload_policy('<table_name>');
        ```

    * Stating the schema the table is in and the table name:

        ```sql
        SELECT yezzey_define_offload_policy('<schema_name>', '<table_name>');
        ```

The offloading time depends on the table size and the number of segment files. During the procedure, you will be getting messages that will allow you to track its progress.

* Messages like this one show the size of the segment files offloaded earlier:

    ```bash
    NOTICE:  yezzey: relation virtual size calculated: 0  (segX sliceY ... pid=...)
    ```

    `0` means that no segment files were offloaded earlier (this is the first export).

* Messages like this one indicate that the segment files were successfully offloaded:

    ```bash
    INFO:  yezzey: relation segment reached external storage (blkno=...), up to logical eof ...  (segX sliceY ... pid=...)
    ```

## Loading a table from a cold storage to the cluster storage {#load-relation}

If the table is in cold storage, you can load it to the cluster storage. To figure out where the table is, [get its location info](#describe-relation).

{% note info %}

You cannot edit the table while loading it.

After loading is completed and the exclusive lock is removed, you will once again be able to edit the table.

{% endnote %}

To load a table:

1. [Connect](../connect/index.md) to the database as the owner or a user with the `SELECT` permission for the database.

1. Invoke one of the following functions:

    * Stating the table name:

        ```sql
        SELECT yezzey_load_relation('<table_name>');
        ```

    * Stating the schema the table is in and the table name:

        ```sql
        SELECT yezzey_load_relation('<schema_name>', '<table_name>');
        ```

The loading time depends on the table size and the number of segment files. After the procedure is completed, you will get a message in the following format:

```sql
INFO:  loaded relation ... to local storage
```

## Usage example {#usage-example}

For an example of using the extension to work with hybrid storage, see [{#T}](../../tutorials/yezzey.md).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

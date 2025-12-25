---
title: Managing replication slots in {{ mpg-full-name }}
description: In this tutorial, you will learn how to create and configure a replication slot.
---

# Managing replication slots

{{ mpg-name }} clusters can contain physical and logical replication slots:

* The service automatically creates physical slots for replica hosts and uses them for [data replication](../concepts/replication.md) within the {{ mpg-name }} cluster.
* Logical slots are created by users for [logical data replication](../concepts/replication.md#logical-decoding) across clusters, for example, in CDC (Change Data Capture) scenarios.

For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/logicaldecoding.html).

## Viewing a list of logical replication slots {#list}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication`](../concepts/roles.md#mdb-replication) role.
1. Run the following SQL query:

    ```sql
    SELECT * FROM pg_replication_slots WHERE slot_type='logical';
    ```

    This query outputs a table listing all logical replication slots along with their settings.

## Creating a replication slot {#create}

1. Specify the maximum WAL size for replication in the `Max slot wal keep size` [setting](../concepts/settings-list.md#setting-max-slot-wal-keep-size).

    {% note warning %}

    If this setting’s value is `-1` (unlimited size), inactive logical replication slots will block WAL file cleanup. As a result, the WAL files may consume all available disk space, making your cluster inaccessible.

    {% endnote %}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication` role](../concepts/roles.md#mdb-replication).
1. Run the following SQL query:

    ```sql
    SELECT pg_create_logical_replication_slot
    ( '<slot_name>', '<plugin_name>', <temporary>, <two_phase> )
    ```

    Where:

    * `<slot_name>`: Unique slot name. This is a required parameter.
    * `<plugin_name>`: Name of plugin from the list of supported output plugins. For the full list, see [Replication](../concepts/replication.md#logical-decoding). This is a required parameter.
    * `temporary`: If `true`, the slot will be dropped at the end of the current session or if an error occurs. The default is `false`.
    * `two_phase`: If `true`, the slot will decode the [prepared transactions](https://www.postgresql.org/docs/current/sql-prepare-transaction.html). The default is `false`.

## Dropping a replication slot {#delete}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication` role](../concepts/roles.md#mdb-replication).
1. Run the following SQL query:

    ```sql
    SELECT pg_drop_replication_slot ('<slot_name>');
    ```

## Example {#example}

Create a new `json_slot` replication slot that uses the `wal2json` plugin to stream database changes as JSON:

1. Make sure the [`Max slot wal keep size`](../concepts/settings-list.md#setting-max-slot-wal-keep-size) value is not `-1`.
1. Run the following SQL query:

    ```sql
    SELECT pg_create_logical_replication_slot ( 'json_slot', 'wal2json', false, false );
    ```

    Example response:

    ```sql
    pg_create_logical_replication_slot
    ------------------------------------
    (json_slot,1/92001108)
    (1 row)
    ```

1. Make sure the slot has appeared in the list:

    ```sql
    SELECT * from pg_replication_slots;
    ```

If you no longer need the slot, delete it:

```sql
SELECT pg_drop_replication_slot ('json_slot');
```

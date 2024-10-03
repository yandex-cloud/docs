---
title: Managing replication slots in {{ mpg-full-name }}
description: Follow this guide to create and set up a replication slot.
---

# Managing replication slots

{{ mpg-name }} clusters can contain physical and logical replication slots:

* Physical slots are created automatically based on replica hosts and used for [data replication](../concepts/replication.md) within the {{ mpg-name }} cluster.
* Logical slots are created by users for [logical replication](../concepts/replication.md#logical-decoding) of data across clusters, such as during change data capture (CDC).

For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/logicaldecoding.html).

## Viewing a list of logical replication slots {#list}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication` role](../concepts/roles.md#mdb-replication).
1. Execute the SQL query below:

   ```sql
   SELECT * FROM pg_replication_slots WHERE slot_type='logical';
   ```

   The query returns a table with all logical replication slots and their parameters.

## Creating a replication slot {#create}

1. Set the maximum WAL size for replication in the `Max slot wal keep size` [setting](../concepts/settings-list.md#setting-max-slot-wal-keep-size). The value of this setting can be edited as of {{ PG }} ver. 13.

   {% note warning %}

   If set to `-1` (unlimited size), you will not be able to delete WAL files due to open logical replication slots that information is not read from. As a result, the WAL files will take up the entire disk space and you will not be able to connect to the cluster.

   {% endnote %}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication` role](../concepts/roles.md#mdb-replication).
1. Execute the SQL query below:

   ```sql
   SELECT pg_create_logical_replication_slot
   ( '<slot_name>', '<plugin_name>', <temporary>, <two_phase> )
   ```

   Where:

   * `<slot_name>`: Unique slot name. This is a required parameter.
   * `<plugin_name>`: Name of a plugin from the list of supported output plugins. To view the list, see [Replication](../concepts/replication.md#logical-decoding). This is a required parameter.
   * `temporary`: If `true`, the slot is deleted as soon as the current session is completed or if an error occurs. The default value is `false`.
   * `two_phase`: If `true`, the slot will decode [available transactions](https://www.postgresql.org/docs/current/sql-prepare-transaction.html). The default value is `false`.

## Deleting a replication slot {#delete}

1. [Connect](connect.md) to the database as a user with the [`mdb_replication` role](../concepts/roles.md#mdb-replication).
1. Execute the SQL query below:

   ```sql
   SELECT pg_drop_replication_slot ('<slot_name>');
   ```

## Example {#example}

To create a new replication slot named `json_slot` to decode database changes to JSON format using the `wal2json` plugin:

1. Check that the `Max slot wal keep size` [setting](../concepts/settings-list.md#setting-max-slot-wal-keep-size) value is different from `-1`.
1. Execute the SQL query below:

   ```sql
   SELECT pg_create_logical_replication_slot ( 'json_slot', 'wal2json', false, false );
   ```

   Possible response:

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

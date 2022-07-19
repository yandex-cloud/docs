In this guide, you will learn how to migrate a database from {{ PG }} to {{ CH }} using {{ data-transfer-full-name }}. You will also learn about the particulars of the migration process and how to work with data on the source and target during it. To simplify the process, we'll create all the resources in {{ yandex-cloud }}.

To migrate the database from {{ PG }} to {{ CH }}:

1. [Create a source endpoint](#create-endpoint-source).
1. [Create a target endpoint](#create-endpoint-target).
1. [Create a transfer](#create-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test the replication process](#example-check-replication).
1. [Select the data from the target](#working-with-data-ch).
1. [Purge the deleted data from the target](#cleaning-data).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% list tabs %}

* {{ PG }}

   1. Create a source {{ mpg-full-name }} cluster in any suitable [configuration](../managed-postgresql/concepts/instance-types.md) with the following settings:
      * Database name: `db1`.
      * Username: `user1`.
      * Password: `<password for the source>`.

   1. In the `db1` database on the {{ mpg-full-name }} cluster, create a table named `x_tab`, and populate it with data:

      ```sql
      CREATE TABLE x_tab
      (
          id NUMERIC,
          name CHAR
      );
      CREATE INDEX ON x_tab (id);
      INSERT INTO x_tab (id, name) VALUES
        (40, 'User1'),
        (41, 'User2'),
        (42, 'User3'),
        (43, 'User4'),
        (44, 'User5');
      ```

   1. Create a target {{ mch-full-name }} cluster in any suitable [configuration](../managed-clickhouse/concepts/instance-types.md) with the following settings:
      * Number of {{ CH }} hosts: At least 2 (to enable replication in the cluster).
      * Database name: `db1`.
      * Username: `user1`.
      * Password: `<password for the target>`.

   1. Make sure that the cluster's security groups have been set up correctly and allow connecting to them:
      * [{{ mch-full-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
      * [{{ mpg-full-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups).

{% endlist %}

## Create a source endpoint {#create-endpoint-source}

{% list tabs %}

* {{ PG }}

   [Create a source endpoint](../data-transfer/operations/endpoint/source/postgresql.md) with the `{{ PG }}` type and specify in it parameters for connecting to `db1`.

{% endlist %}

## Create a target endpoint {#create-endpoint-target}

[Create a target endpoint](../data-transfer/operations/endpoint/target/clickhouse.md) with the `{{ CH }}` type.

## Create a transfer {#create-transfer}

[Create a transfer](../data-transfer/operations/transfer.md#create) of the [{{ dt-type-copy-repl }}](../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../data-transfer/operations/transfer.md#activate) and wait for its status to change to **Incremented**.
1. To check that the transfer has moved the replicated data to the target, connect to the target {{ mch-full-name }} cluster and make sure that the `x_tab` table in `db1` includes the same columns as the `x_tab` table in the source database, as well as the [timestamp columns](#working-with-data-ch): `__data_transfer_commit_time` and `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```

   Result:

   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

## Test the replication process {#example-check-replication}

{% list tabs %}

* {{ PG }}

   1. Connect to the source cluster.
   1. Delete one row from the `x_tab` table in the source {{ PG }} database, then update another row there.

      ```sql
      DELETE FROM x_tab WHERE id = 41;
      UPDATE x_tab SET name = 'Key3' WHERE id = 42;
      ```

   1. Make sure that you see the changes in the `x_tab` table on the {{ CH }} target:

      ```sql
      SELECT * FROM db1.x_tab WHERE (id >= 41) AND (id <= 42);
      ```

      Result:

      ```text
      ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
      │ 41 │  User2 │   1633417594957267000          │ 1675417594957267000           │
      │ 42 │  Key3  │   1675417594957267000          │ 0                             │
      │ 42 │  User3 │   1633417594957268000          │ 1675417594957267000           │
      └────┴────────┴────────────────────────────────┴───────────────────────────────┘
      ```

{% endlist %}

## Select the data from {{ CH }} {#working-with-data-ch}.

For table recovery, the {{ CH }} target with [replication](../managed-clickhouse/concepts/replication.md) enabled uses the [ReplicatedReplacingMergeTree](https://clickhouse.tech/docs/ru/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree](https://clickhouse.tech/docs/ru/engines/table-engines/mergetree-family/replacingmergetree/) engines. The following columns are added automatically to each table:

* `__data_transfer_commit_time`: The time allowed for the row to change to this value, in `TIMESTAMP` format.
* `__data_transfer_delete_time`: The time allowed for deleting the row, in `TIMESTAMP` format, if the row has been deleted from the source. If the row hasn't been deleted, the column is populated with `0`.

   The `__data_transfer_commit_time` column is needed for the ReplicatedReplacedMergeTree engine. If a record is deleted or updated, a new row with the value in this column is inserted. The query by a single primary key returns multiple records with different values from the `__data_transfer_commit_time` column.

If the transfer status is **Replicated**, the source data can be added or deleted. To ensure the standard behavior of SQL commands when a primary key points to a single record, add a construction that filters data by the `__data_transfer_delete_time` column to your queries to tables moved to {{ CH }}. For example, for the `x_tab` table:

```sql
SELECT name FROM x_tab FINAL WHERE name LIKE 'User%' AND __data_transfer_delete_time = 0;
```

{% note warning %}

The `FINAL` keyword noticeably decreases the query efficiency. Avoid it when working with large tables whenever possible.

{% endnote %}

## Purge the deleted data from {{ CH }} {#cleaning-data}

If the transfer status changes to **Replicated**, data updates on the source are transferred to the {{ CH }} target as follows:

* New rows are added to replicated tables, with their `__data_transfer_commit_time` and `__data_transfer_delete_time` columns specifying the date and time when these rows were deleted or updated in the source.
* The existing rows with previous values are not deleted.

When you update data in the source, the update history is accumulated in the {{ CH }} target, which leads to over consumption of disk space. Because of this, during replications, make sure to purge the {{ CH }} target of rows storing the history of data updates in the source, from time to time:

1. Execute the query to delete records:

   ```sql
   DELETE FROM db1.x_tab WHERE id IN (
       SELECT id FROM db1.x_tab FINAL WHERE __data_transfer_delete_time != 0
   );
   ```

1. Run an unscheduled JOIN for table rows:

   ```sql
   OPTIMIZE TABLE db1.x_tab FINAL;
   ```

Repeat the purge after the transfer is complete.

{% note info %}

The purge is needed only for _{{ dt-type-copy-repl }}_ and _{{ dt-type-repl }}_ transfers.

{% endnote %}

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

* [Deactivate the transfer](../data-transfer/operations/transfer.md#deactivate) and wait its status to change to **Stopped**.
* [Delete](../data-transfer/operations/transfer.md#delete) the stopped transfer.
* [Delete the source endpoint and the target endpoint](../data-transfer/operations/endpoint/index.md#delete).

If the source or target cluster is hosted by a managed database service, delete them:

* [Delete a {{ mch-full-name }} cluster](../managed-clickhouse/operations/cluster-delete.md).
* [Delete a {{ mpg-full-name }} cluster](../managed-postgresql/operations/cluster-delete.md).

# Managing tables and directories

This section describes how to create, edit, or delete tables and directories using the cloud management console.

To create a table, you need a [database](../operations/).

## Creating a table {#create-table}

You can create a {{ ydb-short-name }} table or a [document table](../concepts/dynamodb-tables.md).

{% list tabs %}

- {{ ydb-short-name }} table

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to create a table in.
   1. Choose **Create** → **Table** on the right of the page.
   1. Configure the table settings:
      * The table **name**. Must be unique within the database.
      * Table **type**: {{ ydb-short-name }} table.
   1. Add columns:
      * Column **name**. Must be unique within the table.
      * Column data **type**. Regardless of the data type, each column may contain a `NULL` value.
      * **Primary key**. Specify whether the column is part of the primary key. Primary indexes are automatically created based on the primary key.
   1. Set up [secondary indexes](https://ydb.tech/en/docs/concepts/secondary_indexes) if needed.
      * Secondary index **name**. Must be unique within the table.
      * **Key**: One or more columns that make up a key for creating a secondary index.
   1. Set up the [partitioning](https://ydb.tech/en/docs/concepts/datamodel) policy.
      * **No**: The table is not partitioned.
      * **Evenly**: The entire range of values of Uint32 or Uint64 key columns (from 0 to the maximum value) is split into same-length intervals. When using this policy, set the number of intervals in the **Quantity** field.
      * **Explicitly**: Lets you explicitly specify values for keys that will act as boundaries for the initial partitioning of the table. To add another boundary value, click **Add split point**.
   1. Configure automatic partitioning:
      * **By size**: If enabled, a partition is split into two when a certain data size is reached.
      * **By load**: If enabled, a partition is split into two if it is under high loads for a certain period of time (uses a lot of CPU time).
   1. Configure advanced table settings:
      * **Autopartition by size MBs**: Threshold data size at which auto partitioning by size is triggered.
      * **Min partitions**: The number of partitions in the table below which no partition merge by size or load is performed.
      * **Max partitions**: The number of partitions in the table above which no splitting by size or load is performed.
      * **Key bloom filter**: If enabled, applies the [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by a key. In some cases, it can speed up key reads.
   1. Click **Create table**.

   To create {{ ydb-short-name }} tables, you can also use the [`CREATE TABLE`](https://ydb.tech/en/docs/yql/reference/syntax/create_table) command based on the [YQL](https://ydb.tech/en/docs/yql/reference/) query language.

- Document table

   {% note info %}

   Document tables are only available in {{ ydb-name }} serverless mode.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to create a table in.
   1. Choose **Create** → **Table** on the right of the page.
   1. Configure the table settings:
      * The table **name**. Must be unique within the database.
      * **Type** of table: Document table.
   1. Add columns:
      * Column **name**. Must be unique within the table.
      * Column data **type**. Regardless of the data type, each column may contain a `NULL` value.
      * **Partition key**: A simple primary key that consists of a single attribute. {{ ydb-short-name }} uses the partition key value as an input for the internal hashing function. The result of calculating the hash function determines the partition where the item will be stored.
      * **Sort key**. A primary key can be composite and consist of a partition key and a sort key. All items with the same partition key will be stored together, in sorted order by the sort key value. If a partition key and a sort key are specified in a document table, two elements may contain the same value for the partition key, but must contain different values for the sort key.
   1. Click **Create table**.

{% endlist %}

## Changing the table structure {#alter-table}

In the {{ ydb-short-name }} cloud console, you can add non-key columns to a table and change its automatic partitioning settings.

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
1. Select the database to update a table in.
1. Locate the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **Change**.
1. Add new columns to the table and specify their parameters:
   * Column **name**. Must be unique within the table.
   * Column data **type**. Regardless of the data type, each column may contain a NULL value.
1. To delete non-key columns from the table, click ![image](../../_assets/cross.svg)in the appropriate line. You cannot delete columns that make up a primary key.
1. Configure automatic partitioning:
   * **By size**: If enabled, a partition is split into two when a certain data size is reached.
   * **By load**: If enabled, a partition is split into two if it is under high loads for a certain period of time (uses a lot of CPU time).
1. Configure advanced table settings:
   * **Autopartition by size MBs**: Threshold data size at which auto partitioning by size is triggered.
   * **Min partitions**: The number of partitions in the table below which no partition merge by size or load is performed.
   * **Max partitions**: The number of partitions in the table above which no splitting by size or load is performed.
   * **Key bloom filter**: If enabled, applies the [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by a key. In some cases, it can speed up key reads.
1. Click **Edit table**.

To alter {{ ydb-short-name }} tables, you can also use the [`ALTER TABLE`](https://ydb.tech/en/docs/yql/reference/syntax/alter_table) command from the [YQL](https://ydb.tech/en/docs/yql/reference/) query language.

## Deleting tables {#drop-table}

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
1. Select the database to delete a table from.
1. Locate the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **Delete**.
1. Confirm the deletion.

To drop {{ ydb-short-name }} tables, you can use the [`DROP TABLE`](https://ydb.tech/en/docs/yql/reference/syntax/drop_table) command based on the [YQL](https://ydb.tech/en/docs/yql/reference/) query language.

## Creating and deleting directories {#directories}

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
1. Select the database to create a directory in.
1. Choose **Create** → **Directory** on the right of the page.
1. Enter the directory name and click **Create directory**.
---
sourcePath: en/ydb/overlay/operations/schema.md
---
# Managing tables

Learn how to create, edit, or delete a table. To create a table, you need a [database](create_manage_database#create-db.md).

## Creating a table {#create-table}

{% list tabs %}

- Management console

   You can create two types of tables:

   * A YDB table is a relational table with a primary key index. It is always ordered by primary key.

   * A document table is a table type compatible with Amazon DynamoDB. This type of table is only available in {{ ydb-name }} serverless mode.

     A document table contains data represented as a set of items. Each item is a set of attributes. An attribute is a data unit represented in a document table as a key-value pair. Attributes are much like columns in relational tables. When creating a document table, you must specify a primary key that serves as a unique identifier for table items. A primary key is a set of attributes. All table items must contain attributes that are part of the table's primary key. Except for the primary key, items may contain arbitrary attributes of arbitrary types.

   **Creating YDB tables**
   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to create a table in.
   1. Choose **Create** → **Table** on the right of the page.
   1. Configure the table settings:
      * **Name** of the table. Must be unique within the database.
      * **Type** of the table: YDB table.
   1. Add columns:
      * **Column name**. Must be unique within the table.
      * **Column data type**. Regardless of the data type, each column may contain a NULL value.
      * **Primary key**. Specify whether the column is part of the primary key. Primary indexes are automatically created based on the primary key.
   1. If necessary, set up [secondary indexes](../concepts/secondary_indexes.md):
      * **Secondary index name**. Must be unique within the table.
      * **Key**: One or more columns that make up a key for creating a secondary index.
   1. Configure the [partitioning](../concepts/datamodel.md#partitioning) policy:
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
      * **Key bloom filter**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
   1. Click **Create table**.

   **Creating document tables**

   {% note info %}

   Document tables are only available in {{ ydb-name }} serverless mode.

   {% endnote %}
   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to create a table in.
   1. Choose **Create** → **Table** on the right of the page.
   1. Configure the table settings:
      * **Name** of the table. Must be unique within the database.
      * **Type** of table: Document table.
   1. Add columns:
      * **Column name**. Must be unique within the table.
      * **Column data type**. Regardless of the data type, each column may contain a NULL value.
      * **Partition key** is a simple primary key that consists of a single attribute. YDB uses the partition key value as input for the internal hashing function. The result of calculating the hash function determines the partition where the item will be stored.
      * **Sort key**. A primary key can be composite and consist of a partition key and a sort key. All items with the same partition key will be stored together, in sorted order by the sort key value. If a partition key and a sort key are specified in a document table, two elements may contain the same value for the partition key, but must contain different values for the sort key.
   1. Click **Create table**.

- SQL

   To create a table, specify:
   1. Table name.
   1. Names and data types for each column.
   1. Columns that make up a primary key. YDB tables require a primary key.

   {{ ydb-short-name }} tables have the following characteristics:
   * Each column may contain a NULL value.
   * If you try to create a table with an existing name, no action is taken.
   * Primary indexes are based on the primary key. They are unique and created automatically.

   For more information about the {{ ydb-short-name }} data model and schema, see [Data model and schema](../concepts/datamodel.md). Read more about supported data types in [Data types](../concepts/datatypes.md).

   The [CREATE TABLE](../yql/reference/syntax/create_table.md) statement creates a table with the specified parameters:

   {%include [create-new-table-3-columns](../_includes/queries/create-new-table-3-columns.md) %}

   As a result, a simple ```series``` table is created with the ```series_id```, ```title```, ```series_info```, and ```release_date``` columns. The ```series_id``` column is the primary key of the table. The ```seasons``` and ```episodes``` tables are described the same way.

   {% note info %}

   For more information about how to add secondary indexes when creating a table, see the [YQL documentation](../yql/reference/syntax/create_table.md#si-add).

   {% endnote %}

{% endlist %}

## Changing the table structure {#alter-table}

In {{ ydb-short-name }}, you can add non-key columns to a table and change its automatic partitioning settings.

{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to update a table in.
   1. Locate the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **Change**.
   1. Add new columns to the table and specify their parameters:
      * **Column name**. Must be unique within the table.
      * **Column data type**. Regardless of the data type, each column may contain a NULL value.
   1. To delete non-key columns from the table, click ![image](../../_assets/cross.svg) in the appropriate line. You can't delete columns that make up a primary key.
   1. Configure auto partitioning:
      * **By size**: If enabled, a partition is split into two when a certain data size is reached.
      * **By load**: If enabled, a partition is split into two if it is under high loads for a certain period of time (uses a lot of CPU time).
   1. Configure advanced table settings:
      * **Autopartition by size MBs**: Threshold data size at which auto partitioning by size is triggered.
      * **Min partitions**: The number of partitions in the table below which no partition merge by size or load is performed.
      * **Max partitions**: The number of partitions in the table above which no splitting by size or load is performed.
      * **Key bloom filter**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
   1. Click **Edit table**.

- SQL

   ADD COLUMN adds a column with the specified name and type. The code below adds the ```is_deleted``` column with the ```Bool``` data type to the ```episodes``` table.

   ```sql
   ALTER TABLE episodes ADD COLUMN is_deleted Bool;
   ```

   DROP COLUMN deletes the column with the specified name. The code below removes the ```is_deleted``` column from the ```episodes``` table.

   ```sql
   ALTER TABLE episodes DROP COLUMN is_deleted;
   ```

{% endlist %}

## Deleting tables {#drop-table}

{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to delete a table from.
   1. Locate the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **Delete**.
   1. Confirm the deletion.

- SQL

   DROP TABLE deletes the specified table. If there is no such table, an error is returned. The code below returns the ```Table not found``` error, since we didn't create an *actors* table yet.

   ```sql
   DROP TABLE actors;
   ```

{% endlist %}

## Creating and deleting directories {#directories}

{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ydb-name }}**.
   1. Select the database to create a directory in.
   1. Choose **Create** → **Directory** on the right of the page.
   1. Enter the directory name and click **Create directory**.

- SDK

   [The YDB SDK](../reference/ydb-sdk/index.md) provides methods for creating, deleting, listing, and viewing directory information. The table below shows the names of methods for different programming languages.

   | Method    | Java | Python | Go |
| ---- | ---- | ---- | ---- |
| Create a directory | ```SchemeClient.makeDirectory``` | ```scheme_client.make_directory``` | ```Client.MakeDirectory``` |
| Delete a directory | ```SchemeClient.removeDirectory``` | ```scheme_client.remove_directory``` | ```Client.RemoveDirectory``` |
| View directory details |```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` |  ```Client.DescribePath``` |
| View directory details | ```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` |  ```Client.DescribePath``` |
| View directory details |```SchemeClient.describePath``` | ```SchemeClient.describeDirectory``` |  ```Client.DescribePath``` |
| List a directory  | ```scheme_client.describe_path``` | ```SchemeClient.list_directory``` | ```Client.ListDirectory``` |

{% endlist %}


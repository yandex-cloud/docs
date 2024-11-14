# Managing tables and directories

This section describes how to manage row-oriented and document tables as well as directories using the cloud management console or [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).

The following operations are possible:
* [Creating a table](#create-table)
* [Changing the table structure](#alter-table)
* [Deleting a table](#drop-table)
* [Creating and deleting directories](#directories)

To work with tables and directories, you will need a [database](../operations/).

## Creating a table {#create-table}

You can create a row-oriented table or a [document table](../concepts/dynamodb-tables.md).

### Row-oriented table {#create-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create a table in.
  1. Go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. Choose **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table settings:
     * Table **{{ ui-key.yacloud.ydb.table.form.field_name }}**. Must be unique within the database.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_row-table }}`.
  1. Add columns:
     * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}**. Must be unique within the table.
     * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
     * **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**. Specify whether the column is part of the primary key. Primary indexes are automatically created based on the primary key.
  1. If necessary, set up [secondary indexes]({{ ydb.docs }}/concepts/secondary_indexes):
     * Secondary index **{{ ui-key.yacloud.ydb.table.form.column_name }}**. Must be unique within the table.
     * **{{ ui-key.yacloud.ydb.table.form.column_index-key }}**: One or more columns that make up a key for creating a secondary index.
  1. Configure the [partitioning]({{ ydb.docs }}/concepts/datamodel) policy:
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-none }}`: The table is not partitioned.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-uniform }}`: The entire range of values of Uint32 or Uint64 key columns (from 0 to the maximum value) is split into same-length intervals. When using this policy, set the number of intervals in the **{{ ui-key.yacloud.ydb.table.form.field_uniform-partitions }}** field.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-explicit }}`: Lets you explicitly specify values for keys that will act as boundaries for the initial partitioning of the table. To add another boundary value, click **{{ ui-key.yacloud.ydb.table.form.button_add-split-point }}**.
  1. Configure automatic partitioning:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}**: If enabled, a partition is split into two when a certain data size is reached.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}**: If enabled, a partition is split into two if it is under high loads for a certain period of time (uses a lot of CPU time).
  1. Configure advanced table settings:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}**: Threshold data size at which auto partitioning by size is triggered.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}**: Number of partitions in the table below which no partition merge by size or load is performed.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}**: Number of partitions in the table above which no splitting by size or load is performed.
     * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

  To create row-oriented tables, you can also use the [`CREATE TABLE`]({{ ydb.docs }}/yql/reference/syntax/create_table) [YQL]({{ ydb.docs }}/yql/reference/) command.


- {{ TF }} {#tf}

   To learn how to create a row-oriented table using {{ TF }}, see [{#T}](../terraform/row-tables.md).

{% endlist %}

### Document table {#create-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  Document tables are only available in {{ ydb-name }} serverless mode.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create a table in.
  1. Choose **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table settings:
     * Table **{{ ui-key.yacloud.ydb.table.form.field_name }}**. Must be unique within the database.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_document-table }}`.
  1. Add columns:
     * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}**. Must be unique within the table.
     * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
     * **{{ ui-key.yacloud.ydb.table.form.column_shard }}**: Simple primary key that consists of one attribute. {{ ydb-short-name }} uses the partition key value as an input for the internal hashing function. The result of calculating the hash function determines the partition where the item will be stored.
     * **{{ ui-key.yacloud.ydb.table.form.column_sort }}**. A primary key can be composite and consist of a partition key and a sort key. All items with the same partition key will be stored together, in sorted order by the sort key value. If a partition key and a sort key are specified in a document table, two elements may contain the same value for the partition key, but must contain different values for the sort key.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

- {{ TF }} {#tf}

   To learn how to create a document table using {{ TF }}, see [{#T}](../terraform/dynamodb-tables.md).

{% endlist %}


## Changing the table structure {#alter-table}

### Row-oriented table {#alter-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

   In the {{ ydb-short-name }} cloud console, you can add non-key columns to a table and change its automatic partitioning settings.

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to update a table in.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_edit }}**.
   1. Add new columns to the table and specify their parameters:
      * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}**. Must be unique within the table.
      * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
   1. To delete non-key columns from the table, click ![image](../../_assets/cross.svg) in the appropriate line. You cannot delete columns that make up a primary key.
   1. Configure automatic partitioning:
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}**: If enabled, a partition is split into two when a certain data size is reached.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}**: If enabled, a partition is split into two if it is under high loads for a certain period of time (uses a lot of CPU time).
   1. Configure advanced table settings:
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}**: Threshold data size at which auto partitioning by size is triggered.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}**: Number of partitions in the table below which no partition merge by size or load is performed.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}**: Number of partitions in the table above which no splitting by size or load is performed.
      * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
   1. Click **{{ ui-key.yacloud.ydb.table.edit.button_update }}**.

- {{ TF }} {#tf}

   See [{#T}](../terraform/row-tables.md) for the description of the table entities that you can change using {{ TF }}.

{% endlist %}

### Document table {#alter-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}

   Currently, only adding new rows to a table is supported, while the preview is disabled in the management console.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to update a table in.
   1. Find the table in the list and click it.
   1. Click **Add row**.
   1. Enter the values for the columns listed in the form, then click **Add**.

- {{ TF }} {#tf}

   See [{#T}](../terraform/dynamodb-tables.md) for the description of the table entities that you can change using {{ TF }}.

{% endlist %}

To edit row-oriented tables, you can also use the [`ALTER TABLE`]({{ ydb.docs }}/yql/reference/syntax/alter_table) [YQL]({{ ydb.docs }}/yql/reference/) command.

## Deleting a table {#drop-table}

### Row-oriented table {#drop-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to delete a table from.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
   1. Confirm the deletion.

- {{ TF }} {#tf}

   To delete a row-oriented table, delete the `yandex_ydb_table` resource.

{% endlist %}

### Document table {#drop-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Go to the database to delete a document table from.
   1. Select a document table from the list of tables, then click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
   1. Confirm the deletion.

- {{ TF }} {#tf}

   To delete a document table, delete the `aws_dynamodb_table` resource.

{% endlist %}


To edit row-oriented tables, you can also use the [`DROP TABLE`]({{ ydb.docs }}/yql/reference/syntax/drop_table) [YQL]({{ ydb.docs }}/yql/reference/) command.

## Creating and deleting directories {#directories}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create a directory in.
  1. Choose **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_directory }}** on the right side of the page.
  1. Enter the directory name and click **{{ ui-key.yacloud.ydb.browse.dialogs.button_create-directory }}**.

{% endlist %}
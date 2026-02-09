# Managing tables and directories

This section describes how to manage row-oriented and document tables as well as directories using the cloud management console or [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).

You can do the following:
* [Create a table](#create-table).
* [Change the table schema](#alter-table).
* [Delete a table](#drop-table).
* [Create and delete directories](#directories).

To work with tables and directories, you will need a [database](../operations/).

## Creating a table {#create-table}

You can create a row-oriented table or a [document table](../concepts/dynamodb-tables.md).

### Row-oriented table {#create-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create your table in.
  1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. Select **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table:
     * Table **{{ ui-key.yacloud.ydb.table.form.field_name }}** must be unique within the database.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_row-table }}`.
  1. Add columns:
     * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
     * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
     * **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**. Specify whether the column is part of the primary key. Primary indexes are automatically created based on the primary key.
  1. Set up [secondary indexes]({{ ydb.docs }}/concepts/secondary_indexes), if needed:
     * Secondary index **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
     * **{{ ui-key.yacloud.ydb.table.form.column_index-key }}**: One or more columns that make up a key for creating a secondary index.
  1. Configure the [partitioning]({{ ydb.docs }}/concepts/datamodel) policy:
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-none }}`: The table is not partitioned.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-uniform }}`: The entire range of values of Uint32 or Uint64 key columns (from 0 to the maximum value) is split into same-length partitions. When using this policy, set the number of partitions in the **{{ ui-key.yacloud.ydb.table.form.field_uniform-partitions }}** field.
     * `{{ ui-key.yacloud.ydb.table.form.value_partitions-explicit }}`: Allows you to explicitly specify values for keys that will act as split points for initial table partitioning. To add another split point, click **{{ ui-key.yacloud.ydb.table.form.button_add-split-point }}**.
  1. Configure automatic partitioning:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}**: If enabled, a partition is split into two when it reaches a certain data size.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}**: If enabled, a partition is split into two if it receives high throughput (uses a lot of CPU time) for a certain period of time.
  1. Specify advanced table settings:
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}**: Data size threshold that triggers auto-partitioning by size.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}**: Number of partitions in the table below which no partitions are merged by size or load.
     * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}**: Number of partitions in the table above which no partitions are split by size or load.
     * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

  To create row-oriented tables, you can also use the [`CREATE TABLE`]({{ ydb.docs }}/yql/reference/syntax/create_table) command.


- {{ TF }} {#tf}

   To learn how to create a row-oriented table using {{ TF }}, see [{#T}](../terraform/tables.md).

{% endlist %}

### Document table {#create-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  Document tables are only available in {{ ydb-name }} serverless mode.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create your table in.
  1. Select **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table:
     * Table **{{ ui-key.yacloud.ydb.table.form.field_name }}** must be unique within the database.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_document-table }}`.
  1. Add columns:
     * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
     * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
     * **{{ ui-key.yacloud.ydb.table.form.column_shard }}**: Simple primary key that consists of one attribute. {{ ydb-short-name }} uses a partition key as an input for internal hashing. The hashing function result determines the partition the element will be stored in.
     * **{{ ui-key.yacloud.ydb.table.form.column_sort }}**. A primary key can be composite and consist of a partition key and a sort key. All elements sharing the partition key will be stored together and sorted according to their sort key value. In a document table that has both a partition key and a sort key, any two elements may share the partition key value but must have different sort key values.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

- {{ TF }} {#tf}

   You can learn how to create a document table using {{ TF }} in [{#T}](../terraform/dynamodb-tables.md).

{% endlist %}

### Column-oriented table {#create-column-table}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create your table in.
  1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. Select **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** on the right side of the page.
  1. Configure the table:
     * Table **{{ ui-key.yacloud.ydb.table.form.field_name }}** must be unique within the database.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: `{{ ui-key.yacloud.ydb.table.form.label_column-table }}`.
  1. Add columns:
     * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
     * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**.
     * **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**. Specify whether the column is part of the primary key. Primary indexes are automatically created based on the primary key.

        {% note info %}

        The column order in the primary key depends on the column order in the table you are creating.

        {% endnote %}

     * **{{ ui-key.yacloud.ydb.table.form.column_not-null}}**. Specify whether the column may contain a `NULL` value.
     <!-- * **{{ ui-key.yacloud.ydb.table.form.column_default}}**. Specify a default value for the column. -->
  1. Configure the table TTL parameters:
     * **{{ ui-key.yacloud.ydb.table.form.field_ttl-column}}**. Select the column whose value will be used to calculate the lifetime of rows.
     * **{{ ui-key.yacloud.ydb.table.form.field_ttl-lifetime}}**. Specify the lifetime of table rows.
     * **{{ ui-key.yacloud.ydb.table.form.field_ttl-unit}}**. Select the measurement unit for the table row lifetime you specified.
  1. Configure partitioning:
     * **{{ ui-key.yacloud.ydb.table.form.field_partition-key }}**: Specify the column to split the table by.
     * **{{ ui-key.yacloud.ydb.table.form.field_partition-count }}**: Specify the number of partitions for the table.
  1. Click **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

  To create column-oriented tables, you can also use the [`CREATE TABLE`]({{ ydb.docs }}/yql/reference/syntax/create_table) command.


- {{ TF }} {#tf}

   You can learn how to create a column-oriented table using {{ TF }} in [{#T}](../terraform/tables.md).

{% endlist %}

## Changing the table schema {#alter-table}

### Row-oriented table {#alter-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

   In the {{ ydb-short-name }} cloud console, you can add non-key columns to a table and change its automatic partitioning settings.

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to update a table in.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_edit }}**.
   1. Add new columns to the table and specify their parameters:
      * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
      * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
   1. To delete non-key columns from the table, click ![image](../../_assets/cross.svg) in the relevant row. You cannot delete columns that make up a primary key.
   1. Configure automatic partitioning:
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size }}**: If enabled, a partition is split into two when it reaches a certain data size.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-load }}**: If enabled, a partition is split into two if it receives high throughput (uses a lot of CPU time) for a certain period of time.
   1. Specify advanced table settings:
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-by-size-mb }}**: Data size threshold that triggers auto-partitioning by size.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-min }}**: Number of partitions in the table below which no partitions are merged by size or load.
      * **{{ ui-key.yacloud.ydb.table.form.field_autopartition-max }}**: Number of partitions in the table above which no partitions are split by size or load.
      * **{{ ui-key.yacloud.ydb.table.form.field_key-bloom-filter }}**: If enabled, YDB uses a [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) to search data by key. In some cases, it can speed up key reads.
   1. Click **{{ ui-key.yacloud.ydb.table.edit.button_update }}**.

- {{ TF }} {#tf}

   Learn more about the table entities you can change using {{ TF }} in [{#T}](../terraform/tables.md).

{% endlist %}

### Document table {#alter-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

   {% note info %}

   Currently, you can only add new rows to a table, without any preview in the management console.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to update a table in.
   1. Find the table in the list and click it.
   1. Click **Add row**.
   1. Enter the values for the columns listed in the form, then click **Add**.

- {{ TF }} {#tf}

   Learn more about the table entities you can change using {{ TF }} in [{#T}](../terraform/dynamodb-tables.md).

{% endlist %}

To edit row-oriented tables, you can also use the [`ALTER TABLE`]({{ ydb.docs }}/yql/reference/syntax/alter_table) command.

### Column-oriented table {#alter-column-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to update a table in.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_edit }}**.

        Update the table schema as needed. You can do the following:

        -  Add new columns to the table and specify their parameters:
            * Column **{{ ui-key.yacloud.ydb.table.form.column_name }}** must be unique within the table.
            * Column data **{{ ui-key.yacloud.ydb.table.form.column_type }}**. Regardless of the data type, each column may contain a `NULL` value.
        -  To delete non-key columns from the table, click ![image](../../_assets/cross.svg) in the relevant row. You cannot delete columns that make up a primary key.
        -  Configure the table TTL parameters:
            * **{{ ui-key.yacloud.ydb.table.form.field_ttl-column}}**. Select the column whose value will be used to calculate the lifetime of rows.
            * **{{ ui-key.yacloud.ydb.table.form.field_ttl-lifetime}}**. Specify the lifetime of table rows.
            * **{{ ui-key.yacloud.ydb.table.form.field_ttl-unit}}**. Select the measurement unit for the table row lifetime you specified.

   1. Click **{{ ui-key.yacloud.ydb.table.edit.button_update }}**.

  To update column-oriented tables, you can also use the [`ALTER TABLE`]({{ ydb.docs }}/yql/reference/syntax/alter_table) command.


- {{ TF }} {#tf}

   Learn more about the table entities you can change using {{ TF }} in [{#T}](../terraform/tables.md).

   {% note info %}

   Updating the `store` and `partition_by` parameters of the column-oriented table will result in recreating the table.

   {% endnote %}

{% endlist %}

## Deleting a table {#drop-table}

### Row-oriented table {#drop-ydb-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to delete your table from.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
   1. Confirm the deletion.

- {{ TF }} {#tf}

   To delete a row-oriented table, delete the `yandex_ydb_table` resource.

{% endlist %}

### Document table {#drop-dynamodb-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Navigate to the database to delete your document table from.
   1. Select the document table from the list, then click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
   1. Confirm the deletion.

- {{ TF }} {#tf}

   To delete a document table, delete the `aws_dynamodb_table` resource.

{% endlist %}

### Column-oriented table {#drop-ydb-column-table}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder page.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the database to delete your table from.
   1. Find the table in the list and select ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.ydb.constants.menu_delete }}**.
   1. Confirm the deletion.

- {{ TF }} {#tf}

   To delete a column-oriented table, delete the `yandex_ydb_table` resource.

{% endlist %}

To delete tables, you can also use the [`DROP TABLE`]({{ ydb.docs }}/yql/reference/syntax/drop_table) command.

## Creating and deleting directories {#directories}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database to create a directory in.
  1. Select **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_directory }}** on the right side of the page.
  1. Enter a name for your directory and click **{{ ui-key.yacloud.ydb.browse.dialogs.button_create-directory }}**.

{% endlist %}

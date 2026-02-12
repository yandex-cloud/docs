# Reading data from {{ yq-iceberg-name }} tables

This section provides basic information about using {{ yq-iceberg-name }} tables.

To read data from an {{ yq-iceberg-name }} table located in {{ objstorage-full-name }}, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing the details for connection to an {{ yq-iceberg-name }} folder.
1. [Run a query](#query) to the table of interest from the folder.

Example of query for reading data from an {{ yq-iceberg-name }} table:

```
SELECT * FROM iceberg_connection.my_table
```

Where:

* `iceberg_connection`: Name of the your new connection to the {{ yq-iceberg-name }} folder.
* `my_table`: Name of your table in the {{ yq-iceberg-name }} folder.

## Setting up a connection {#create_connection}

To create a connection with an {{ yq-iceberg-name }} folder:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of your connection with the {{ yq-iceberg-name }} folder.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: {{ yq-iceberg-name }}.
  
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: Select `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}` depending on the type of the bucket object read permissions.

        For a public bucket, enter a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
        For a private bucket:
        * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
        * Select a bucket or create a new one.
        * Select or create a [service account](../../iam/concepts/users/service-accounts.md) with the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role you will use to access the data.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}
      * **{{ ui-key.yql.yq-connection-form.description_iceberg-directory }}**: Directory with the Hadoop folder in the selected bucket.

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Query syntax {#query}

To work with {{ yq-iceberg-name }} tables, the following SQL query form is used:

```
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Name of the new connection with the folder.
* `<table_name>`: {{ yq-iceberg-name }} table name from the folder.

## Limitations

{{ yq-iceberg-name }} tables are subject to some limitations.
* You can only query tables created as per [version 1](https://iceberg.apache.org/spec/#version-1-analytic-data-tables) of the {{ yq-iceberg-name }} specification.
* You can only read tables from the Hadoop folder located in {{ objstorage-full-name }}.
* You cannot read previous table states (snapshots) (time travel).

## Supported data types

List of supported {{yq-iceberg-name}} data types and corresponding {{ yql-short-name }} types.

| Data type {{ yq-iceberg-name }} | Data type {{ yq-full-name }} |
| :---: | :---: | 
| `boolean` | `Bool` |
| `int` | `Int32` |
| `long` | `Int64` |
| `float` | `Float` |
| `double` | `Double` |
| `date` | `Date` |
| `time` | `Utf8` |
| `timestamp` | `Utf8` |
| `string` | `Utf8` |
| `binary` | `String` |

## Significant data pruning

A query to the {{ yq-iceberg-name }} table may contain filters built based on the WHERE expression. These filters are used to reduce the amount of data that needs to be processed. This reduction procedure is called data _pruning_.

Pruning is done both when planning the read operation and when reading.

When planning:
* Reading the {{ yq-iceberg-name }} table metadata.
* Listing the data files to read (based on statistics from metadata).
* Providing the files selected for reading.

When reading: 
* Splitting data files into row groups.
* Reading statistics for row groups.
* Listing the groups to read (based on statistics).
* Reading data from selected groups. 

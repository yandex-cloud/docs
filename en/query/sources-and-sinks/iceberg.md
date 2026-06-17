# Reading data from {{ yq-iceberg-name }} tables

This section covers the basics of working with {{ yq-iceberg-name }} tables.

To read data from an {{ yq-iceberg-name }} table located in {{ objstorage-full-name }}, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your access credentials for an {{ yq-iceberg-name }} catalog.
1. [Run a query](#query) against the required table in the catalog.

Query example for reading data from an {{ yq-iceberg-name }} table:

```
SELECT * FROM iceberg_connection.my_table
```

Where:

* `iceberg_connection`: {{ yq-iceberg-name }} catalog connection name.
* `my_table`: {{ yq-iceberg-name }} table name.

## Setting up a connection {#create_connection}

To create a connection to the {{ yq-iceberg-name }} catalog:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: {{ yq-iceberg-name }} catalog connection name.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: {{ yq-iceberg-name }}.
  
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: Select `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}` depending on the type of read access to objects in the bucket.

        For a public bucket, specify a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
        For a private bucket:
        * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
        * Select an existing bucket or create a new one.
        * Select an existing [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`storage.viewer`](../../storage/security/index.md#storage-viewer) role required to access the data.

          {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}
      * **{{ ui-key.yql.yq-connection-form.description_iceberg-directory }}**: Directory containing the Hadoop directory inside the selected bucket.

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Query syntax {#query}

{{ yq-iceberg-name }} uses the following SQL syntax:

```
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Catalog connection name.
* `<table_name>`: {{ yq-iceberg-name }} table name.

## Limitations

Working with {{ yq-iceberg-name }} tables comes with certain limitations.
* You can only query tables that were created as per [version 1](https://iceberg.apache.org/spec/#version-1-analytic-data-tables) of the {{ yq-iceberg-name }} specification.
* You can only read tables from the Hadoop directory located in {{ objstorage-full-name }}.
* Table time travel, i.e., reading previous table snapshots, is not supported.

## Supported data types

The list of supported {{ yq-iceberg-name }} data types and their corresponding {{ yql-short-name }} types.

| {{ yq-iceberg-name }} data type | {{ yq-full-name }} data type |
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

## Pruning

A query against an {{ yq-iceberg-name }} table may contain filters built using a WHERE expression. These filters reduce the volume of data for processing. Such a reduction procedure is called _pruning_.

Pruning is performed both at the read planning stage and at the reading stage.

At the read planning stage, the system:
* Reads the {{ yq-iceberg-name }} table metadata.
* Uses metadata statistics to determine the list of data files to be read.
* Provides the selected files for reading.

At the reading stage, the system: 
* Splits data files into row groups.
* Reads row group statistics.
* Uses the statistics to determine which row groups need to be read.
* Reads data from the selected groups. 

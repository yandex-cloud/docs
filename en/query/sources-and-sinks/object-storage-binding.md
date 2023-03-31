# Reading data from {{ objstorage-name }} using {{ yq-name }} bindings

There are cases when you need to run the same data queries on a regular basis. To avoid entering all the details of handling this data each time you make a query, you can use bindings.

Sample data read query using bindings:

```sql
SELECT
    *
FROM
    bindings.`logs`
WHERE
    version>1
```

## Setting up a data binding {#binding-settings}

To create a binding to read data from {{ objstorage-short-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a binding.
1. In the list of services, select **{{ yq-full-name }}**.
1. In the left panel, go to the **Bindings** tab.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Under **Connection parameters**:

   1. In the **Type** field, select `{{ objstorage-short-name }}`.
   1. In the **Connection** field, select a connection or [create a new one](./object-storage.md#create_connection):

1. Under **Data binding parameters**:

   1. Give your a binding a name in the **Name** field.
   1. In the **Path** field, specify the [path to bucket data](object-storage.md#path_format). Parts of file names can be specified using `/*`, such as `yellow/*.csv`.
   1. Specify the [data compression](formats.md#compression) method in the **Compression** field.
   1. Specify the [format of stored data](formats.md#formats) in the **Format** field.
   1. List data columns and their types.
   1. Select a partitioning mode and list [partitioning columns](../concepts/partitioning.md) and their types.

      If you use **Extended** partitioning, specify the [partition projection](../concepts/partition-projection.md) columns.

1. To check the data, click **Preview**.
1. Click **Create**.

## Data model {#data-model}

{{ objstorage-short-name }} stores data as binary files. To read data, use the following SQL statement:

```sql
SELECT
    <expression>
FROM
    bindings.`binding_name`
WHERE
    <filter>;
```

Where:

* `bindings`: Keyword that indicates operations with {{ objstorage-short-name }} using data bindings.
* `binding_name`: Name of the previously created data binding.

## Example of reading data using bindings {#binding-example}

Sample query to read data from {{ objstorage-short-name }} using bindings:

```sql
SELECT
    *
FROM
    bindings.`binding_name`
```

Where `binding_name` is the name of binding to {{ objstorage-short-name }} data.

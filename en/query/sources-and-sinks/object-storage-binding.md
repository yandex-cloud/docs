# Reading data from {{ objstorage-name }} using {{ yq-full-name }} bindings

When working with {{ objstorage-full-name }}, it's convenient to use bindings for running regular queries to stored data with no need to specify all details of operations with this data.

```sql
SELECT
        *
FROM
    bindings.`logs`
WHERE
    version>1
```

## Setting up a data binding

To read data from {{ objstorage-full-name }} using bindings:
1. [Setting up a connection to data](./object-storage.md#create_connection).
1. In the Type field, select `Object Storage`.
1. In the drop-down list of the `Connection` field, select the connection you created in the first step.
1. Specify a name for a binding in the `Name` field.
1. In the `Path` field, specify the [path to bucket data](object-storage.md#path_format). Parts of file names can be specified using \*, such as "yellow\*.csv".
1. Specify the [data compression](formats.md#compression) method in the `Compression` field.
1. Specify the [format of stored data](formats.md#formats) in the `Format` field.
2. List data columns and their data types in the `Columns` fields.
3. In the `Data partitioning` field, list [partitioning columns](../concepts/partitioning.md).
4. If you use `Extended partitioning`, specify the [partition projection](../concepts//partition-projection.md) columns and rules for using them under `Additional`.
5. To check the data, click `Preview`.
6. Click `Create` to create a binding.


## Data model

{{ objstorage-full-name }} stores data as binary files. Data is read using the SQL statement:

```sql
SELECT
    <expression>
FROM
    bindings.`binding_name`
WHERE
    <filter>;
```

Where:

- `bindings` is the keyword that indicates operations with {{objstorage-full-name}} using data bindings.
- `binding_name` is the name of the previously created data binding.

## Example of reading data using bindings

Sample query to read data from {{ objstorage-full-name }} using bindings

```sql
SELECT
        *
FROM
    bindings.`binding_name`
```

Where:

|Field|Description|
|--|---|
|`binding_name`| Name of binding to data in {{ objstorage-full-name }}|

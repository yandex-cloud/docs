# Reading data using {{ yq-name }} bindings

When working with {{ yds-full-name }}, it's convenient to use bindings for running regular queries to stored data with no need to specify all details of operations with this data.


Example of reading data using bindings:

```sql
SELECT
    JSON_VALUE(CAST(Data as Json), "$.action") as action
FROM bindings.`input_stream`
LIMIT 10;
```

{% note info %}

{% include [limit](../_includes/select-limit.md) %}

{% endnote %}


## Setting up a data binding

To read data from {{ yds-full-name }} using bindings:
1. [Setting up a connection to data](./data-streams.md#create_connection).
1. In the Type field, select `Data Streams`.
1. In the drop-down list of the `Connection` field, select the connection you created in the first step.
1. Specify a name for a binding in the `Name` field.
1. Specify a name for a {{ yds-full-name }} stream in the `Stream` field.
1. Specify the [data compression](formats.md#compression) method in the `Compression` field.
1. Specify the [format of transferred data](formats.md#formats) in the `Format` field.
1. List data columns and their data types in the `Columns` fields.
1. To check the data, click `Preview`.
1. Click `Create` to create a binding.

## Data model

Data is sent via {{ yds-full-name }} in binary form. Data is read using SQL statements.

```sql
SELECT
    <expression>
FROM
    <yds_connection_name>.`<stream_name>`
WITH
(
    format=raw,
    SCHEMA
    (
        Data String
    )
)
WHERE <filter>;
```

Where:

- `yds_connection_name` is the name of the {{ yds-short-name }} stream connection created in the previous step.
- `stream_name` is the name of the stream in {{ yds-short-name }}.


## Example of reading data

Sample query for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") as host,
    JSON_VALUE(Data, "$.count") as count,
    JSON_VALUE(Data, "$.tag") as tag,
FROM
(
    SELECT
        CAST(Data as Json) as Data
    FROM bindings.`binding_name`
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

SELECT
    *
FROM
    $data
LIMIT 10;
```

Where:

|Field|Type|Description|
|--|---|---|
|`binding_name`| |Name of binding to source data stream in SQL query|
|`host`|String|Query string parameter|

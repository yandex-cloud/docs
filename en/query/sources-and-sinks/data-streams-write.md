# Writing data to {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) is a service that lets you transfer data streams to multiple applications for processing, with each of them handling the data independently.

Example of writing `JSON` data to {{ yds-full-name }}

```sql
INSERT INTO yds.`output_stream`
SELECT
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"predefined":
            <|
                "host": host,
                "count": count,
            |>,
            "optional":
            <|
                "tag": tag
            |>
        |>))))
FROM
    $data;
```

## Setting up a connection {#connect}

To read data from {{ yds-full-name }}:
1. Go to the {{ yq-full-name }} interface, open the **Connections** section, and click **Create**.
1. In the window that opens, specify a name for a connection to {{ yds-full-name }} in the **Name** field.
1. In the drop-down list of the **Type** field, select **Data Streams**.
1. In the drop-down list of the **Database** field, select the {{ ydb-full-name }} database where the {{ yds-full-name }} stream was created.
1. In the **Service account** field, select the service account to be used for data reads or create a new one by granting it [`yds.writer`](../../data-streams//security/index.md) rights.
1. Click **Create** to create a connection.

## Data model

Data is sent via {{ yds-full-name }} in binary form. Data is written using SQL statements and generally looks like this:

```sql
INSERT INTO <yds_connection_name>.<stream_name>
    <expression>
FROM
   <query>
```

Where:

- `yds_connection_name`: Name of the {{ yds-short-name }} stream connection created in the previous step.
- `stream_name`: Name of the stream in {{ yds-short-name }}.
- `query`: {{ yq-full-name }} data source query.

## Example of writing data

Sample query for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") as host,
    CAST(JSON_VALUE(Data, "$.count") as Int) as count,
    JSON_VALUE(Data, "$.tag") as tag,    
FROM
(
    SELECT
        CAST(Data as Json) as Data
    FROM yds.`input_stream`
    WITH(
        format=raw,
        SCHEMA
        (
            Data String
        )
    )
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

INSERT INTO yds.`output_stream`
SELECT
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"predefined":
            <|
                "host": host,
                "count": count,
            |>,
            "optional":
            <|
                "tag": tag
            |>
        |>))))
FROM
    $data;
```

Where:

|Field|Type|Description|
|--|---|---|
|`yds`| |{{ yds-full-name }} connection name|
|`input_stream`| |Source stream name in the SQL query|
|`output_stream`| |Target stream name in the SQL query|
|`host`|String|Query string parameter|
|`count`|Integer|Query numeric parameter|
|`raw`|String|Data format. Currently, the only supported format is `raw`|

The processing results are written to the {{ yds-full-name }} output stream. To facilitate the processing, this data is converted to `JSON` format using the following statement:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2":
        <|"child_key": child_value|>,
    |>,
    ))))
```

The YQL documentation provides a detailed description of modules such as [Yson](https://ydb.tech/en/docs/yql/reference/udf/list/yson), [Json](https://ydb.tech/en/docs/yql/reference/types/json) and [its functions](https://ydb.tech/en/docs/yql/reference/builtins/json), [<|"key": value|>](https://ydb.tech/en/docs/yql/reference/builtins/struct).

## Supported write formats

{% include [!](../_includes/supported-yds-write-formats.md) %}

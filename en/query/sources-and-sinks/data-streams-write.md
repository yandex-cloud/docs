# Writing data to {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) is a service that allows you to transfer data streams to multiple applications for processing, with each of them handling the data independently.

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
1. Go to **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** in the {{ yq-full-name }} interface and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify a name for a connection to {{ yds-full-name }} in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the drop-down list under **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** drop-down list, select the {{ ydb-full-name }} database where the {{ yds-full-name }} stream was created.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select a service account for data reads or create a new one with the [`yds.writer`](../../data-streams/security/index.md) permissions.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.

## Data model

Data is sent via {{ yds-full-name }} in binary form. Data is written using SQL statements and generally looks like this:

```sql
INSERT INTO <connection>.<stream_name>
    <expression>
FROM
   <query>
```

Where:

- `<connection>`: Name of the {{ yds-short-name }} data stream connection created in the previous step.
- `<stream_name>`: Name of the data stream in {{ yds-short-name }}.
- `<query>`: {{ yq-full-name }} data source query.

## Example of writing data

Sample query for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    CAST(JSON_VALUE(Data, "$.count") AS Int) AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
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
|`count`|Integer|Query numerical parameter|
|`raw`|String|Data format. Currently, the only supported format is `raw` (raw data)|

The processing results are written to the {{ yds-full-name }} output stream. To facilitate the processing, this data is converted to `JSON` format using the following statement:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2":
        <|"child_key": child_value|>,
    |>,
    ))))
```

The YQL documentation provides a detailed description of [Yson]({{ ydb.docs }}/yql/reference/udf/list/yson), [Json]({{ ydb.docs }}/yql/reference/types/json) and [its functions]({{ ydb.docs }}/yql/reference/builtins/json), [<|"key": value|>]({{ ydb.docs }}/yql/reference/builtins/struct).

## Supported write formats

{% include [!](../_includes/supported-yds-write-formats.md) %}

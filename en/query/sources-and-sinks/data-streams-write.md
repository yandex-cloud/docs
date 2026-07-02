# Writing data to {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) enables you to transfer data streams to multiple applications for processing, with each handling the data independently of the others.

Query example for writing `JSON`-formatted data to {{ yds-full-name }}

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
1. [Navigate](../../console/operations/select-service.md#select-service) to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** section of the **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** interface and click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify the {{ yds-full-name }} connection name in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** dropdown, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** dropdown, select the {{ ydb-full-name }} database where you created the {{ yds-full-name }} stream.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select an existing service account or create a new one. Assign it the [`yds.writer`](../../data-streams/security/index.md) permissions required to read data.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}** to create a connection.

## Data model

Data is transmitted via {{ yds-full-name }} in binary format and is written via SQL statements as follows:

```sql
INSERT INTO <connection>.<stream_name>
    <expression>
FROM
   <query>
```

Where:

- `<connection>`: Name of the {{ yds-short-name }} data stream connection created in the previous step.
- `<stream_name>`: {{ yds-short-name }} data stream name.
- `<query>`: {{ yq-full-name }} source data query.

## Data writing example

Query example for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}:

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
|`input_stream`| |Name of the source data stream in the SQL query|
|`output_stream`| |Target stream name in the SQL query|
|`host`|String|String query parameter|
|`count`|Integer|Numeric query parameter|
|`raw`|String|Data format. Support is currently limited to the `raw` format|

The system writes processing results to the {{ yds-full-name }} output stream. To facilitate further processing, the data is converted to `JSON` as follows:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2":
        <|"child_key": child_value|>,
    |>,
    ))))
```

The YQL guides provide details on [Yson]({{ ydb.docs }}/yql/reference/udf/list/yson) and [Json]({{ ydb.docs }}/yql/reference/types/json) modules, and [their functions]({{ ydb.docs }}/yql/reference/builtins/json), [<|"key": value|>]({{ ydb.docs }}/yql/reference/builtins/struct).

## Supported write formats

{% include [!](../_includes/supported-yds-write-formats.md) %}

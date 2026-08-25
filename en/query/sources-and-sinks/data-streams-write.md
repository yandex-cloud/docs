---
title: Writing data from {{ yq-full-name }} to {{ yds-full-name }} streams
description: In this article, you will learn how to write data from {{ yq-full-name }} to {{ yds-full-name }} streams.
---

# Writing data from {{ yq-full-name }} to {{ yds-full-name }} streams

[{{ yds-full-name }}](../../data-streams/concepts/index.md): Service for transmitting data streams to multiple applications. Each application processes data independently from the others.

Example of writing JSON data to {{ yds-full-name }}:

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

To set up writing data to {{ yds-full-name }}:

1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Click **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. In the window that opens, specify the {{ yds-full-name }} connection name in the **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** field.
1. In the **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** field, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-connection-form.database.input-label }}** field, select the {{ ydb-full-name }} database where you created the {{ yds-full-name }} stream.
1. In the **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** field, select the service account you intend to use to write data, or create a new one and assign it the [`yds.writer`](../../data-streams/security/index.md#yds-writer) role.
1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Data model {#data-model}

Data is transmitted via {{ yds-full-name }} in binary format and is written via SQL statements as follows:

```sql
INSERT INTO <connection>.<stream_name>
    <expression>
FROM
    <query>
```

Where:

* `<connection>`: Name of the {{ yds-short-name }} data stream connection created in the previous section.
* `<stream_name>`: {{ yds-short-name }} data stream name.
* `<statement>`: Statement defining the data to write.
* `<query>`: {{ yq-full-name }} source data query.

## Data writing example {#example}

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

#|
|| **Field** | **Type** | **Description** ||
|| `yds` |  | {{ yds-full-name }} connection name ||
|| `input_stream` |  | Name of the source data stream in the SQL query ||
|| `output_stream` |  | Name of the target data stream in the SQL query ||
|| `host` | String | String query parameter ||
|| `count` | Integer | Integer query parameter ||
|| `raw` | String | Data format Currently, only the `raw` data format is supported. ||
|#

The system writes processing results to the {{ yds-full-name }} output stream. For simpler processing, the results are converted to JSON format using the following structure:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2": 
        <|"child_key": child_value|>,
    |>,
    ))))
```

See YQL guides for detailed descriptions of the [Yson]({{ ydb.docs }}/yql/reference/udf/list/yson) and [Json]({{ ydb.docs }}/yql/reference/types/json) modules, [JSON functions]({{ ydb.docs }}/yql/reference/builtins/json), and [structures]({{ ydb.docs }}/yql/reference/builtins/struct).

## Supported write formats {#supported-formats}

{% include [!](../_includes/supported-yds-write-formats.md) %}

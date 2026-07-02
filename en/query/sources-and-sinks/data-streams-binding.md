# Reading data via {{ yq-name }} data bindings

{{ yds-full-name }} data bindings simplify running recurrent queries on stored data by eliminating the need to specify all operation details.

Query example for reading data via bindings:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM bindings.`input_stream`
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Setting up a data binding

To read {{ yds-full-name }} data via bindings, complete the following steps:

1. [Setting up a data connection](./data-streams.md#create_connection).
1. In the **{{ ui-key.yql.yq-binding-form.connection-type.title }}** field, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the **{{ ui-key.yql.yq-binding-form.connection.title }}** dropdown, select the connection you created in the first step.
1. Specify the data binding name in the **{{ ui-key.yql.yq-binding-form.binding-name.title }}** field.
1. Specify the {{ yds-full-name }} stream name in the **{{ ui-key.yql.yq-binding-form.binding-stream.title }}** field.
1. Specify the [data compression method](formats.md#compression) in the **{{ ui-key.yql.yq-binding-info.compression.label-text }}** field.
1. Specify the [data transfer format](formats.md#formats) in the **{{ ui-key.yql.yq-binding-info.format.label-text }}** field.
1. Specify data columns and their data types in the **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** fields.
1. To validate the data, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}** to create a data binding.

## Data model

Data is transmitted via {{ yds-full-name }} in binary format and is read via SQL statements.

```sql
SELECT
    <expression>
FROM
    <connection>.<stream_name>
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

- `<connection>`: Name of the {{ yds-short-name }} data stream connection created in the previous step.
- `<stream_name>`: {{ yds-short-name }} data stream name.

## Data reading example

Query example for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}:

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    JSON_VALUE(Data, "$.count") AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
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
|`binding_name`| |Name of the binding to the source data stream in the SQL query|
|`host`|String|Query string parameter|

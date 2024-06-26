# Reading data using {{ yq-name }} bindings

When working with {{ yds-full-name }}, bindings help you run regular queries to stored data with no need to specify all details of operations with this data.

Example of reading data using bindings:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM bindings.`input_stream`
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Setting up a data binding

To read data from {{ yds-full-name }} using bindings:

1. [Setting up a data connection](./data-streams.md#create_connection).
1. In the **{{ ui-key.yql.yq-binding-form.connection-type.title }}** field, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. In the drop-down list of the **{{ ui-key.yql.yq-binding-form.connection.title }}** field, select the connection you created in the first step.
1. Specify a name for the data binding in the **{{ ui-key.yql.yq-binding-form.binding-name.title }}** field.
1. Specify a name for a {{ yds-full-name }} stream in the **{{ ui-key.yql.yq-binding-form.binding-stream.title }}** field.
1. Specify the [data compression](formats.md#compression) method in the **{{ ui-key.yql.yq-binding-info.compression.label-text }}** field.
1. Specify the [format of transferred data](formats.md#formats) in the **{{ ui-key.yql.yq-binding-info.format.label-text }}** field.
1. List data columns and their data types in the **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** fields.
1. To check the data, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}** to create a binding.

## Data model

Data is sent via {{ yds-full-name }} in binary form. Data is read using SQL statements.

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
- `<stream_name>`: Name of the data stream in {{ yds-short-name }}.

## Example of reading data

Sample query for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}

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
|`binding_name`| |Name of binding to source data stream in SQL query|
|`host`|String|Query string parameter|

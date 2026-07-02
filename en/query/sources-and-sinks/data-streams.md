# Reading data from {{ yds-name }} via {{ yq-name }} connections

Using {{ yds-full-name }} connections is convenient for prototyping and initial data access configuration.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) enables you to transfer data streams to multiple applications for processing, with each handling the data independently of the others.

Query example for reading `Json`-formatted data from {{ yds-full-name }}:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM yds.`input_stream`
WITH (
    format=raw,
    SCHEMA
    (
        Data String
    )
)
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Setting up a connection {#create_connection}

To read data from {{ yds-full-name }}:

{% include [create-connection](../_includes/create-connection.md) %}

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

Query example for reading data from {{ yds-full-name }} and writing the results to {{ yds-full-name }}

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
    FROM yds.`input_stream`
    WITH
    (
        format=raw,
        SCHEMA
        (
            Data String
        )
    )
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
|`yds`| |{{ yds-full-name }} connection name|
|`input_stream`| |Name of the source data stream in the SQL query|
|`host`|String|Query string parameter|
|`raw`|String|Data format. Support is currently limited to the `raw` format|

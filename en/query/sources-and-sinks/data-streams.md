# Reading data from {{ yds-name }} using {{ yq-name }} connections

When working with {{ yds-full-name }}, it is convenient to use connections for prototyping and initial setup of connections to data.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) is a service that allows you to transfer data streams to multiple applications for processing, with each of them handling the data independently.

Example of reading `JSON` data from {{ yds-full-name }}

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
|`input_stream`| |Source stream name in the SQL query|
|`host`|String|Query string parameter|
|`raw`|String|Data format. Currently, the only supported format is `raw`|

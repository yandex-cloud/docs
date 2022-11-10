# Reading data from {{ yds-name }} using connections to {{ yq-full-name }}

When working with {{ yds-full-name }}, it's convenient to use connections for prototyping and initial setup of connections to data.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) is a service that lets you transfer data streams to multiple applications for processing, with each of them handling the data independently.

Example of reading `JSON` data from {{ yds-full-name }}

```sql
SELECT
    JSON_VALUE(CAST(Data as Json), "$.action") as action
FROM yds.`input_stream`
WITH (
    format=raw,
    SCHEMA
    (
        String as Data
    )
)
LIMIT 10;
```

{% note info %}

{% include [limit](../_includes/select-limit.md) %}

{% endnote %}

## Setting up a connection { #create_connection }

To read data from {{ yds-full-name }}:

{% include [create-connection](../_includes/create-connection.md) %}

## Data model

Data is sent via {{yds-full-name }} in binary form. Data is read using SQL statements.

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

- `yds_connection_name` is the name of the {{yds-short-name}} stream connection created in the previous step.
- `stream_name` is the name of the stream in {{yds-short-name}}.


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

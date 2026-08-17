---
title: Reading data from {{ yds-full-name }} via {{ yq-full-name }} connections
description: In this article, you will learn how to set up a connection and read data from {{ yds-full-name }} using {{ yq-full-name }}.
---

# Reading data from {{ yds-name }} via {{ yq-name }} connections

Connections are useful for prototyping and initial setup of {{ yds-full-name }} data connections.

[{{ yds-full-name }}](../../data-streams/concepts/index.md): Service for transmitting data streams to multiple applications. Each application processes data independently from the others.

Example of reading JSON data from {{ yds-full-name }}:

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

To set up reading from {{ yds-full-name }}:

{% include [create-connection](../_includes/create-connection.md) %}

## Data model {#data-model}

Data is transmitted via {{ yds-full-name }} in binary format. To read data, use an SQL statement of the following format:

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
WHERE
    <filter>;
```

Where:

* `<statement>`: Statement that determines the result of the query.
* `<connection>`: Name of the {{ yds-short-name }} data stream connection created in the previous section.
* `<stream_name>`: {{ yds-short-name }} data stream name.
* `<filter>`: Data filtering condition.

## Data reading example {#example}

Query example for reading data from {{ yds-full-name }}:

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

#|
|| **Field** | **Type** | **Description** ||
|| `yds` |  | {{ yds-full-name }} connection name. ||
|| `input_stream` |  | Name of the source data stream. ||
|| `host` | String | Host name. ||
|| `count` | String | Number of events. ||
|| `tag` | String | Event tag. ||
|| `raw` | String | Data format Currently, only the `raw` data format is supported. ||
|#

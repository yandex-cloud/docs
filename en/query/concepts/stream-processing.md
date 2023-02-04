# Streaming data analysis

It's easiest to explain how streaming data analysis works on a specific use case: let's say we want to develop a system for pre-ordering goods from our online store. We'll daily analyze the number of searches for the word "air conditioner" on the online store's website for the last day with an order made the next day.

All search history is logged to a file named access.log. A special program transfers data from the access.log file to a DB table.

![](../_assets/streaming-exp-1.png)

Users make 100000 search queries for goods daily, meaning that the DB table will store 300000 search records.

To count the number of search queries for goods for the last day, run the following query:

```sql
SELECT
    date,
    count(*)
FROM
    database
WHERE
    query LIKE ‘%conditioner%’
        AND
            date IN [today()-1, today]
GROUP BY date
```

If the size of each search record is 1KB, the size of 100000 records will be 100 MB. This means that we need to scan all the 100 MB of data to count the number of search queries for conditioners.

## Streaming analysis

Now let's solve the same problem through streaming analysis.

It processes records one by one while they're being transferred from the source to the target, that is, from the access.log file to the database, instead of handling the data previously accumulated in storage systems. In this case, only computation results are saved, while unnecessary data is discarded.

![](../_assets/streaming-exp-2.png)

Streaming analysis systems let you describe operations on the data being transferred in the regular SQL.

A similar SQL query for streaming analysis looks like this:

```sql
SELECT
    HOP_BEGIN(),
    COUNT(*)
FROM
    database
WHERE
    query LIKE '%conditioner%'
GROUP BY HOP(`date`, "PT24H", "PT24H", "PT1H")
```

This query counts the number of search queries containing the word "air conditioner" and groups them by 24-hour interval.

## Differences between batch and streaming analysis

[Batch analysis](./batch-processing.md) is usually performed in the context of a DBMS that already stores all data required for the analysis. Streaming analysis uses data received at a given time from actual sources, and this data may be incomplete as of the analysis time.

The main difference between streaming and batch data processing is the balance between the processing rate and completeness of data being processed. Under streaming processing, the delay is shorter and data is less complete; under batch processing, the delay is longer and the data is more complete.

|  | Batch processing | Streaming processing |
|----|----|----|
| Data processing delay | Hours, days. Performed once all necessary data is accumulated | Seconds, minutes. Performed on partially received data |
| Accuracy of results | Complete, since all the necessary data is previously accumulated | Partial, since processing is limited by the maximum waiting time for data. |
| Impact on the runtime system | Affects the DBMS in the context of which it's performed | Run using the allocated capacity of the streaming analysis system and has no impact on the DBMS |
| Variability | The DBMS allows running any types of queries even those not planned beforehand | Only queries prepared in advance |

## Reference use

Usually streaming data only contains IDs rather than complete data. For example, only a user's ID instead of their full name. In this case, the user's full name is saved to some storage system.

While processing, streaming data is often extended with additional information. This information is called reference and the process of adding data is called enrichment.

{{yq-full-name}} can use data stored in {{ objstorage-full-name }} for enrichment. The SQL `JOIN` statement is used to enrich data.

{% note warning %}

Joining streaming data and references with a `JOIN` should be made so that a data stream in the `JOIN` is followed by a reference.

{% endnote %}

Sample data enrichment query

```sql
$json_stream =
SELECT
    CAST(Data AS json) AS data,
FROM
    yds.`input_stream`
WITH
(  
    format=raw,
    SCHEMA (Data String)
);

$events =
SELECT
    CAST(JSON_VALUE(data, '$.hostid') AS String) AS hostid,
FROM
    $json_stream;

$host_dictionary =
SELECT
        *
FROM object_storage_lookup.`hosts.csv`
WITH
(
    format=csv_with_names,
    SCHEMA
    (
        hostid String,
        host_name String
    )
);

SELECT
    *
FROM
    $events AS events
INNER JOIN $host_dictionary AS host_dictionary
    ON events.hostid=host_dictionary.hostid;
```

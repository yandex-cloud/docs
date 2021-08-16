# System views

To enable internal introspection of the DB state, the user can make queries to special service tables (system views). These tables are accessible from the root of the database tree and use the `.sys` system path prefix.

Currently, you can access system views via the web interface.

Hereinafter, in the descriptions of available fields, the **Key** column contains the corresponding table's primary key field index.

----

## Table partitions

* **partition_stats**

A system view that provides detailed information about individual partitions of all DB tables. Contains information about instant metrics, such as CPU load or count of in-flight transactions, as well as cumulative counters of a variety of operations on a partition (for example, total number of rows read). Primarily designed for detecting various irregularities in the load on a table partition or in the size of table partition data.

Table structure:

| **Field** | **Type** | **Key** | **Value** |
| --- | --- | --- | --- |
| OwnerId | Uint64 | 0 |  ID of the datashard serving the table |
| PathId | Uint64 | 1 | Path ID in the datashard |
| PartIdx | Uint64 | 2 | Partition sequence number |
| DataSize | Uint64 |  | Approximate partition size in bytes |
| RowCount | Uint64 |  | Approximate number of rows |
| IndexSize | Uint64 |  | Partition index size in a tablet |
| CPUCores | Double |  | Instant value of load per partition (CPU share) |
| TabletId | Uint64 |  | ID of the tablet serving the partition |
| Path | Utf8 |  | Full table path |
| NodeId | Uint32 |  | ID of the node that the partition is being served on |
| StartTime | Timestamp |  | Last time when the tablet serving the partition was launched |
| AccessTime | Timestamp |  | Last time when data from the partition was read |
| UpdateTime | Timestamp |  | Last time when data was written to the partition |
| RowReads | Uint64 |  | Number of point reads since the start of the partition tablet |
| RowUpdates | Uint64 |  | Number of rows written since the start |
| RowDeletes | Uint64 |  | Number of rows deleted since the start |
| RangeReads | Uint64 |  | Number of row ranges read since the start |
| RangeReadRows | Uint64 |  | Number of rows read in the ranges since the start |
| InFlightTxCount | Uint64 |  | Number of in-flight transactions on the partition |
| ImmediateTxCompleted | Uint64 |  | Number of one-shard transactions completed since the start |
| CoordinatedTxCompleted | Uint64 |  | Number of coordinated transactions completed since the start |
| TxRejectedByOverload | Uint64 |  | Number of transactions rejected due to overload (since the start) |
| TxRejectedByOutOfStorage | Uint64 |  | Number of transactions rejected due to lack of storage space (since the start) |

Restrictions:

* Cumulative fields (RowReads, RowUpdates, and so on) store the accumulated values since the last start of the tablet serving the partition

Examples:

Top 5 of most loaded partitions among all DB tables

```sql
SELECT
    Path,
    PartIdx,
    CPUCores
FROM `/path/to/database/.sys/partition_stats`
ORDER BY CPUCores DESC
LIMIT 5
```

List of DB tables with in-flight sizes and loads

```sql
SELECT
    Path,
    COUNT() as Partitions,
    SUM(RowCount) as Rows,
    SUM(DataSize) as Size,
    SUM(CPUCores) as CPU
FROM `/path/to/database/.sys/partition_stats`
GROUP BY Path
```

----

## Top queries

* **top_queries_by_duration_one_minute**
* **top_queries_by_duration_one_hour**
* **top_queries_by_read_bytes_one_minute**
* **top_queries_by_read_bytes_one_hour**
* **top_queries_by_cpu_time_one_minute**
* **top_queries_by_cpu_time_one_hour**

A group of system views for analyzing the flow of user queries. They let you see a time-limited query history divided into intervals. Within a single interval, the top 5 queries by a specific metric are saved. Currently, minute and hour intervals are available, and the top list can be made based on the total query execution time (the slowest), the number of bytes read from the table (the widest), and the total CPU time used (the heaviest).

Different runs of a query with the same text are deduplicated. The top list contains information about a specific run with the maximum value of the corresponding query metric within a single interval.

Fields that provide information about the used CPU time (...CPUTime) are expressed in ms.

Table structure:

| **Field** | **Type** | **Key** | **Value** |
| --- | --- | --- | --- |
| IntervalEnd | Timestamp | 0 | Closing time of a minute or hour interval |
| Rank | Uint32 | 1 | Rank of a top query |
| QueryText | Utf8 |  | Query text |
| Duration | Interval |  | Total time of query execution |
| EndTime | Timestamp |  | Query execution end time |
| Type | String |  | Query type (data, scan, or script) |
| ReadRows | Uint64 |  | Number of rows read |
| ReadBytes | Uint64 |  | Number of bytes read |
| UpdateRows | Uint64 |  | Number of rows updated |
| UpdateBytes | Uint64 |  | Number of bytes updated |
| DeleteRows | Uint64 |  | Number of rows deleted |
| Partitions | Uint64 |  | Number of table partitions used during query execution |
| UserSID | String |  | User security ID |
| ParametersSize | Uint64 |  | Size of query parameters in bytes |
| CompileDuration | Interval |  | Query compile duration |
| FromQueryCache | Bool |  | Shows whether the cache of prepared queries was used |
| CPUTime | Uint64 |  | Total CPU time used to execute the query (ms) |
| ShardCount | Uint64 |  | Number of shards used during query execution |
| SumShardCPUTime | Uint64 |  | Total CPU time used in shards |
| MinShardCPUTime | Uint64 |  | Minimum CPU time used in shards |
| MaxShardCPUTime | Uint64 |  | Maximum CPU time used in shards |
| ComputeNodesCount | Uint64 |  | Number of compute nodes used during query execution |
| SumComputeCPUTime | Uint64 |  | Total CPU time used in compute nodes |
| MinComputeCPUTime | Uint64 |  | Minimum CPU time used in compute nodes |
| MaxComputeCPUTime | Uint64 |  | Maximum CPU time used in compute nodes |
| CompileCPUTime | Uint64 |  | CPU time used to compile a query |
| ProcessCPUTime | Uint64 |  | CPU time used for overall query handling |

Restrictions:

* Query text limit is 4 KB.
* Tables with minute intervals contain the history for the last 6 hours.
* Tables with hourly intervals contain the history for the last 2 weeks.

Examples:

Top queries by execution time for the last minute when queries were made

```sql
$last = (
    SELECT
        MAX(IntervalEnd)
    FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
);
SELECT
    IntervalEnd,
    Rank,
    QueryText,
    Duration
FROM `/path/to/database/.sys/top_queries_by_duration_one_minute`
WHERE IntervalEnd IN $last
```

Queries that read the most bytes, broken down by minute

```sql
SELECT
    IntervalEnd,
    QueryText,
    ReadBytes,
    ReadRows,
    Partitions
FROM `/path/to/database/.sys/top_queries_by_read_bytes_one_minute`
WHERE Rank = 1
```

----

## Query details

* **query_metrics_one_minute**

Detailed information about queries, broken down by minute. Each table row contains information about a set of queries with identical text that were made during one minute. The table fields provide the minimum, maximum, and total values for each query metric tracked. Within the interval, queries are sorted in descending order of the total CPU time used.

Table structure:

| **Field** | **Type** | **Key** | **Value** |
| --- | --- | --- | --- |
| IntervalEnd | Timestamp | 0 | Closing time of a minute or hour interval |
| Rank | Uint32 | 1 | Query rank per interval (by the SumCPUTime field) |
| QueryText | Utf8 |  | Query text |
| Count | Uint64 |  | Number of query runs |
| SumDuration | Interval |  | Total query duration |
| MinDuration | Interval |  | Minimum query duration |
| MaxDuration | Interval |  | Maximum query duration |
| SumCPUTime | Uint64 |  | Total CPU time used |
| MinCPUTime | Uint64 |  | Minimum CPU time used |
| MaxCPUTime | Uint64 |  | Maximum CPU time used |
| SumReadRows | Uint64 |  | Total number of rows read |
| MinReadRows | Uint64 |  | Minimum number of rows read |
| MaxReadRows | Uint64 |  | Maximum number of rows read |
| SumReadBytes | Uint64 |  | Total number of bytes read |
| MinReadBytes | Uint64 |  | Minimum number of bytes read |
| MaxReadBytes | Uint64 |  | Maximum number of bytes read |
| SumUpdateRows | Uint64 |  | Total number of rows updated |
| MinUpdateRows | Uint64 |  | Minimum number of rows updated |
| MaxUpdateRows | Uint64 |  | Maximum number of rows updated |
| SumUpdateBytes | Uint64 |  | Total number of bytes updated |
| MinUpdateBytes | Uint64 |  | Minimum number of bytes updated |
| MaxUpdateBytes | Uint64 |  | Maximum number of bytes updated |
| SumDeleteRows | Uint64 |  | Total number of rows deleted |
| MinDeleteRows | Uint64 |  | Minimum number of rows deleted |
| MaxDeleteRows | Uint64 |  | Maximum number of rows deleted |

Restrictions:

* Query text limit is 4 KB.
* The table contains the history for the last 6 hours.
* Within the interval, information is provided for no more than 256 different queries.
* Statistics may be incomplete if the database is under heavy load.

Examples:

Top 10 queries for the last 6 hours by the total number of rows updated per minute

```sql
SELECT
    SumUpdateRows,
    Count,
    QueryText,
    IntervalEnd
FROM `/path/to/database/.sys/query_metrics_one_minute`
ORDER BY SumUpdateRows DESC LIMIT 10
```

Recent queries that read the most bytes per minute

```sql
SELECT
    IntervalEnd,
    SumReadBytes,
    MinReadBytes,
    SumReadBytes / Count as AvgReadBytes,
    MaxReadBytes,
    QueryText
FROM `/path/to/database/.sys/query_metrics_one_minute`
WHERE SumReadBytes > 0
ORDER BY IntervalEnd DESC, SumReadBytes DESC
LIMIT 100
```

----

## Notes

Please keep in mind that load caused by accessing system views is more analytical in nature, and therefore making frequent queries to them in large DBs will consume a lot of system resources. A load of about 1-2 rps is quite acceptable.


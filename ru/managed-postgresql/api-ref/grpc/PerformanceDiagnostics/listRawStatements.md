---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/PerformanceDiagnostics/listRawStatements.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService.ListRawStatements

Retrieves statistics on planning and execution of SQL statements (queries).

## gRPC request

**rpc ListRawStatements ([ListRawStatementsRequest](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest)) returns ([ListRawStatementsResponse](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse))**

## ListRawStatementsRequest {#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest}

```json
{
  "cluster_id": "string",
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of a PostgreSQL cluster to request query statistics for.

To get a PostgreSQL cluster ID, use the [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) method. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of the results is larger than `page_size`, the service returns [ListRawStatementsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse). You can use it to get the next page of the results in subsequent requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListRawStatementsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse) returned by the previous SQL statement list request. ||
|#

## ListRawStatementsResponse {#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse}

```json
{
  "statements": [
    {
      "key": {
        "host": "string",
        "user": "string",
        "database": "string",
        "toplevel": "bool",
        "query_id": "string",
        "plan_id": "string"
      },
      "stats": {
        "time": "google.protobuf.Timestamp",
        "query": "string",
        "normalized_plan": "string",
        "example_plan": "string",
        "plans": "int64",
        "total_plan_time": "double",
        "min_plan_time": "double",
        "max_plan_time": "double",
        "mean_plan_time": "double",
        "stddev_plan_time": "double",
        "calls": "int64",
        "total_time": "double",
        "min_time": "double",
        "max_time": "double",
        "mean_time": "double",
        "stddev_time": "double",
        "rows": "int64",
        "shared_blks_hit": "int64",
        "shared_blks_read": "int64",
        "shared_blks_dirtied": "int64",
        "shared_blks_written": "int64",
        "local_blks_hit": "int64",
        "local_blks_read": "int64",
        "local_blks_dirtied": "int64",
        "local_blks_written": "int64",
        "temp_blks_read": "int64",
        "temp_blks_written": "int64",
        "blk_read_time": "double",
        "blk_write_time": "double",
        "temp_blk_read_time": "double",
        "temp_blk_write_time": "double",
        "wal_records": "int64",
        "wal_fpi": "int64",
        "wal_bytes": "int64",
        "jit_functions": "int64",
        "jit_generation_time": "double",
        "jit_inlining_count": "int64",
        "jit_inlining_time": "double",
        "jit_optimization_count": "int64",
        "jit_optimization_time": "double",
        "jit_emission_count": "int64",
        "jit_emission_time": "double",
        "startup_cost": "int64",
        "total_cost": "int64",
        "plan_rows": "int64",
        "plan_width": "int64",
        "reads": "int64",
        "writes": "int64",
        "user_time": "double",
        "system_time": "double"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| statements[] | **[QueryStatement](#yandex.cloud.mdb.postgresql.v1.QueryStatement)**

List of SQL statements (queries). ||
|| next_page_token | **string**

This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawStatementsRequest.page_size](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest), use the `next_page_token` as the value for the [ListRawStatementsRequest.page_token](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest) parameter in the next request. Each subsequent request will have its own `next_page_token` to continue paging through the results. ||
|#

## QueryStatement {#yandex.cloud.mdb.postgresql.v1.QueryStatement}

#|
||Field | Description ||
|| key | **[PrimaryKey](#yandex.cloud.mdb.postgresql.v1.PrimaryKey)**

Primary keys in tables with the statistics on planning and execution of queries. ||
|| stats | **[QueryStats](#yandex.cloud.mdb.postgresql.v1.QueryStats)**

Statistics on planning and execution of queries. ||
|#

## PrimaryKey {#yandex.cloud.mdb.postgresql.v1.PrimaryKey}

#|
||Field | Description ||
|| host | **string**

Host of the connected client. ||
|| user | **string**

User ID. ||
|| database | **string**

Database ID. ||
|| toplevel | **bool**

Returns [true] if a query is executed as a top-level SQL statement or if the [pg_stat_statements.track](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.41.9) parameter is set to the value [top]. ||
|| query_id | **string**

Query ID. ||
|| plan_id | **string**

Query planning ID. ||
|#

## QueryStats {#yandex.cloud.mdb.postgresql.v1.QueryStats}

#|
||Field | Description ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of collecting statistics on planning and execution of queries. ||
|| query | **string**

Statement text. ||
|| normalized_plan | **string**

Normalized query plan. ||
|| example_plan | **string**

Example of a query execution plan (without normalization). ||
|| plans | **int64**

Number of times that a query was planned.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.41.9) parameter is enabled. ||
|| total_plan_time | **double**

Total time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| min_plan_time | **double**

Minimum time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| max_plan_time | **double**

Maximum time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| mean_plan_time | **double**

Average time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| stddev_plan_time | **double**

Population standard deviation of the time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| calls | **int64**

Number of times that a query was executed. ||
|| total_time | **double**

Total time taken to execute a query, in milliseconds. ||
|| min_time | **double**

Minimum time taken to execute a query, in milliseconds. ||
|| max_time | **double**

Maximum time taken to execute a query, in milliseconds. ||
|| mean_time | **double**

Average time taken to execute a query, in milliseconds. ||
|| stddev_time | **double**

Population standard deviation of the time taken to execute a query, in milliseconds. ||
|| rows | **int64**

Number of retrieved or affected rows. ||
|| shared_blks_hit | **int64**

Number of shared blocks that are hit from cache. ||
|| shared_blks_read | **int64**

Number of read shared blocks. ||
|| shared_blks_dirtied | **int64**

Number of 'dirtied' shared blocks. ||
|| shared_blks_written | **int64**

Number of written shared blocks. ||
|| local_blks_hit | **int64**

Number of local blocks that are hit from cache. ||
|| local_blks_read | **int64**

Number of read local blocks. ||
|| local_blks_dirtied | **int64**

Number of 'dirtied' local blocks. ||
|| local_blks_written | **int64**

Number of written local blocks. ||
|| temp_blks_read | **int64**

Number of read temporary blocks. ||
|| temp_blks_written | **int64**

Number of written temporary blocks. ||
|| blk_read_time | **double**

Time taken to read data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-IO-TIMING) parameter is enabled. ||
|| blk_write_time | **double**

Time taken to record data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| temp_blk_read_time | **double**

Time taken to read temporary data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| temp_blk_write_time | **double**

Time taken to record temporary data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| wal_records | **int64**

Number of WAL records generated during a given period. ||
|| wal_fpi | **int64**

Number of WAL full page images generated during a given period. ||
|| wal_bytes | **int64**

Number of WAL logs generated during a given period, in bytes. ||
|| jit_functions | **int64**

Number of JIT-compiled functions. ||
|| jit_generation_time | **double**

Time taken to generate JIT code, in milliseconds. ||
|| jit_inlining_count | **int64**

Number of times that functions have been inlined. ||
|| jit_inlining_time | **double**

Time taken to inline functions, in milliseconds. ||
|| jit_optimization_count | **int64**

Number of times that a query was optimized. ||
|| jit_optimization_time | **double**

Time taken to optimize a query, in milliseconds. ||
|| jit_emission_count | **int64**

Number of times that code was emitted. ||
|| jit_emission_time | **double**

Time taken to emit code. ||
|| startup_cost | **int64**

Cost of receiving a response to a query before the first row of the response is issued. ||
|| total_cost | **int64**

Cost of receiving a response to a query when all the rows of the response are issued. ||
|| plan_rows | **int64**

Expected number of rows that a given plan node should issue. ||
|| plan_width | **int64**

Expected average size of rows that a given plan node should issue. ||
|| reads | **int64**

Number of bytes that the filesystem layer has read. ||
|| writes | **int64**

Number of bytes that the filesystem layer has written. ||
|| user_time | **double**

User CPU time used. ||
|| system_time | **double**

System CPU time used. ||
|#
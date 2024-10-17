---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/PerformanceDiagnostics/listRawStatements.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService.ListRawStatements {#ListRawStatements}

Retrieves statistics on planning and execution of SQL statements (queries).

## gRPC request

**rpc ListRawStatements ([ListRawStatementsRequest](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest)) returns ([ListRawStatementsResponse](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse))**

## ListRawStatementsRequest {#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest}

```json
{
  "clusterId": "string",
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of a PostgreSQL cluster to request query statistics for.

To get a PostgreSQL cluster ID, use the [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) method. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of the results is larger than `pageSize`, the service returns [ListRawStatementsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse). You can use it to get the next page of the results in subsequent requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListRawStatementsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse) returned by the previous SQL statement list request. ||
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
        "queryId": "string",
        "planId": "string"
      },
      "stats": {
        "time": "google.protobuf.Timestamp",
        "query": "string",
        "normalizedPlan": "string",
        "examplePlan": "string",
        "plans": "int64",
        "totalPlanTime": "double",
        "minPlanTime": "double",
        "maxPlanTime": "double",
        "meanPlanTime": "double",
        "stddevPlanTime": "double",
        "calls": "int64",
        "totalTime": "double",
        "minTime": "double",
        "maxTime": "double",
        "meanTime": "double",
        "stddevTime": "double",
        "rows": "int64",
        "sharedBlksHit": "int64",
        "sharedBlksRead": "int64",
        "sharedBlksDirtied": "int64",
        "sharedBlksWritten": "int64",
        "localBlksHit": "int64",
        "localBlksRead": "int64",
        "localBlksDirtied": "int64",
        "localBlksWritten": "int64",
        "tempBlksRead": "int64",
        "tempBlksWritten": "int64",
        "blkReadTime": "double",
        "blkWriteTime": "double",
        "tempBlkReadTime": "double",
        "tempBlkWriteTime": "double",
        "walRecords": "int64",
        "walFpi": "int64",
        "walBytes": "int64",
        "jitFunctions": "int64",
        "jitGenerationTime": "double",
        "jitInliningCount": "int64",
        "jitInliningTime": "double",
        "jitOptimizationCount": "int64",
        "jitOptimizationTime": "double",
        "jitEmissionCount": "int64",
        "jitEmissionTime": "double",
        "startupCost": "int64",
        "totalCost": "int64",
        "planRows": "int64",
        "planWidth": "int64",
        "reads": "int64",
        "writes": "int64",
        "userTime": "double",
        "systemTime": "double"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| statements[] | **[QueryStatement](#yandex.cloud.mdb.postgresql.v1.QueryStatement)**

List of SQL statements (queries). ||
|| nextPageToken | **string**

This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawStatementsRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest), use the `nextPageToken` as the value for the [ListRawStatementsRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListRawStatementsRequest) parameter in the next request. Each subsequent request will have its own `nextPageToken` to continue paging through the results. ||
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
|| queryId | **string**

Query ID. ||
|| planId | **string**

Query planning ID. ||
|#

## QueryStats {#yandex.cloud.mdb.postgresql.v1.QueryStats}

#|
||Field | Description ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of collecting statistics on planning and execution of queries. ||
|| query | **string**

Statement text. ||
|| normalizedPlan | **string**

Normalized query plan. ||
|| examplePlan | **string**

Example of a query execution plan (without normalization). ||
|| plans | **int64**

Number of times that a query was planned.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.41.9) parameter is enabled. ||
|| totalPlanTime | **double**

Total time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| minPlanTime | **double**

Minimum time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| maxPlanTime | **double**

Maximum time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| meanPlanTime | **double**

Average time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| stddevPlanTime | **double**

Population standard deviation of the time taken to plan a query, in milliseconds.

The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. ||
|| calls | **int64**

Number of times that a query was executed. ||
|| totalTime | **double**

Total time taken to execute a query, in milliseconds. ||
|| minTime | **double**

Minimum time taken to execute a query, in milliseconds. ||
|| maxTime | **double**

Maximum time taken to execute a query, in milliseconds. ||
|| meanTime | **double**

Average time taken to execute a query, in milliseconds. ||
|| stddevTime | **double**

Population standard deviation of the time taken to execute a query, in milliseconds. ||
|| rows | **int64**

Number of retrieved or affected rows. ||
|| sharedBlksHit | **int64**

Number of shared blocks that are hit from cache. ||
|| sharedBlksRead | **int64**

Number of read shared blocks. ||
|| sharedBlksDirtied | **int64**

Number of 'dirtied' shared blocks. ||
|| sharedBlksWritten | **int64**

Number of written shared blocks. ||
|| localBlksHit | **int64**

Number of local blocks that are hit from cache. ||
|| localBlksRead | **int64**

Number of read local blocks. ||
|| localBlksDirtied | **int64**

Number of 'dirtied' local blocks. ||
|| localBlksWritten | **int64**

Number of written local blocks. ||
|| tempBlksRead | **int64**

Number of read temporary blocks. ||
|| tempBlksWritten | **int64**

Number of written temporary blocks. ||
|| blkReadTime | **double**

Time taken to read data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-IO-TIMING) parameter is enabled. ||
|| blkWriteTime | **double**

Time taken to record data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| tempBlkReadTime | **double**

Time taken to read temporary data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| tempBlkWriteTime | **double**

Time taken to record temporary data blocks, in milliseconds.

The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. ||
|| walRecords | **int64**

Number of WAL records generated during a given period. ||
|| walFpi | **int64**

Number of WAL full page images generated during a given period. ||
|| walBytes | **int64**

Number of WAL logs generated during a given period, in bytes. ||
|| jitFunctions | **int64**

Number of JIT-compiled functions. ||
|| jitGenerationTime | **double**

Time taken to generate JIT code, in milliseconds. ||
|| jitInliningCount | **int64**

Number of times that functions have been inlined. ||
|| jitInliningTime | **double**

Time taken to inline functions, in milliseconds. ||
|| jitOptimizationCount | **int64**

Number of times that a query was optimized. ||
|| jitOptimizationTime | **double**

Time taken to optimize a query, in milliseconds. ||
|| jitEmissionCount | **int64**

Number of times that code was emitted. ||
|| jitEmissionTime | **double**

Time taken to emit code. ||
|| startupCost | **int64**

Cost of receiving a response to a query before the first row of the response is issued. ||
|| totalCost | **int64**

Cost of receiving a response to a query when all the rows of the response are issued. ||
|| planRows | **int64**

Expected number of rows that a given plan node should issue. ||
|| planWidth | **int64**

Expected average size of rows that a given plan node should issue. ||
|| reads | **int64**

Number of bytes that the filesystem layer has read. ||
|| writes | **int64**

Number of bytes that the filesystem layer has written. ||
|| userTime | **double**

User CPU time used. ||
|| systemTime | **double**

System CPU time used. ||
|#
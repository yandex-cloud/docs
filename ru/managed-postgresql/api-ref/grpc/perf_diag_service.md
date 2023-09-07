---
editable: false
sourcePath: en/_api-ref-grpc/managed-postgresql/api-ref/grpc/perf_diag_service.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService

A set of methods for PostgreSQL performance diagnostics.

| Call | Description |
| --- | --- |
| [ListRawSessionStates](#ListRawSessionStates) | Retrieves raw statistics on sessions. |
| [ListRawStatements](#ListRawStatements) | Retrieves statistics on planning and execution of SQL statements (queries). |

## Calls PerformanceDiagnosticsService {#calls}

## ListRawSessionStates {#ListRawSessionStates}

Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

**rpc ListRawSessionStates ([ListRawSessionStatesRequest](#ListRawSessionStatesRequest)) returns ([ListRawSessionStatesResponse](#ListRawSessionStatesResponse))**

### ListRawSessionStatesRequest {#ListRawSessionStatesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of a PostgreSQL cluster to request session statistics for. <br>To get a PostgreSQL cluster ID, use the [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). 
page_size | **int64**<br>The maximum number of results per page to return. If the number of the results is larger than `page_size`, the service returns [ListRawSessionStatesResponse.next_page_token](#ListRawSessionStatesResponse). You can use it to get the next page of the results in subsequent requests. The maximum value is 10000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRawSessionStatesResponse.next_page_token](#ListRawSessionStatesResponse) returned by the previous PostgreSQL session list request. The maximum string length in characters is 100.


### ListRawSessionStatesResponse {#ListRawSessionStatesResponse}

Field | Description
--- | ---
session_states[] | **[SessionState](#SessionState)**<br>List of PostgreSQL sessions. 
next_page_token | **string**<br>This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawSessionStatesRequest.page_size](#ListRawSessionStatesRequest), use the `next_page_token` as the value for the [ListRawSessionStatesRequest.page_token](#ListRawSessionStatesRequest) parameter in the next request. Each subsequent request will have its own `next_page_token` to continue paging through the results. 


### SessionState {#SessionState}

Field | Description
--- | ---
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of collecting statistics on sessions (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). 
host | **string**<br>Host of the connected client. 
pid | **int64**<br>Server process ID. For client connections, this is a client connection ID. 
database | **string**<br>Database ID. 
user | **string**<br>User ID. 
application_name | **string**<br>Application name on the connected client. 
backend_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when a given process was started. For client connections, this is the time when the client connected to the server. 
xact_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when a transaction of a given process was started. Returns [NULL] if no transaction is active. <br>If the currently active query is the first of its transaction, the value of this parameter is equal to the value of the `query_start` parameter. 
query_start | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the currently active query was started. <br>If the `state` parameter does not take the value [active], the parameter returns the time when the lastest query was started. 
state_change | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the `state` parameter was last changed. 
wait_event_type | **string**<br>Type of event for which the backend is waiting. Such an event is called a wait event. A backend refers to the process that maintains the client connection. <br>For the list of wait events, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. 
wait_event | **string**<br>Wait event name. <br>For the list of such names, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#WAIT-EVENT-ACTIVITY-TABLE). If the backend is not waiting for any event, the parameter returns [NULL]. 
state | **string**<br>Current backend state. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). 
query | **string**<br>Text of the most recent query. <br>If the `state` parameter takes the value [active], the parameter shows the currently executing query. For the rest of the states, the parameter shows the last query that was executed. By default, the query text is truncated to 1024 bytes. 
backend_type | **string**<br>Current backend type. For the list of possible values, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW). 
client_addr | **string**<br>IP address of the connected client. <br>The parameter returns [NULL] in the following cases: <ul><li>The client is connected via a Unix socket on the server. </li><li>A given process is internal (for example, autovacuum).</li></ul> 
client_hostname | **string**<br>Host name of the connected client (relevant for IP connections). 
client_port | **int64**<br>TCP port number that the client is using for communication with the server. <br>Returns [-1] if the client is connected via a Unix socket on the server. Returns [NULL] if a given process is internal (for example, autovacuum). 
backend_xid | **int64**<br>Top-level transaction ID, if any. 
backend_xmin | **int64**<br>Current [xmin horizon]. 
blocking_pids | **string**<br>Process IDs that are blocking a given server process ID. 
query_id | **string**<br>Query ID. 


## ListRawStatements {#ListRawStatements}

Retrieves statistics on planning and execution of SQL statements (queries).

**rpc ListRawStatements ([ListRawStatementsRequest](#ListRawStatementsRequest)) returns ([ListRawStatementsResponse](#ListRawStatementsResponse))**

### ListRawStatementsRequest {#ListRawStatementsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of a PostgreSQL cluster to request query statistics for. <br>To get a PostgreSQL cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Beginning of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End of the period for which you need to request data (in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format). 
page_size | **int64**<br>The maximum number of results per page to return. If the number of the results is larger than `page_size`, the service returns [ListRawStatementsResponse.next_page_token](#ListRawStatementsResponse). You can use it to get the next page of the results in subsequent requests. The maximum value is 10000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRawStatementsResponse.next_page_token](#ListRawStatementsResponse) returned by the previous SQL statement list request. The maximum string length in characters is 100.


### ListRawStatementsResponse {#ListRawStatementsResponse}

Field | Description
--- | ---
statements[] | **[QueryStatement](#QueryStatement)**<br>List of SQL statements (queries). 
next_page_token | **string**<br>This token allows you to get the next page of results when requesting the PostgreSQL session list. If the number of the results is larger than [ListRawStatementsRequest.page_size](#ListRawStatementsRequest), use the `next_page_token` as the value for the [ListRawStatementsRequest.page_token](#ListRawStatementsRequest) parameter in the next request. Each subsequent request will have its own `next_page_token` to continue paging through the results. 


### QueryStatement {#QueryStatement}

Field | Description
--- | ---
key | **[PrimaryKey](#PrimaryKey)**<br>Primary keys in tables with the statistics on planning and execution of queries. 
stats | **[QueryStats](#QueryStats)**<br>Statistics on planning and execution of queries. 


### PrimaryKey {#PrimaryKey}

Field | Description
--- | ---
host | **string**<br>Host of the connected client. 
user | **string**<br>User ID. 
database | **string**<br>Database ID. 
toplevel | **bool**<br>Returns [true] if a query is executed as a top-level SQL statement or if the [pg_stat_statements.track](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.41.9) parameter is set to the value [top]. 
query_id | **string**<br>Query ID. 
plan_id | **string**<br>Query planning ID. 


### QueryStats {#QueryStats}

Field | Description
--- | ---
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of collecting statistics on planning and execution of queries. 
query | **string**<br>Statement text. 
normalized_plan | **string**<br>Normalized query plan. 
example_plan | **string**<br>Example of a query execution plan (without normalization). 
plans | **int64**<br>Number of times that a query was planned. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.41.9) parameter is enabled. 
total_plan_time | **double**<br>Total time taken to plan a query, in milliseconds. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. 
min_plan_time | **double**<br>Minimum time taken to plan a query, in milliseconds. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. 
max_plan_time | **double**<br>Maximum time taken to plan a query, in milliseconds. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. 
mean_plan_time | **double**<br>Average time taken to plan a query, in milliseconds. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. 
stddev_plan_time | **double**<br>Population standard deviation of the time taken to plan a query, in milliseconds. <br>The parameter returns a non-zero value if the [pg_stat_statements.track_planning] parameter is enabled. 
calls | **int64**<br>Number of times that a query was executed. 
total_time | **double**<br>Total time taken to execute a query, in milliseconds. 
min_time | **double**<br>Minimum time taken to execute a query, in milliseconds. 
max_time | **double**<br>Maximum time taken to execute a query, in milliseconds. 
mean_time | **double**<br>Average time taken to execute a query, in milliseconds. 
stddev_time | **double**<br>Population standard deviation of the time taken to execute a query, in milliseconds. 
rows | **int64**<br>Number of retrieved or affected rows. 
shared_blks_hit | **int64**<br>Number of shared blocks that are hit from cache. 
shared_blks_read | **int64**<br>Number of read shared blocks. 
shared_blks_dirtied | **int64**<br>Number of 'dirtied' shared blocks. 
shared_blks_written | **int64**<br>Number of written shared blocks. 
local_blks_hit | **int64**<br>Number of local blocks that are hit from cache. 
local_blks_read | **int64**<br>Number of read local blocks. 
local_blks_dirtied | **int64**<br>Number of 'dirtied' local blocks. 
local_blks_written | **int64**<br>Number of written local blocks. 
temp_blks_read | **int64**<br>Number of read temporary blocks. 
temp_blks_written | **int64**<br>Number of written temporary blocks. 
blk_read_time | **double**<br>Time taken to read data blocks, in milliseconds. <br>The parameter returns a non-zero value if the [track_io_timing](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-IO-TIMING) parameter is enabled. 
blk_write_time | **double**<br>Time taken to record data blocks, in milliseconds. <br>The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. 
temp_blk_read_time | **double**<br>Time taken to read temporary data blocks, in milliseconds. <br>The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. 
temp_blk_write_time | **double**<br>Time taken to record temporary data blocks, in milliseconds. <br>The parameter returns a non-zero value if the [track_io_timing] parameter is enabled. 
wal_records | **int64**<br>Number of WAL records generated during a given period. 
wal_fpi | **int64**<br>Number of WAL full page images generated during a given period. 
wal_bytes | **int64**<br>Number of WAL logs generated during a given period, in bytes. 
jit_functions | **int64**<br>Number of JIT-compiled functions. 
jit_generation_time | **double**<br>Time taken to generate JIT code, in milliseconds. 
jit_inlining_count | **int64**<br>Number of times that functions have been inlined. 
jit_inlining_time | **double**<br>Time taken to inline functions, in milliseconds. 
jit_optimization_count | **int64**<br>Number of times that a query was optimized. 
jit_optimization_time | **double**<br>Time taken to optimize a query, in milliseconds. 
jit_emission_count | **int64**<br>Number of times that code was emitted. 
jit_emission_time | **double**<br>Time taken to emit code. 
startup_cost | **int64**<br>Cost of receiving a response to a query before the first row of the response is issued. 
total_cost | **int64**<br>Cost of receiving a response to a query when all the rows of the response are issued. 
plan_rows | **int64**<br>Expected number of rows that a given plan node should issue. 
plan_width | **int64**<br>Expected average size of rows that a given plan node should issue. 
reads | **int64**<br>Number of bytes that the filesystem layer has read. 
writes | **int64**<br>Number of bytes that the filesystem layer has written. 
user_time | **double**<br>User CPU time used. 
system_time | **double**<br>System CPU time used. 



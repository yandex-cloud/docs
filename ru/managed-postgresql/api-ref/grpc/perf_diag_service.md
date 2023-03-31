---
editable: false
sourcePath: en/_api-ref-grpc/managed-postgresql/api-ref/grpc/perf_diag_service.md
---

# Managed Service for PostgreSQL API, gRPC: PerformanceDiagnosticsService

A set of methods for getting PostgreSQL performance diagnostics.

| Call | Description |
| --- | --- |
| [ListRawStatements](#ListRawStatements) | Handlers for raw data export |

## Calls PerformanceDiagnosticsService {#calls}

## ListRawStatements {#ListRawStatements}

Handlers for raw data export

**rpc ListRawStatements ([ListRawStatementsRequest](#ListRawStatementsRequest)) returns ([ListRawStatementsResponse](#ListRawStatementsResponse))**

### ListRawStatementsRequest {#ListRawStatementsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to request statements history for. To get the PostgreSQL cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRawStatementsResponse.next_page_token](#ListRawStatementsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 10000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRawStatementsResponse.next_page_token](#ListRawStatementsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListRawStatementsResponse {#ListRawStatementsResponse}

Field | Description
--- | ---
statements[] | **[QueryStatement](#QueryStatement)**<br> 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRawStatementsRequest.page_size](#ListRawStatementsRequest), use the `next_page_token` as the value for the [ListRawStatementsRequest.page_token](#ListRawStatementsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### QueryStatement {#QueryStatement}

Field | Description
--- | ---
key | **[PrimaryKey](#PrimaryKey)**<br> 
stats | **[QueryStats](#QueryStats)**<br> 


### PrimaryKey {#PrimaryKey}

Field | Description
--- | ---
host | **string**<br> 
user | **string**<br> 
database | **string**<br> 
toplevel | **bool**<br> 
query_id | **string**<br> 
plan_id | **string**<br> 


### QueryStats {#QueryStats}

Field | Description
--- | ---
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
query | **string**<br> 
normalized_plan | **string**<br> 
example_plan | **string**<br> 
plans | **int64**<br> 
total_plan_time | **double**<br> 
min_plan_time | **double**<br> 
max_plan_time | **double**<br> 
mean_plan_time | **double**<br> 
stddev_plan_time | **double**<br> 
calls | **int64**<br> 
total_time | **double**<br> 
min_time | **double**<br> 
max_time | **double**<br> 
mean_time | **double**<br> 
stddev_time | **double**<br> 
rows | **int64**<br> 
shared_blks_hit | **int64**<br> 
shared_blks_read | **int64**<br> 
shared_blks_dirtied | **int64**<br> 
shared_blks_written | **int64**<br> 
local_blks_hit | **int64**<br> 
local_blks_read | **int64**<br> 
local_blks_dirtied | **int64**<br> 
local_blks_written | **int64**<br> 
temp_blks_read | **int64**<br> 
temp_blks_written | **int64**<br> 
blk_read_time | **double**<br> 
blk_write_time | **double**<br> 
temp_blk_read_time | **double**<br> 
temp_blk_write_time | **double**<br> 
wal_records | **int64**<br> 
wal_fpi | **int64**<br> 
wal_bytes | **int64**<br> 
jit_functions | **int64**<br> 
jit_generation_time | **double**<br> 
jit_inlining_count | **int64**<br> 
jit_inlining_time | **double**<br> 
jit_optimization_count | **int64**<br> 
jit_optimization_time | **double**<br> 
jit_emission_count | **int64**<br> 
jit_emission_time | **double**<br> 
startup_cost | **int64**<br> 
total_cost | **int64**<br> 
plan_rows | **int64**<br> 
plan_width | **int64**<br> 
reads | **int64**<br> 
writes | **int64**<br> 
user_time | **double**<br> 
system_time | **double**<br> 



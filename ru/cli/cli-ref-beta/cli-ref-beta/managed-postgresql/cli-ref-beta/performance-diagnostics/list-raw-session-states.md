---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-postgresql/cli-ref-beta/performance-diagnostics/list-raw-session-states.md
---

# yc beta managed-postgresql performance-diagnostics list-raw-session-states

Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

#### Command Usage

Syntax: 

`yc beta managed-postgresql performance-diagnostics list-raw-session-states <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of a PostgreSQL cluster to request session statistics for. To get a PostgreSQL cluster ID, use the [ClusterService.List] request.|
|`--from-time`|<b>`time`</b><br/>Beginning of the period for which you need to request data (in the RFC3339 text format). (RFC3339)|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of the results is larger than [page_size], the service returns [ListRawSessionStatesResponse.next_page_token]. You can use it to get the next page of the results in subsequent requests.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListRawSessionStatesResponse.next_page_token] returned by the previous PostgreSQL session list request.|
|`--to-time`|<b>`time`</b><br/>End of the period for which you need to request data (in the RFC3339 text format). (RFC3339)|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|

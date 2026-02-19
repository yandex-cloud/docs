---
editable: false
noIndex: true
---

# yc beta managed-postgresql performance-diagnostics list-raw-session-states

Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

#### Command Usage

Syntax:

`yc beta managed-postgresql performance-diagnostics list-raw-session-states <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of a PostgreSQL cluster to request session statistics for. To get a PostgreSQL cluster ID, use the [ClusterService.List] request. ||
|| `--from-time` | `time`

Beginning of the period for which you need to request data (in the RFC3339 text format). (RFC3339) ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of the results is larger than [page_size], the service returns [ListRawSessionStatesResponse.next_page_token]. You can use it to get the next page of the results in subsequent requests. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListRawSessionStatesResponse.next_page_token] returned by the previous PostgreSQL session list request. ||
|| `--to-time` | `time`

End of the period for which you need to request data (in the RFC3339 text format). (RFC3339) ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
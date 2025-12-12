---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-postgresql/cli-ref-beta/cluster/list-logs.md
---

# yc beta managed-postgresql cluster list-logs

Retrieves logs for the specified PostgreSQL cluster.

#### Command Usage

Syntax: 

`yc beta managed-postgresql cluster list-logs <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--always-next-page-token`|Always return 'next_page_token', even if current page is empty.|
|`--cluster-id`|<b>`string`</b><br/>ID of the PostgreSQL cluster to request logs for. To get the PostgreSQL cluster ID use a [ClusterService.List] request.|
|`--column-filter`|<b>`strings`</b><br/>Columns from the logs table to request. If no columns are specified, entire log records are returned.|
|`--from-time`|<b>`time`</b><br/>Start timestamp for the logs request, in RFC3339 text format. (RFC3339)|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListClusterLogsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListClusterLogsResponse.next_page_token] returned by the previous list request.|
|`--service-type`|<b>`enum`</b><br/>Type of the service to request logs about. Possible Values: 'postgresql', 'pooler'|
|`--to-time`|<b>`time`</b><br/>End timestamp for the logs request, in RFC3339 text format. (RFC3339)|

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

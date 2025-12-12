---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/cluster/list-logs.md
---

# yc beta managed-mysql cluster list-logs

Retrieves logs for a cluster.

#### Command Usage

Syntax: 

`yc beta managed-mysql cluster list-logs <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--always-next-page-token`|Option that controls the behavior of result pagination. If it is set to 'true', then [ListClusterLogsResponse.next_page_token] will always be returned, even if the current page is empty.|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to request logs for. To get this ID, make a [ClusterService.List] request.|
|`--column-filter`|<b>`strings`</b><br/>Columns from the logs table to request. If no columns are specified, complete log records are returned.|
|`--from-time`|<b>`time`</b><br/>Start timestamp for the logs request. The logs in the response will be within [from_time] to [to_time] range. (RFC3339)|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the API returns a [ListClusterLogsResponse.next_page_token] that can be used to get the next page of results in the subsequent [ClusterService.ListLogs] requests.|
|`--page-token`|<b>`string`</b><br/>Page token that can be used to iterate through multiple pages of results. To get the next page of results, set [page_token] to the [ListClusterLogsResponse.next_page_token] returned by the previous [ClusterService.ListLogs] request.|
|`--service-type`|<b>`enum`</b><br/>The log type. Possible Values: 'mysql-error', 'mysql-general', 'mysql-slow-query', 'mysql-audit'|
|`--to-time`|<b>`time`</b><br/>End timestamp for the logs request. The logs in the response will be within [from_time] to [to_time] range. (RFC3339)|

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

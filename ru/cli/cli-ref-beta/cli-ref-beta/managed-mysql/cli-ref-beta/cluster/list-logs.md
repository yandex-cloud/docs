---
editable: false
noIndex: true
---

# yc beta managed-mysql cluster list-logs

Retrieves logs for a cluster.
Alternatively, logs can be streamed using [StreamLogs].

#### Command Usage

Syntax:

`yc beta managed-mysql cluster list-logs <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--always-next-page-token` | Option that controls the behavior of result pagination. If it is set to 'true', then [ListClusterLogsResponse.next_page_token] will always be returned, even if the current page is empty. ||
|| `--cluster-id` | `string`

ID of the cluster to request logs for. To get this ID, make a [ClusterService.List] request. ||
|| `--column-filter` | `[]string`

Columns from the logs table to request. If no columns are specified, complete log records are returned. ||
|| `--from-time` | `time`

Start timestamp for the logs request. The logs in the response will be within [from_time] to [to_time] range. (RFC3339) ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the API returns a [ListClusterLogsResponse.next_page_token] that can be used to get the next page of results in the subsequent [ClusterService.ListLogs] requests. ||
|| `--page-token` | `string`

Page token that can be used to iterate through multiple pages of results. To get the next page of results, set [page_token] to the [ListClusterLogsResponse.next_page_token] returned by the previous [ClusterService.ListLogs] request. ||
|| `--service-type` | `enum`

The log type. Possible Values: 'mysql-error', 'mysql-general', 'mysql-slow-query', 'mysql-audit' ||
|| `--to-time` | `time`

End timestamp for the logs request. The logs in the response will be within [from_time] to [to_time] range. (RFC3339) ||
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
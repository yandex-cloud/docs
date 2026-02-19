---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster list-logs

Retrieves logs for the specified OpenSearch cluster.
For detailed description, see the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developer's guide.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster list-logs <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--always-next-page-token` | The service always returns a [ListClusterLogsResponse.next_page_token], even if the current page is empty. ||
|| `--cluster-id` | `string`

ID of the OpenSearch cluster to request logs for. To get the OpenSearch cluster ID use a [ClusterService.List] request. ||
|| `--column-filter` | `[]string`

Columns from log table to request. If no columns are specified, entire log records are returned. ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression must specify: 1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field. 2. A conditional operator. Can be either '=' or '!=' for single values, 'IN' or 'NOT IN' for lists of values. 3. A value. Must be 1-63 characters long and match the regular expression '^[a-z0-9.-]{1,61}$'. Examples of a filter: * 'message.hostname='node1.db.cloud.yandex.net''; * 'message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"'. ||
|| `--from-time` | `time`

Start timestamp for the logs request. (RFC3339) ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListClusterLogsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListClusterLogsResponse.next_page_token] returned by the previous list request. ||
|| `--service-type` | `enum`

Type of the service to request logs about. Possible Values: 'opensearch', 'dashboards' ||
|| `--to-time` | `time`

End timestamp for the logs request. (RFC3339) ||
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
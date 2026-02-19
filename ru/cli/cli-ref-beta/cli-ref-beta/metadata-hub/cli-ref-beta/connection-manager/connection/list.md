---
editable: false
noIndex: true
---

# yc beta metadata-hub connection-manager connection list

Retrieves the list of connections in the specified folder.

#### Command Usage

Syntax:

`yc beta metadata-hub connection-manager connection list <AUTHOR-ID>`

#### Flags

#|
||Flag | Description ||
|| `--author-id` | `string`

ID of the connection author to filter by. ||
|| `--db-type` | `enum`

Filter connections by database type. Possible Values: 'postgresql', 'mysql', 'clickhouse', 'mongodb', 'kafka', 'redis', 'opensearch', 'trino', 'valkey', 'greenplum', 'storedoc' ||
|| `--folder-id` | `string`

ID of the folder to list connections in. ||
|| `--is-manual` | Filter by whether connections are manually configured. ||
|| `--is-onpremise` | Filter by whether connections are on-premise. ||
|| `--mdb-cluster-id` | `string`

ID of the managed database cluster to filter connections. ||
|| `--name-pattern-or-id` | `string`

Filter by connection name pattern or exact ID. ||
|| `--page-size` | `int`

Maximum number of results per page. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ListConnectionResponse.next_page_token] returned by a previous list request. ||
|| `--with-can-use` | Include only connections that the current user can use. ||
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
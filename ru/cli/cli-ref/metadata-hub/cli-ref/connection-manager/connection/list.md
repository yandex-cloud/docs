---
editable: false
sourcePath: en/_cli-ref/cli-ref/metadata-hub/cli-ref/connection-manager/connection/list.md
---

# yc metadata-hub connection-manager connection list

List connections

#### Command Usage

Syntax:

`yc metadata-hub connection-manager connection list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--author-id` | `string`

Identifier of the author. ||
|| `--folder-id` | `string`

Identifier of the folder. ||
|| `--mdb-cluster-id` | `string`

Identifier of the mdb cluster. ||
|| `--name-pattern-or-id` | `string`

Name pattern or indetifier. ||
|| `--db-type` | `string`

Database type. Values: 'postgresql', 'mysql', 'clickhouse', 'mongodb', 'kafka', 'redis', 'opensearch', 'trino', 'valkey', 'greenplum', 'storedoc' ||
|| `--with-can-use` | Include usage permissions in the response (whether the subject can use or only list the connection). ||
|| `--is-on-premise` | Filters connections to show only on-premise (true) or cloud-managed (false) deployments. ||
|| `--is-manual` | Filter connections to show only manual (true), only automatic (false). ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
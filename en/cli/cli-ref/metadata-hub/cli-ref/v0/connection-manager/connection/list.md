---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/metadata-hub/cli-ref/v0/connection-manager/connection/list/
---

# yc metadata-hub v0 connection-manager connection list

List connections

#### Command Usage

Syntax:

`yc metadata-hub v0 connection-manager connection list [Flags...] [Global Flags...]`

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

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
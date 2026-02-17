---
editable: false
---

# yc managed-clickhouse user add-quota

Add quota to a ClickHouse user.

#### Command Usage

Syntax:

`yc managed-clickhouse user add-quota <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--interval` | ```duration|int64```

Duration of interval for quota in milliseconds. Possible to use time units - "1m30s". Minimal value is 1 second. ||
|| `--queries` | `int`

The total number of queries. 0 - unlimited. ||
|| `--errors` | `int`

The number of queries that threw exception. 0 - unlimited. ||
|| `--result-rows` | `int`

The total number of rows given as the result. 0 - unlimited. ||
|| `--read-rows` | `int`

The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited. ||
|| `--execution-time` | ```duration|int64```

The total query execution time, in milliseconds (wall time). Possible to use time units - "1m30s". 0 - unlimited. ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster. ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
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
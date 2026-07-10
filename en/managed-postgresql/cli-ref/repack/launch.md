---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-postgresql/cli-ref/repack/launch/
---

# yc managed-postgresql repack launch

Launch a new pg_repack task in the specified PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-postgresql repack launch [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

PostgreSQL cluster id. ||
|| `--cluster-name` | `string`

PostgreSQL cluster name. ||
|| `--database` | `string`

Name of the database to run pg_repack in. ||
|| `--type` | `string`

Type of objects to repack. Values: 'index', 'table'. ||
|| `--target` | `value[,value]`

Object to repack as a PostgreSQL qualified name: 'schema.table', 'schema.*' for all tables in the schema, or 'table' (defaults to the 'public' schema). Quote identifiers to preserve case or special characters. May be repeated. ||
|| `--wait-timeout` | `int`

pg_repack option: timeout (in seconds) to cancel other backends on conflict. ||
|| `--jobs` | `int`

pg_repack option: number of parallel jobs to use for each table. ||
|| `--start-timeout` | `duration`

Initial timeout to tell a pg_repack task that finished immediately from a still-running one. Defaults to 1 second. ||
|| `--launch-id` | `string`

UUID identifying this pg_repack task. Generated automatically if not specified. ||
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
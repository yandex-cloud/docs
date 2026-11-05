[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [managed-postgresql](../index.md) > [repack](index.md) > launch

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
|| `--target` | `[]string`

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

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
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
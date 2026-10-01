[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [managed-trino](../../index.md) > [catalog](../index.md) > [create](index.md) > greenplum

# yc managed-trino catalog create greenplum

Create Greenplum catalog

#### Command Usage

Syntax:

`yc managed-trino catalog create greenplum <CATALOG-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Trino cluster id. ||
|| `--cluster-name` | `string`

Trino cluster name. ||
|| `--name` | `string`

Name of the Trino catalog. ||
|| `--description` | `string`

Description of the catalog. ||
|| `--labels` | `key=value[,key=value...]`

A list of Trino catalog labels as key-value pairs. ||
|| `--on-premise-connection-url` | `string`

OnPremise connection URL. ||
|| `--on-premise-user-name` | `string`

OnPremise connection username. ||
|| `--on-premise-password` | `string`

OnPremise connection password. ||
|| `--connection-manager-connection-id` | `string`

ConnectionManager connection ID. ||
|| `--connection-manager-database` | `string`

ConnectionManager connection database. ||
|| `--connection-manager-connection-properties` | `key=value[,key=value...]`

ConnectionManager connection database. ||
|| `--additional-properties` | `key=value[,key=value...]`

A list of Trino catalog additional properties as key-value pairs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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
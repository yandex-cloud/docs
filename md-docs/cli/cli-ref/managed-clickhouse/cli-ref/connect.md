[Документация Yandex Cloud](../../../../index.md) > [Интерфейс командной строки](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [managed-clickhouse](index.md) > connect

# yc managed-clickhouse connect

Connect to ClickHouse cluster with iam-auth

#### Command Usage

Syntax:

`yc managed-clickhouse connect <CLUSTER-NAME>|<CLUSTER-ID> [Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--db` | `string`

The name of the database to connect to. ||
|| `--host` | `string`

FQDN of a specific ClickHouse host to connect to. If omitted, a random ALIVE host is picked from the cluster. ||
|| `--port` | `int`

Native protocol port. Defaults to 9440 (secure) or 9000 (plain). ||
|| `--secure` | Use TLS for the native protocol connection. ||
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
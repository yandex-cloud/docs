[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [managed-mysql](../../index.md) > [v0](../index.md) > [backup-retention-policy](index.md) > create

# yc managed-mysql v0 backup-retention-policy create

Create backup retention policy for the specified MySQL cluster

#### Command Usage

Syntax:

`yc managed-mysql backup-retention-policy create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

MySQL cluster id. ||
|| `--cluster-name` | `string`

MySQL cluster name. ||
|| `--policy-name` | `string`

Backup retention policy name. ||
|| `--day-of-month` | `string`

Crontab day of month (e.g. '1' or '*'). ||
|| `--month` | `string`

Crontab month (e.g. '1' or '*'). ||
|| `--day-of-week` | `string`

Crontab day of week (e.g. '1' or '*'). ||
|| `--retain-for-days` | `int`

Backup retention period in days (7-1095). ||
|| `--description` | `string`

Backup retention policy description. ||
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
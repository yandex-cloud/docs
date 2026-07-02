[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [backup](../../index.md) > [v0](../index.md) > backup > Overview

# yc backup v0 backup

Manage backups

#### Command Usage

Syntax:

`yc backup backup <command>`

Aliases:

- `backups`

#### Command Tree

- [yc backup v0 backup batch-delete](batch-delete.md) — Batch deletion of all backups from arhcive

- [yc backup v0 backup delete](delete.md) — Delete backup

- [yc backup v0 backup get](get.md) — Get full information about backup

- [yc backup v0 backup list](list.md) — Lists available backups

- [yc backup v0 backup list-archives](list-archives.md) — Lists available archives

- [yc backup v0 backup recover](recover.md) — Start recovery of the backup

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
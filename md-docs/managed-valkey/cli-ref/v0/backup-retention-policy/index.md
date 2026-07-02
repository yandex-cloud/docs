[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Valkey™](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > backup-retention-policy > Overview

# yc managed-redis v0 backup-retention-policy

Manage Redis backup long-term retention policies

#### Command Usage

Syntax:

`yc managed-redis backup-retention-policy <command>`

Aliases:

- `backup-retention-policy`

- `backup-retention-policies`

#### Command Tree

- [yc managed-redis v0 backup-retention-policy create](create.md) — Create new backup retention policy

- [yc managed-redis v0 backup-retention-policy delete](delete.md) — Delete specific backup retention policy

- [yc managed-redis v0 backup-retention-policy list](list.md) — List available backup retention policies

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
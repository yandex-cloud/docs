[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [organization-manager](../../index.md) > [idp](../index.md) > synchronization-settings > Overview

# yc organization-manager idp synchronization-settings

Manage synchronization settings

#### Command Usage

Syntax:

`yc organization-manager idp synchronization-settings <command>`

Aliases:

- `sync-settings`

#### Command Tree

- [yc organization-manager idp synchronization-settings create](create.md) — Create synchronization settings for the specified subject container

- [yc organization-manager idp synchronization-settings delete](delete.md) — Delete synchronization settings for the specified subject container

- [yc organization-manager idp synchronization-settings get](get.md) — Show synchronization settings for the specified subject container

- [yc organization-manager idp synchronization-settings list-supported-attributes](list-supported-attributes.md) — List supported attributes for synchronization mappings

- [yc organization-manager idp synchronization-settings reset-replication-token](reset-replication-token.md) — Reset the replication token for the specified subject container

- [yc organization-manager idp synchronization-settings update](update.md) — Update synchronization settings for the specified subject container

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
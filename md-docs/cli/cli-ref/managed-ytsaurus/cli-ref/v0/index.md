[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [managed-ytsaurus](../index.md) > v0 > Overview

# yc managed-ytsaurus v0

Manage YTsaurus clusters.

#### Command Usage

Syntax:

`yc managed-ytsaurus v0 <group>`

#### Command Tree

- [yc managed-ytsaurus v0 cluster](cluster/index.md) — Manage YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster delete](cluster/delete.md) — Delete the specified YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster get](cluster/get.md) — Show information about the specified YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster get-configuration](cluster/get-configuration.md) — Get configuration of the specified YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster list](cluster/list.md) — List YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster start](cluster/start.md) — Start the specified YTsaurus clusters.

  - [yc managed-ytsaurus v0 cluster stop](cluster/stop.md) — Stop the specified YTsaurus clusters.

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
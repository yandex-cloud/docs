[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [managed-metastore](../../index.md) > [v0](../index.md) > cluster > Overview

# yc managed-metastore v0 cluster

Manage Metastore clusters

#### Command Usage

Syntax:

`yc managed-metastore v0 cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-metastore v0 cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Metastore cluster

- [yc managed-metastore v0 cluster create](create.md) — Create Metastore cluster

- [yc managed-metastore v0 cluster delete](delete.md) — Delete the specified Metastore cluster

- [yc managed-metastore v0 cluster export-data](export-data.md) — Export data from the specified Metastore cluster

- [yc managed-metastore v0 cluster get](get.md) — Show information about the specified Metastore cluster

- [yc managed-metastore v0 cluster import-data](import-data.md) — Import data to the specified Metastore cluster

- [yc managed-metastore v0 cluster list](list.md) — List Metastore clusters

- [yc managed-metastore v0 cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Metastore cluster

- [yc managed-metastore v0 cluster list-operations](list-operations.md) — List operations for the specified Metastore cluster

- [yc managed-metastore v0 cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Metastore cluster

- [yc managed-metastore v0 cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Metastore cluster and delete all existing access bindings if there were any

- [yc managed-metastore v0 cluster start](start.md) — Start the specified Metastore cluster

- [yc managed-metastore v0 cluster stop](stop.md) — Stop the specified Metastore cluster

- [yc managed-metastore v0 cluster update](update.md) — Update the specified Metastore cluster

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
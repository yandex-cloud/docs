[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [compute](../../index.md) > [v0](../index.md) > snapshot > Overview

# yc compute v0 snapshot

Manage snapshots

#### Command Usage

Syntax:

`yc compute snapshot <command>`

Aliases:

- `snapshots`

#### Command Tree

- [yc compute v0 snapshot add-access-binding](add-access-binding.md) — Add access binding for the specified snapshot

- [yc compute v0 snapshot add-labels](add-labels.md) — Add labels to specified snapshot

- [yc compute v0 snapshot create](create.md) — Create a snapshot of the specified disk

- [yc compute v0 snapshot delete](delete.md) — Delete the specified snapshot

- [yc compute v0 snapshot get](get.md) — Show information about the specified snapshot

- [yc compute v0 snapshot list](list.md) — List snapshots

- [yc compute v0 snapshot list-access-bindings](list-access-bindings.md) — List access bindings for the specified snapshot

- [yc compute v0 snapshot list-operations](list-operations.md) — List operations for the specified snapshot

- [yc compute v0 snapshot remove-access-binding](remove-access-binding.md) — Remove access binding for the specified snapshot

- [yc compute v0 snapshot remove-labels](remove-labels.md) — Remove labels from specified snapshot

- [yc compute v0 snapshot set-access-bindings](set-access-bindings.md) — Set access bindings for the specified snapshot and delete all existing access bindings if there were any

- [yc compute v0 snapshot update](update.md) — Update the specified snapshot

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
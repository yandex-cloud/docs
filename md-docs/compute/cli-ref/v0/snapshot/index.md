[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > snapshot > Overview

# yc compute v0 snapshot

Manage snapshots

#### Command Usage

Syntax:

`yc compute v0 snapshot <command>`

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
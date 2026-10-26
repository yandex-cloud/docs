[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [compute](../index.md) > host-group > Overview

# yc compute host-group

Manage host groups

#### Command Usage

Syntax:

`yc compute host-group <command>`

Aliases:

- `host-groups`

- `hg`

#### Command Tree

- [yc compute host-group add-access-binding](add-access-binding.md) — Add access binding for the specified host group

- [yc compute host-group add-labels](add-labels.md) — Add labels to the specified host group

- [yc compute host-group create](create.md) — Create a host group

- [yc compute host-group delete](delete.md) — Delete the specified host group

- [yc compute host-group get](get.md) — Show information about the specified host group

- [yc compute host-group list](list.md) — List host groups

- [yc compute host-group list-access-bindings](list-access-bindings.md) — List access bindings for the specified host group

- [yc compute host-group list-hosts](list-hosts.md) — List hosts of the specified host group

- [yc compute host-group list-instances](list-instances.md) — List instances of the specified host group

- [yc compute host-group list-operations](list-operations.md) — List operations for the specified host group

- [yc compute host-group remove-access-binding](remove-access-binding.md) — Remove access binding for the specified host group

- [yc compute host-group remove-labels](remove-labels.md) — Remove labels from the specified host group

- [yc compute host-group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified host group and delete all existing access bindings if there were any

- [yc compute host-group update](update.md) — Update the specified host group

- [yc compute host-group update-host](update-host.md) — Update host of the specified host group

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
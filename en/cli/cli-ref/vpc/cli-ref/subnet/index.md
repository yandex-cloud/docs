---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/subnet/index.md
---

# yc vpc subnet

Manage subnets.

#### Command Usage

Syntax:

`yc vpc subnet <command>`

Aliases:

- `subnets`

#### Command Tree

- [yc vpc subnet add-labels](add-labels.md) — Assign labels to a subnet.

- [yc vpc subnet add-range](add-range.md) — Add CIDR range to a subnet.

- [yc vpc subnet create](create.md) — Create a subnet in the specified network.

- [yc vpc subnet delete](delete.md) — Delete a subnet.

- [yc vpc subnet get](get.md) — Get information about a subnet.

- [yc vpc subnet list](list.md) — List subnets in a folder.

- [yc vpc subnet list-operations](list-operations.md) — List operations for a subnet.

- [yc vpc subnet list-used-addresses](list-used-addresses.md) — List used addresses in subnet.

- [yc vpc subnet move](move.md) — Move a subnet to another folder.

- [yc vpc subnet relocate](relocate.md) — Relocate a subnet to another zone.

- [yc vpc subnet remove-labels](remove-labels.md) — Remove labels from a subnet.

- [yc vpc subnet remove-range](remove-range.md) — Remove CIDR range from a subnet.

- [yc vpc subnet update](update.md) — Modify configuration or attributes of a subnet.

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
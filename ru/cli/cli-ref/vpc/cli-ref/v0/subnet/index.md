---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/vpc/cli-ref/v0/subnet/
---

# yc vpc v0 subnet

Manage subnets.

#### Command Usage

Syntax:

`yc vpc v0 subnet <command>`

Aliases:

- `subnets`

#### Command Tree

- [yc vpc v0 subnet add-labels](add-labels.md) — Assign labels to a subnet.

- [yc vpc v0 subnet add-range](add-range.md) — Add CIDR range to a subnet.

- [yc vpc v0 subnet create](create.md) — Create a subnet in the specified network.

- [yc vpc v0 subnet delete](delete.md) — Delete a subnet.

- [yc vpc v0 subnet get](get.md) — Get information about a subnet.

- [yc vpc v0 subnet list](list.md) — List subnets in a folder.

- [yc vpc v0 subnet list-operations](list-operations.md) — List operations for a subnet.

- [yc vpc v0 subnet list-used-addresses](list-used-addresses.md) — List used addresses in subnet.

- [yc vpc v0 subnet move](move.md) — Move a subnet to another folder.

- [yc vpc v0 subnet relocate](relocate.md) — Relocate a subnet to another zone.

- [yc vpc v0 subnet remove-labels](remove-labels.md) — Remove labels from a subnet.

- [yc vpc v0 subnet remove-range](remove-range.md) — Remove CIDR range from a subnet.

- [yc vpc v0 subnet update](update.md) — Modify configuration or attributes of a subnet.

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
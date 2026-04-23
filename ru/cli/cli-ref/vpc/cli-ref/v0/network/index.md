---
editable: false
---

# yc vpc v0 network

Manage networks.

#### Command Usage

Syntax:

`yc vpc network <command>`

Aliases:

- `networks`

- `net`

#### Command Tree

- [yc vpc v0 network add-labels](add-labels.md) — Assign labels to a network.

- [yc vpc v0 network create](create.md) — Create a network.

- [yc vpc v0 network delete](delete.md) — Delete a network.

- [yc vpc v0 network get](get.md) — Get information about a network.

- [yc vpc v0 network list](list.md) — List networks in a folder.

- [yc vpc v0 network list-operations](list-operations.md) — List operations for a network.

- [yc vpc v0 network list-route-tables](list-route-tables.md) — List route tables in a network.

- [yc vpc v0 network list-security-groups](list-security-groups.md) — List security groups in a network.

- [yc vpc v0 network list-subnets](list-subnets.md) — List subnets in a network.

- [yc vpc v0 network move](move.md) — Move a network to another folder.

- [yc vpc v0 network remove-labels](remove-labels.md) — Remove labels from a network.

- [yc vpc v0 network update](update.md) — Modify configuration or attributes of a network.

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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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
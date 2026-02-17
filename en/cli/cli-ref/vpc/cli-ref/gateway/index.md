---
editable: false
---

# yc vpc gateway

Manage gateways.

#### Command Usage

Syntax:

`yc vpc gateway <command>`

Aliases:

- `gateways`

- `gw`

#### Command Tree

- [yc vpc gateway add-labels](add-labels.md) — Assign labels to a gateway.

- [yc vpc gateway create](create.md) — Create a gateway.

- [yc vpc gateway delete](delete.md) — Delete a gateway.

- [yc vpc gateway get](get.md) — Get information about a gateway.

- [yc vpc gateway list](list.md) — List gateways in a folder.

- [yc vpc gateway list-operations](list-operations.md) — List operations for a gateway.

- [yc vpc gateway move](move.md) — Move a gateway to another folder.

- [yc vpc gateway remove-labels](remove-labels.md) — Remove labels from a gateway.

- [yc vpc gateway update](update.md) — Modify configuration or attributes of a gateway.

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
---
editable: false
---

# yc cic trunk-connection

[PREVIEW] Manage trunk connections.

#### Command Usage

Syntax:

`yc cic trunk-connection <command>`

Aliases:

- `trunk-connections`

- `trunk`

- `tc`

#### Command Tree

- [yc cic trunk-connection add-labels](add-labels.md) — Add labels to a trunk connection.

- [yc cic trunk-connection create](create.md) — Create a trunk connection.

- [yc cic trunk-connection delete](delete.md) — Delete a trunk connection.

- [yc cic trunk-connection get](get.md) — Get information about a trunk connection.

- [yc cic trunk-connection list](list.md) — List trunk connections in a folder.

- [yc cic trunk-connection list-operations](list-operations.md) — List operations for a trunk connection.

- [yc cic trunk-connection move](move.md) — Move the specified trunk connection into the folder

- [yc cic trunk-connection remove-labels](remove-labels.md) — Remove labels from a trunk connection.

- [yc cic trunk-connection update](update.md) — Modify configuration or attributes of a trunk connection.

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
---
editable: false
---

# yc desktops group

[PREVIEW] Manage desktop groups

#### Command Usage

Syntax:

`yc desktops group <command>`

#### Command Tree

- [yc desktops group add-access-bindings](add-access-bindings.md) — Add access binding for the specified desktop group

- [yc desktops group create](create.md) — Create a desktop group

- [yc desktops group delete](delete.md) — Delete the specified desktop group

- [yc desktops group get](get.md) — Get information about a desktop group

- [yc desktops group list](list.md) — List desktops

- [yc desktops group list-access-bindings](list-access-bindings.md) — List access bindings for the specified desktop group

- [yc desktops group list-desktops](list-desktops.md) — List desktops of the specified desktop group

- [yc desktops group list-operations](list-operations.md) — List operations for the specified desktop group

- [yc desktops group remove-access-bindings](remove-access-bindings.md) — Remove access binding for the specified desktop group

- [yc desktops group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified desktop group and delete all existing access bindings if there were any

- [yc desktops group update](update.md) — Update desktop group

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
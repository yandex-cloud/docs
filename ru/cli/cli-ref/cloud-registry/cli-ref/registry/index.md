---
editable: false
---

# yc cloud-registry registry

[PREVIEW] Manage registries

#### Command Usage

Syntax:

`yc cloud-registry registry <command>`

#### Command Tree

- [yc cloud-registry registry add-access-binding](add-access-binding.md) — Add access binding for the specified registry

- [yc cloud-registry registry add-ip-permissions](add-ip-permissions.md) — Add ip permissions for the specified registry

- [yc cloud-registry registry create](create.md) — Creates a registry in the specified folder

- [yc cloud-registry registry delete](delete.md) — Deletes the specified registry

- [yc cloud-registry registry force-delete](force-delete.md) — Deletes the specified registry

- [yc cloud-registry registry get](get.md) — Returns the specified Registry

- [yc cloud-registry registry list](list.md) — Retrieves the list of Registry resources

- [yc cloud-registry registry list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified registry

- [yc cloud-registry registry list-artifacts](list-artifacts.md) — Retrieves the list of Registry artifact resources in the specified registry

- [yc cloud-registry registry list-ip-permissions](list-ip-permissions.md) — List ip permissions for the specified registry

- [yc cloud-registry registry remove-access-binding](remove-access-binding.md) — Remove access binding for the specified registry

- [yc cloud-registry registry remove-ip-permissions](remove-ip-permissions.md) — Remove ip permissions for the specified registry

- [yc cloud-registry registry set-access-bindings](set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any

- [yc cloud-registry registry set-ip-permissions](set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any

- [yc cloud-registry registry update](update.md) — Updates the specified registry

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
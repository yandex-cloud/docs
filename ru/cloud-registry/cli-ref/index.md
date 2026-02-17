---
editable: false
---

# yc cloud-registry

[PREVIEW] Manage CloudRegistry resources

#### Command Usage

Syntax:

`yc cloud-registry <group|command>`

#### Command Tree

- [yc cloud-registry configure-docker](configure-docker.md) — 

- [yc cloud-registry artifact](artifact/index.md) — [PREVIEW] Manage artifacts

  - [yc cloud-registry artifact delete](artifact/delete.md) — Delete the specified registry artifact

  - [yc cloud-registry artifact get](artifact/get.md) — Get information about the artifact

- [yc cloud-registry registry](registry/index.md) — [PREVIEW] Manage registries

  - [yc cloud-registry registry add-access-binding](registry/add-access-binding.md) — Add access binding for the specified registry

  - [yc cloud-registry registry add-ip-permissions](registry/add-ip-permissions.md) — Add ip permissions for the specified registry

  - [yc cloud-registry registry create](registry/create.md) — Creates a registry in the specified folder

  - [yc cloud-registry registry delete](registry/delete.md) — Deletes the specified registry

  - [yc cloud-registry registry force-delete](registry/force-delete.md) — Deletes the specified registry

  - [yc cloud-registry registry get](registry/get.md) — Returns the specified Registry

  - [yc cloud-registry registry list](registry/list.md) — Retrieves the list of Registry resources

  - [yc cloud-registry registry list-access-bindings](registry/list-access-bindings.md) — Lists access bindings for the specified registry

  - [yc cloud-registry registry list-artifacts](registry/list-artifacts.md) — Retrieves the list of Registry artifact resources in the specified registry

  - [yc cloud-registry registry list-ip-permissions](registry/list-ip-permissions.md) — List ip permissions for the specified registry

  - [yc cloud-registry registry remove-access-binding](registry/remove-access-binding.md) — Remove access binding for the specified registry

  - [yc cloud-registry registry remove-ip-permissions](registry/remove-ip-permissions.md) — Remove ip permissions for the specified registry

  - [yc cloud-registry registry set-access-bindings](registry/set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any

  - [yc cloud-registry registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any

  - [yc cloud-registry registry update](registry/update.md) — Updates the specified registry

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
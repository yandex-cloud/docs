---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloud-registry/cli-ref/v0/index
editable: false
---

# yc cloud-registry v0

[PREVIEW] Manage CloudRegistry resources

#### Command Usage

Syntax:

`yc cloud-registry v0 <group|command>`

#### Command Tree

- [yc cloud-registry v0 configure-docker](configure-docker.md) — 

- [yc cloud-registry v0 artifact](artifact/index.md) — [PREVIEW] Manage artifacts

  - [yc cloud-registry v0 artifact add-access-binding](artifact/add-access-binding.md) — Add access binding for the specified artifact

  - [yc cloud-registry v0 artifact delete](artifact/delete.md) — Delete the specified registry artifact

  - [yc cloud-registry v0 artifact get](artifact/get.md) — Get information about the artifact

  - [yc cloud-registry v0 artifact get-by-path](artifact/get-by-path.md) — Get information about the artifact by path

  - [yc cloud-registry v0 artifact list-access-bindings](artifact/list-access-bindings.md) — Lists access bindings for the specified artifact

  - [yc cloud-registry v0 artifact remove-access-binding](artifact/remove-access-binding.md) — Remove access binding for the specified artifact

  - [yc cloud-registry v0 artifact set-access-bindings](artifact/set-access-bindings.md) — Set access bindings for the specified artifact and remove existing ones

- [yc cloud-registry v0 registry](registry/index.md) — [PREVIEW] Manage registries

  - [yc cloud-registry v0 registry add-access-binding](registry/add-access-binding.md) — Add access binding for the specified registry

  - [yc cloud-registry v0 registry add-ip-permissions](registry/add-ip-permissions.md) — Add ip permissions for the specified registry

  - [yc cloud-registry v0 registry create](registry/create.md) — Creates a registry in the specified folder

  - [yc cloud-registry v0 registry delete](registry/delete.md) — Deletes the specified registry

  - [yc cloud-registry v0 registry force-delete](registry/force-delete.md) — Deletes the specified registry

  - [yc cloud-registry v0 registry get](registry/get.md) — Returns the specified Registry

  - [yc cloud-registry v0 registry list](registry/list.md) — Retrieves the list of Registry resources

  - [yc cloud-registry v0 registry list-access-bindings](registry/list-access-bindings.md) — Lists access bindings for the specified registry

  - [yc cloud-registry v0 registry list-artifacts](registry/list-artifacts.md) — Retrieves the list of Registry artifact resources in the specified registry

  - [yc cloud-registry v0 registry list-ip-permissions](registry/list-ip-permissions.md) — List ip permissions for the specified registry

  - [yc cloud-registry v0 registry remove-access-binding](registry/remove-access-binding.md) — Remove access binding for the specified registry

  - [yc cloud-registry v0 registry remove-ip-permissions](registry/remove-ip-permissions.md) — Remove ip permissions for the specified registry

  - [yc cloud-registry v0 registry set-access-bindings](registry/set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any

  - [yc cloud-registry v0 registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any

  - [yc cloud-registry v0 registry update](registry/update.md) — Updates the specified registry

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

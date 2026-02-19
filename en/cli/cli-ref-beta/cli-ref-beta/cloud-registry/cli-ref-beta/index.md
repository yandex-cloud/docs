---
editable: false
noIndex: true
---

# yc beta cloud-registry

[PREVIEW] Manage Cloud Registry resources

#### Command Usage

Syntax:

`yc beta cloud-registry <group>`

#### Command Tree

- [yc beta cloud-registry artifact](artifact/index.md) — A set of methods for managing Artifacts.

  - [yc beta cloud-registry artifact delete](artifact/delete.md) — Deletes the specified artifact.

  - [yc beta cloud-registry artifact get](artifact/get.md) — Returns the specified artifact resource.

  - [yc beta cloud-registry artifact list-access-bindings](artifact/list-access-bindings.md) — access bindings

  - [yc beta cloud-registry artifact set-access-bindings](artifact/set-access-bindings.md) — Sets access bindings for the specified artifact (folder, package, artifact, etc).

  - [yc beta cloud-registry artifact update-access-bindings](artifact/update-access-bindings.md) — Updates access bindings for the specified artifact (folder, package, artifact, etc).

- [yc beta cloud-registry lifecycle-policy](lifecycle-policy/index.md) — A set of methods for managing LifecyclePolicy resources.

  - [yc beta cloud-registry lifecycle-policy change-state](lifecycle-policy/change-state.md) — Changes the state of the specified lifecycle policy.

  - [yc beta cloud-registry lifecycle-policy create](lifecycle-policy/create.md) — Creates a lifecycle policy in the specified registry.

  - [yc beta cloud-registry lifecycle-policy delete](lifecycle-policy/delete.md) — Deletes the specified lifecycle policy.

  - [yc beta cloud-registry lifecycle-policy get](lifecycle-policy/get.md) — Returns the specified lifecycle policy.

  - [yc beta cloud-registry lifecycle-policy list](lifecycle-policy/list.md) — Retrieves the list of lifecycle policies in the specified registry.

  - [yc beta cloud-registry lifecycle-policy update](lifecycle-policy/update.md) — Updates the specified lifecycle policy.

- [yc beta cloud-registry registry](registry/index.md) — A set of methods for managing Registry resources.

  - [yc beta cloud-registry registry create](registry/create.md) — Creates a registry in the specified folder.

  - [yc beta cloud-registry registry delete](registry/delete.md) — Deletes the specified registry.

  - [yc beta cloud-registry registry force-delete](registry/force-delete.md) — Forcefully deletes the specified registry along with all its repositories and data.

  - [yc beta cloud-registry registry get](registry/get.md) — Returns the specified Registry resource.

  - [yc beta cloud-registry registry list](registry/list.md) — Retrieves the list of Registry resources in the specified folder.

  - [yc beta cloud-registry registry list-access-bindings](registry/list-access-bindings.md) — Lists access bindings for the specified registry.

  - [yc beta cloud-registry registry list-artifacts](registry/list-artifacts.md) — Retrieves the list of registry artifact resources in the specified registry.

  - [yc beta cloud-registry registry list-ip-permissions](registry/list-ip-permissions.md) — List ip permissions for the specified registry.

  - [yc beta cloud-registry registry set-access-bindings](registry/set-access-bindings.md) — Sets access bindings for the specified registry.

  - [yc beta cloud-registry registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry.

  - [yc beta cloud-registry registry update](registry/update.md) — Updates the specified registry.

  - [yc beta cloud-registry registry update-access-bindings](registry/update-access-bindings.md) — Updates access bindings for the specified registry.

  - [yc beta cloud-registry registry update-ip-permissions](registry/update-ip-permissions.md) — Update ip permissions for the specified registry.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
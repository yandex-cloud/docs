---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloud-registry/cli-ref/v1/registry/
---

# yc cloud-registry v1 registry

A set of methods for managing Registry resources.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry <group|command>`

#### Command Tree

- [yc cloud-registry v1 registry add-access-binding](add-access-binding.md) — Add access binding for the specified registry.

- [yc cloud-registry v1 registry add-ip-permissions](add-ip-permissions.md) — Add ip permissions for the specified registry.

- [yc cloud-registry v1 registry create](create.md) — Creates a registry in the specified folder.

- [yc cloud-registry v1 registry delete](delete.md) — Deletes the specified registry.

- [yc cloud-registry v1 registry force-delete](force-delete.md) — Forcefully deletes the specified registry along with all its repositories and data.

- [yc cloud-registry v1 registry get](get.md) — Returns the specified Registry resource.

- [yc cloud-registry v1 registry list](list.md) — Retrieves the list of Registry resources in the specified folder.

- [yc cloud-registry v1 registry list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified registry.

- [yc cloud-registry v1 registry list-artifacts](list-artifacts.md) — Retrieves the list of registry artifact resources in the specified registry.

- [yc cloud-registry v1 registry list-ip-permissions](list-ip-permissions.md) — List ip permissions for the specified registry.

- [yc cloud-registry v1 registry remove-access-binding](remove-access-binding.md) — Remove access binding for the specified registry.

- [yc cloud-registry v1 registry remove-ip-permissions](remove-ip-permissions.md) — Remove ip permissions for the specified registry.

- [yc cloud-registry v1 registry set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified registry.

- [yc cloud-registry v1 registry set-ip-permissions](set-ip-permissions.md) — Set ip permissions for the specified registry.

- [yc cloud-registry v1 registry update](update.md) — Updates the specified registry.

- [yc cloud-registry v1 registry lifecycle-policy](lifecycle-policy/index.md) — A set of methods for managing LifecyclePolicy resources.

  - [yc cloud-registry v1 registry lifecycle-policy change-state](lifecycle-policy/change-state.md) — Changes the state of the specified lifecycle policy.

  - [yc cloud-registry v1 registry lifecycle-policy create](lifecycle-policy/create.md) — Create a lifecycle policy.

  - [yc cloud-registry v1 registry lifecycle-policy delete](lifecycle-policy/delete.md) — Deletes the specified lifecycle policy.

  - [yc cloud-registry v1 registry lifecycle-policy dry-run](lifecycle-policy/dry-run.md) — Creates a request of a dry run of the lifecycle policy.

  - [yc cloud-registry v1 registry lifecycle-policy get](lifecycle-policy/get.md) — Returns the specified lifecycle policy.

  - [yc cloud-registry v1 registry lifecycle-policy list](lifecycle-policy/list.md) — Retrieves the list of lifecycle policies in the specified registry.

  - [yc cloud-registry v1 registry lifecycle-policy update](lifecycle-policy/update.md) — Update the specified lifecycle policy.

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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
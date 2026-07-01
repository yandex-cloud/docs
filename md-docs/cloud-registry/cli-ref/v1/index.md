# yc cloud-registry v1

[PREVIEW] Manage Cloud Registry resources

#### Command Usage

Syntax:

`yc cloud-registry v1 <group|command>`

#### Command Tree

- [yc cloud-registry v1 configure-docker](configure-docker.md) — Configure the Docker credential helper for Cloud Registry.

- [yc cloud-registry v1 tools](tools.md) — 

- [yc cloud-registry v1 artifact](artifact/index.md) — A set of methods for managing Artifacts.

  - [yc cloud-registry v1 artifact add-access-binding](artifact/add-access-binding.md) — Add access binding for the specified artifact.

  - [yc cloud-registry v1 artifact delete](artifact/delete.md) — Deletes the specified artifact.

  - [yc cloud-registry v1 artifact get](artifact/get.md) — Returns the specified artifact resource.

  - [yc cloud-registry v1 artifact get-by-path](artifact/get-by-path.md) — Returns the specified artifact resource by path within the registry.

  - [yc cloud-registry v1 artifact list-access-bindings](artifact/list-access-bindings.md) — access bindings

  - [yc cloud-registry v1 artifact remove-access-binding](artifact/remove-access-binding.md) — Remove access binding for the specified artifact.

  - [yc cloud-registry v1 artifact set-access-bindings](artifact/set-access-bindings.md) — Sets access bindings for the specified artifact (folder, package, artifact, etc).

  - [yc cloud-registry v1 artifact update-access-bindings](artifact/update-access-bindings.md) — Updates access bindings for the specified artifact (folder, package, artifact, etc).

  - [yc cloud-registry v1 artifact upsert](artifact/upsert.md) — Upserts a folder at the specified path within the registry.

- [yc cloud-registry v1 registry](registry/index.md) — A set of methods for managing Registry resources.

  - [yc cloud-registry v1 registry add-access-binding](registry/add-access-binding.md) — Add access binding for the specified registry.

  - [yc cloud-registry v1 registry add-ip-permissions](registry/add-ip-permissions.md) — Add ip permissions for the specified registry.

  - [yc cloud-registry v1 registry create](registry/create.md) — Creates a registry in the specified folder.

  - [yc cloud-registry v1 registry delete](registry/delete.md) — Deletes the specified registry.

  - [yc cloud-registry v1 registry force-delete](registry/force-delete.md) — Forcefully deletes the specified registry along with all its repositories and data.

  - [yc cloud-registry v1 registry get](registry/get.md) — Returns the specified Registry resource.

  - [yc cloud-registry v1 registry list](registry/list.md) — Retrieves the list of Registry resources in the specified folder.

  - [yc cloud-registry v1 registry list-access-bindings](registry/list-access-bindings.md) — Lists access bindings for the specified registry.

  - [yc cloud-registry v1 registry list-artifacts](registry/list-artifacts.md) — Retrieves the list of registry artifact resources in the specified registry.

  - [yc cloud-registry v1 registry list-ip-permissions](registry/list-ip-permissions.md) — List ip permissions for the specified registry.

  - [yc cloud-registry v1 registry remove-access-binding](registry/remove-access-binding.md) — Remove access binding for the specified registry.

  - [yc cloud-registry v1 registry remove-ip-permissions](registry/remove-ip-permissions.md) — Remove ip permissions for the specified registry.

  - [yc cloud-registry v1 registry set-access-bindings](registry/set-access-bindings.md) — Sets access bindings for the specified registry.

  - [yc cloud-registry v1 registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry.

  - [yc cloud-registry v1 registry update](registry/update.md) — Updates the specified registry.

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
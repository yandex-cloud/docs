[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Справочник CLI (англ.)](../index.md) > v0 > Overview

# yc cloud-registry v0

Manage Cloud Registry resources

#### Command Usage

Syntax:

`yc cloud-registry v0 <group|command>`

#### Command Tree

- [yc cloud-registry v0 configure-docker](configure-docker.md) — 

- [yc cloud-registry v0 artifact](artifact/index.md) — Manage artifacts

  - [yc cloud-registry v0 artifact add-access-binding](artifact/add-access-binding.md) — Add access binding for the specified artifact

  - [yc cloud-registry v0 artifact delete](artifact/delete.md) — Delete the specified registry artifact

  - [yc cloud-registry v0 artifact get](artifact/get.md) — Get information about the artifact

  - [yc cloud-registry v0 artifact get-by-path](artifact/get-by-path.md) — Get information about the artifact by path

  - [yc cloud-registry v0 artifact list](artifact/list.md) — List artifacts with filtering by kind, registry kind/type, node path

  - [yc cloud-registry v0 artifact list-access-bindings](artifact/list-access-bindings.md) — Lists access bindings for the specified artifact

  - [yc cloud-registry v0 artifact remove-access-binding](artifact/remove-access-binding.md) — Remove access binding for the specified artifact

  - [yc cloud-registry v0 artifact set-access-bindings](artifact/set-access-bindings.md) — Set access bindings for the specified artifact

  - [yc cloud-registry v0 artifact upsert](artifact/upsert.md) — Upserts a folder at the specified path within the registry

- [yc cloud-registry v0 registry](registry/index.md) — Manage registries

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

  - [yc cloud-registry v0 registry set-access-bindings](registry/set-access-bindings.md) — Set access bindings for the specified registry

  - [yc cloud-registry v0 registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry

  - [yc cloud-registry v0 registry update](registry/update.md) — Updates the specified registry

- [yc cloud-registry v0 tools](tools/index.md) — Tools for specific artifact kinds



#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
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
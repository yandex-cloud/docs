[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Справочник CLI (англ.)](../index.md) > registry > Overview

# yc container registry

Manage registries.

#### Command Usage

Syntax:

`yc container registry <command>`

Aliases:

- `registries`

- `reg`

#### Command Tree

- [yc container registry add-access-binding](add-access-binding.md) — Add access binding for the specified registry

- [yc container registry add-ip-permissions](add-ip-permissions.md) — Add ip permissions for the specified registry

- [yc container registry add-labels](add-labels.md) — Add labels to a registry.

- [yc container registry configure-docker](configure-docker.md) — Configure docker to use Yandex Cloud credential helper.

- [yc container registry create](create.md) — Create a registry.

- [yc container registry delete](delete.md) — Delete a registry.

- [yc container registry force-delete](force-delete.md) — Force delete a registry with all its resources.

- [yc container registry get](get.md) — Get information about a registry.

- [yc container registry list](list.md) — List registries.

- [yc container registry list-access-bindings](list-access-bindings.md) — List access bindings for the specified registry

- [yc container registry list-ip-permissions](list-ip-permissions.md) — List ip permissions for the specified registry

- [yc container registry remove-access-binding](remove-access-binding.md) — Remove access binding for the specified registry

- [yc container registry remove-ip-permissions](remove-ip-permissions.md) — Remove ip permissions for the specified registry

- [yc container registry remove-labels](remove-labels.md) — Remove labels from a registry.

- [yc container registry set-access-bindings](set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any

- [yc container registry set-ip-permissions](set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any

- [yc container registry update](update.md) — Modify configuration or attributes of a registry.

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
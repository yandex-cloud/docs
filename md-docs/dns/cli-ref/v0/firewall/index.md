[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud DNS](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > firewall > Overview

# yc dns v0 firewall

Manage dns firewalls

#### Command Usage

Syntax:

`yc dns v0 firewall <command>`

Aliases:

- `firewall`

#### Command Tree

- [yc dns v0 firewall add-access-binding](add-access-binding.md) — Add an access binding to the specified dns firewall.

- [yc dns v0 firewall add-labels](add-labels.md) — Assign labels to the specified dns firewall.

- [yc dns v0 firewall create](create.md) — Create a dns firewall in the specified folder.

- [yc dns v0 firewall delete](delete.md) — Delete a dns firewall.

- [yc dns v0 firewall get](get.md) — Get information about a dns firewall.

- [yc dns v0 firewall list](list.md) — List dns firewalls in folder.

- [yc dns v0 firewall list-access-bindings](list-access-bindings.md) — List access bindings of the specified dns firewall.

- [yc dns v0 firewall list-operations](list-operations.md) — List operations of the specified dns firewall.

- [yc dns v0 firewall move](move.md) — Move a dns firewall to the specified folder.

- [yc dns v0 firewall remove-access-binding](remove-access-binding.md) — Remove an access binding from the specified dns firewall.

- [yc dns v0 firewall remove-labels](remove-labels.md) — Remove labels from the specified dns firewall.

- [yc dns v0 firewall set-access-bindings](set-access-bindings.md) — Set access bindings of the specified dns firewall.

- [yc dns v0 firewall update](update.md) — Modify configuration or attributes of a dns firewall.

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
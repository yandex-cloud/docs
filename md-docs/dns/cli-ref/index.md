[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > Справочник CLI (англ.) > Overview

# yc dns

Manage DNS resources

Command tree v0 is the default. Run `yc dns <command>` or `yc dns v0 <command>`.

#### Command Usage

Syntax:

`yc dns <group>`

#### Command Tree

- [yc dns bind-file](bind-file/index.md) — Manage bind file

  - [yc dns bind-file migrate-to-terraform](bind-file/migrate-to-terraform.md) — Writes terraform specification to stdout

- [yc dns firewall](firewall/index.md) — Manage dns firewalls

  - [yc dns firewall add-access-binding](firewall/add-access-binding.md) — Add an access binding to the specified dns firewall.

  - [yc dns firewall add-labels](firewall/add-labels.md) — Assign labels to the specified dns firewall.

  - [yc dns firewall create](firewall/create.md) — Create a dns firewall in the specified folder.

  - [yc dns firewall delete](firewall/delete.md) — Delete a dns firewall.

  - [yc dns firewall get](firewall/get.md) — Get information about a dns firewall.

  - [yc dns firewall list](firewall/list.md) — List dns firewalls in folder.

  - [yc dns firewall list-access-bindings](firewall/list-access-bindings.md) — List access bindings of the specified dns firewall.

  - [yc dns firewall list-operations](firewall/list-operations.md) — List operations of the specified dns firewall.

  - [yc dns firewall move](firewall/move.md) — Move a dns firewall to the specified folder.

  - [yc dns firewall remove-access-binding](firewall/remove-access-binding.md) — Remove an access binding from the specified dns firewall.

  - [yc dns firewall remove-labels](firewall/remove-labels.md) — Remove labels from the specified dns firewall.

  - [yc dns firewall set-access-bindings](firewall/set-access-bindings.md) — Set access bindings of the specified dns firewall.

  - [yc dns firewall update](firewall/update.md) — Modify configuration or attributes of a dns firewall.

- [yc dns inbound-endpoint](inbound-endpoint/index.md) — Manage dns inbound endpoints

  - [yc dns inbound-endpoint add-access-binding](inbound-endpoint/add-access-binding.md) — Add an access binding to the specified dns inbound endpoint.

  - [yc dns inbound-endpoint add-labels](inbound-endpoint/add-labels.md) — Assign labels to the specified dns inbound endpoint.

  - [yc dns inbound-endpoint create](inbound-endpoint/create.md) — Create a dns inbound endpoint in the specified folder.

  - [yc dns inbound-endpoint delete](inbound-endpoint/delete.md) — Delete a dns inbound endpoint.

  - [yc dns inbound-endpoint get](inbound-endpoint/get.md) — Get information about a dns inbound endpoint.

  - [yc dns inbound-endpoint list](inbound-endpoint/list.md) — List dns inbound endpoints in folder.

  - [yc dns inbound-endpoint list-access-bindings](inbound-endpoint/list-access-bindings.md) — List access bindings of the specified dns inbound endpoint.

  - [yc dns inbound-endpoint list-operations](inbound-endpoint/list-operations.md) — List operations of the specified dns inbound endpoint.

  - [yc dns inbound-endpoint remove-access-binding](inbound-endpoint/remove-access-binding.md) — Remove an access binding from the specified dns inbound endpoint.

  - [yc dns inbound-endpoint remove-labels](inbound-endpoint/remove-labels.md) — Remove labels from the specified dns inbound endpoint.

  - [yc dns inbound-endpoint set-access-bindings](inbound-endpoint/set-access-bindings.md) — Set access bindings of the specified dns inbound endpoint.

  - [yc dns inbound-endpoint update](inbound-endpoint/update.md) — Modify configuration or attributes of a dns inbound endpoint.

- [yc dns v0](v0/index.md) — Manage DNS resources



- [yc dns zone](zone/index.md) — Manage dns zones

  - [yc dns zone add-access-binding](zone/add-access-binding.md) — Add an access binding to the specified dns zone.

  - [yc dns zone add-labels](zone/add-labels.md) — Assign labels to the specified dns zone.

  - [yc dns zone add-records](zone/add-records.md) — Add records to dns zone.

  - [yc dns zone create](zone/create.md) — Create a dns zone in the specified folder.

  - [yc dns zone delete](zone/delete.md) — Delete a dns zone.

  - [yc dns zone delete-records](zone/delete-records.md) — Delete records from dns zone.

  - [yc dns zone get](zone/get.md) — Get information about a dns zone.

  - [yc dns zone list](zone/list.md) — List dns zones in folder.

  - [yc dns zone list-access-bindings](zone/list-access-bindings.md) — List access bindings of the specified dns zone.

  - [yc dns zone list-operations](zone/list-operations.md) — List operations of the specified dns zone.

  - [yc dns zone list-records](zone/list-records.md) — List dns zone records.

  - [yc dns zone move](zone/move.md) — Move a dns zone to the specified folder.

  - [yc dns zone remove-access-binding](zone/remove-access-binding.md) — Remove an access binding from the specified dns zone.

  - [yc dns zone remove-labels](zone/remove-labels.md) — Remove labels from the specified dns zone.

  - [yc dns zone replace-records](zone/replace-records.md) — Replace records in dns zone.

  - [yc dns zone set-access-bindings](zone/set-access-bindings.md) — Set access bindings of the specified dns zone.

  - [yc dns zone update](zone/update.md) — Modify configuration or attributes of a dns zone.

  - [yc dns zone update-private-networks](zone/update-private-networks.md) — Modify private networks of a dns zone.

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
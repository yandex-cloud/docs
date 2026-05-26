---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/dns/cli-ref/v0/
editable: false
---

# yc dns v0

Manage Yandex DNS resources

#### Command Usage

Syntax:

`yc dns v0 <group>`

#### Command Tree

- [yc dns v0 bind-file](bind-file/index.md) — Manage bind file

  - [yc dns v0 bind-file migrate-to-terraform](bind-file/migrate-to-terraform.md) — Writes terraform specification to stdout

- [yc dns v0 firewall](firewall/index.md) — Manage dns firewalls

  - [yc dns v0 firewall add-access-binding](firewall/add-access-binding.md) — Add access binding to the specified dns firewall

  - [yc dns v0 firewall add-labels](firewall/add-labels.md) — Assign labels to the specified dns firewall.

  - [yc dns v0 firewall create](firewall/create.md) — Create a dns firewall in the specified folder.

  - [yc dns v0 firewall delete](firewall/delete.md) — Delete a dns firewall.

  - [yc dns v0 firewall get](firewall/get.md) — Get information about a dns firewall.

  - [yc dns v0 firewall list](firewall/list.md) — List dns firewalls in folder.

  - [yc dns v0 firewall list-access-bindings](firewall/list-access-bindings.md) — List access bindings of the specified dns firewall.

  - [yc dns v0 firewall list-operations](firewall/list-operations.md) — List operations of the specified dns firewall.

  - [yc dns v0 firewall move](firewall/move.md) — Move a dns firewall to the specified folder.

  - [yc dns v0 firewall remove-access-binding](firewall/remove-access-binding.md) — Remove access binding from the specified dns firewall

  - [yc dns v0 firewall remove-labels](firewall/remove-labels.md) — Remove labels from the specified dns firewall

  - [yc dns v0 firewall set-access-bindings](firewall/set-access-bindings.md) — Set access bindings to the specified dns firewall and delete all existing access bindings if there are any.

  - [yc dns v0 firewall update](firewall/update.md) — Modify configuration or attributes of a dns firewall.

- [yc dns v0 inbound-endpoint](inbound-endpoint/index.md) — Manage dns inbound endpoints

  - [yc dns v0 inbound-endpoint add-access-binding](inbound-endpoint/add-access-binding.md) — Add access binding to the specified dns inbound endpoint

  - [yc dns v0 inbound-endpoint add-labels](inbound-endpoint/add-labels.md) — Assign labels to the specified dns inbound endpoint.

  - [yc dns v0 inbound-endpoint create](inbound-endpoint/create.md) — Create a dns inbound endpoint in the specified folder.

  - [yc dns v0 inbound-endpoint delete](inbound-endpoint/delete.md) — Delete a dns inbound endpoint.

  - [yc dns v0 inbound-endpoint get](inbound-endpoint/get.md) — Get information about a dns inbound endpoint.

  - [yc dns v0 inbound-endpoint list](inbound-endpoint/list.md) — List dns inbound endpoints in folder.

  - [yc dns v0 inbound-endpoint list-access-bindings](inbound-endpoint/list-access-bindings.md) — List access bindings of the specified dns inbound endpoint.

  - [yc dns v0 inbound-endpoint list-operations](inbound-endpoint/list-operations.md) — List operations of the specified dns inbound endpoint.

  - [yc dns v0 inbound-endpoint remove-access-binding](inbound-endpoint/remove-access-binding.md) — Remove access binding from the specified dns inbound endpoint

  - [yc dns v0 inbound-endpoint remove-labels](inbound-endpoint/remove-labels.md) — Remove labels from the specified dns inbound endpoint

  - [yc dns v0 inbound-endpoint set-access-bindings](inbound-endpoint/set-access-bindings.md) — Set access bindings to the specified dns inbound endpoint and delete all existing access bindings if there are any.

  - [yc dns v0 inbound-endpoint update](inbound-endpoint/update.md) — Modify configuration or attributes of a dns inbound endpoint.

- [yc dns v0 zone](zone/index.md) — Manage dns zones

  - [yc dns v0 zone add-access-binding](zone/add-access-binding.md) — Add access binding to the specified dns zone

  - [yc dns v0 zone add-labels](zone/add-labels.md) — Assign labels to the specified dns zone.

  - [yc dns v0 zone add-records](zone/add-records.md) — Add records to dns zone.

  - [yc dns v0 zone create](zone/create.md) — Create a dns zone in the specified folder.

  - [yc dns v0 zone delete](zone/delete.md) — Delete a dns zone.

  - [yc dns v0 zone delete-records](zone/delete-records.md) — Delete records from dns zone.

  - [yc dns v0 zone get](zone/get.md) — Get information about a dns zone.

  - [yc dns v0 zone list](zone/list.md) — List dns zones in folder.

  - [yc dns v0 zone list-access-bindings](zone/list-access-bindings.md) — List access bindings of the specified dns zone.

  - [yc dns v0 zone list-operations](zone/list-operations.md) — List operations of the specified dns zone.

  - [yc dns v0 zone list-records](zone/list-records.md) — List dns zone records.

  - [yc dns v0 zone move](zone/move.md) — Move a dns zone to the specified folder.

  - [yc dns v0 zone remove-access-binding](zone/remove-access-binding.md) — Remove access binding from the specified dns zone

  - [yc dns v0 zone remove-labels](zone/remove-labels.md) — Remove labels from the specified dns zone

  - [yc dns v0 zone replace-records](zone/replace-records.md) — Replace all records specified by name and type in dns zone with new ones.

  - [yc dns v0 zone set-access-bindings](zone/set-access-bindings.md) — Set access bindings to the specified dns zone and delete all existing access bindings if there are any.

  - [yc dns v0 zone update](zone/update.md) — Modify configuration or attributes of a dns zone.

  - [yc dns v0 zone update-private-networks](zone/update-private-networks.md) — Modify private networks of a dns zone.

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

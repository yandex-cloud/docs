---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/dns/cli-ref/v0/zone/
---

# yc dns v0 zone

Manage dns zones

#### Command Usage

Syntax:

`yc dns v0 zone <command>`

Aliases:

- `zones`

#### Command Tree

- [yc dns v0 zone add-access-binding](add-access-binding.md) — Add an access binding to the specified dns zone.

- [yc dns v0 zone add-labels](add-labels.md) — Assign labels to the specified dns zone.

- [yc dns v0 zone add-records](add-records.md) — Add records to dns zone.

- [yc dns v0 zone create](create.md) — Create a dns zone in the specified folder.

- [yc dns v0 zone delete](delete.md) — Delete a dns zone.

- [yc dns v0 zone delete-records](delete-records.md) — Delete records from dns zone.

- [yc dns v0 zone get](get.md) — Get information about a dns zone.

- [yc dns v0 zone list](list.md) — List dns zones in folder.

- [yc dns v0 zone list-access-bindings](list-access-bindings.md) — List access bindings of the specified dns zone.

- [yc dns v0 zone list-operations](list-operations.md) — List operations of the specified dns zone.

- [yc dns v0 zone list-records](list-records.md) — List dns zone records.

- [yc dns v0 zone move](move.md) — Move a dns zone to the specified folder.

- [yc dns v0 zone remove-access-binding](remove-access-binding.md) — Remove an access binding from the specified dns zone.

- [yc dns v0 zone remove-labels](remove-labels.md) — Remove labels from the specified dns zone.

- [yc dns v0 zone replace-records](replace-records.md) — Replace records in dns zone.

- [yc dns v0 zone set-access-bindings](set-access-bindings.md) — Set access bindings of the specified dns zone.

- [yc dns v0 zone update](update.md) — Modify configuration or attributes of a dns zone.

- [yc dns v0 zone update-private-networks](update-private-networks.md) — Modify private networks of a dns zone.

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
---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/dns/cli-ref/v0/firewall/
---

# yc dns v0 firewall

Manage dns firewalls

#### Command Usage

Syntax:

`yc dns firewall <command>`

Aliases:

- `firewall`

#### Command Tree

- [yc dns v0 firewall add-access-binding](add-access-binding.md) — Add access binding to the specified dns firewall

- [yc dns v0 firewall add-labels](add-labels.md) — Assign labels to the specified dns firewall.

- [yc dns v0 firewall create](create.md) — Create a dns firewall in the specified folder.

- [yc dns v0 firewall delete](delete.md) — Delete a dns firewall.

- [yc dns v0 firewall get](get.md) — Get information about a dns firewall.

- [yc dns v0 firewall list](list.md) — List dns firewalls in folder.

- [yc dns v0 firewall list-access-bindings](list-access-bindings.md) — List access bindings of the specified dns firewall.

- [yc dns v0 firewall list-operations](list-operations.md) — List operations of the specified dns firewall.

- [yc dns v0 firewall move](move.md) — Move a dns firewall to the specified folder.

- [yc dns v0 firewall remove-access-binding](remove-access-binding.md) — Remove access binding from the specified dns firewall

- [yc dns v0 firewall remove-labels](remove-labels.md) — Remove labels from the specified dns firewall

- [yc dns v0 firewall set-access-bindings](set-access-bindings.md) — Set access bindings to the specified dns firewall and delete all existing access bindings if there are any.

- [yc dns v0 firewall update](update.md) — Modify configuration or attributes of a dns firewall.

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
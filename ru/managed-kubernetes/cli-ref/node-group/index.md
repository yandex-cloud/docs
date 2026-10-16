---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-kubernetes/cli-ref/node-group/
---

# yc managed-kubernetes node-group

Manage node groups.

#### Command Usage

Syntax:

`yc managed-kubernetes node-group <command>`

Aliases:

- `node-groups`

#### Command Tree

- [yc managed-kubernetes node-group add-labels](add-labels.md) — Add labels to the specified node group.

- [yc managed-kubernetes node-group add-metadata](add-metadata.md) — Add or update metadata of the node template of the specified node group.

- [yc managed-kubernetes node-group add-node-labels](add-node-labels.md) — Add NODE labels to the specified node group.

- [yc managed-kubernetes node-group create](create.md) — Create a node group.

- [yc managed-kubernetes node-group delete](delete.md) — Delete a node group.

- [yc managed-kubernetes node-group get](get.md) — Get information about a node group.

- [yc managed-kubernetes node-group list](list.md) — List node groups available in a folder.

- [yc managed-kubernetes node-group list-nodes](list-nodes.md) — List nodes for the specified node group.

- [yc managed-kubernetes node-group list-operations](list-operations.md) — List operations for the specified node group.

- [yc managed-kubernetes node-group remove-labels](remove-labels.md) — Remove labels from the specified node group.

- [yc managed-kubernetes node-group remove-metadata](remove-metadata.md) — Remove keys from metadata of the node template of the specified node group.

- [yc managed-kubernetes node-group remove-node-labels](remove-node-labels.md) — Remove NODE labels from the specified node group.

- [yc managed-kubernetes node-group update](update.md) — Modify configuration or attributes of a node group.

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
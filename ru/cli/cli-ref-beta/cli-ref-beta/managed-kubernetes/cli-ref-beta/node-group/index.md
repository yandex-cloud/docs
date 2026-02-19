---
editable: false
noIndex: true
---

# yc beta managed-kubernetes node-group

A set of methods for managing node groups.

#### Command Usage

Syntax:

`yc beta managed-kubernetes node-group <command>`

#### Command Tree

- [yc beta managed-kubernetes node-group create](create.md) — Creates a node group in the specified Kubernetes cluster.

- [yc beta managed-kubernetes node-group delete](delete.md) — Deletes the specified node group.

- [yc beta managed-kubernetes node-group get](get.md) — Returns the specified node group.

- [yc beta managed-kubernetes node-group list](list.md) — Retrieves the list of node group in the specified Kubernetes cluster.

- [yc beta managed-kubernetes node-group list-nodes](list-nodes.md) — Retrieves the list of nodes in the specified Kubernetes cluster.

- [yc beta managed-kubernetes node-group list-operations](list-operations.md) — Lists operations for the specified node group.

- [yc beta managed-kubernetes node-group update](update.md) — Updates the specified node group.

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
|| `-h`, `--help` | Display help for the command. ||
|#
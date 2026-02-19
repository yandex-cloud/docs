---
editable: false
noIndex: true
---

# yc beta managed-kubernetes

Manage Kubernetes clusters

#### Command Usage

Syntax:

`yc beta managed-kubernetes <group>`

Aliases:

- `k8s`

#### Command Tree

- [yc beta managed-kubernetes cluster](cluster/index.md) — A set of methods for managing Kubernetes cluster.

  - [yc beta managed-kubernetes cluster create](cluster/create.md) — Creates a Kubernetes cluster in the specified folder.

  - [yc beta managed-kubernetes cluster delete](cluster/delete.md) — Deletes the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster get](cluster/get.md) — Returns the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster list](cluster/list.md) — Retrieves the list of Kubernetes cluster in the specified folder.

  - [yc beta managed-kubernetes cluster list-access-bindings](cluster/list-access-bindings.md) — Lists cluster's access bindings

  - [yc beta managed-kubernetes cluster list-node-groups](cluster/list-node-groups.md) — Lists nodegroup for the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster list-nodes](cluster/list-nodes.md) — Lists cluster's nodes.

  - [yc beta managed-kubernetes cluster list-operations](cluster/list-operations.md) — Lists operations for the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules mandatory maintenance for the specified cluster.

  - [yc beta managed-kubernetes cluster set-access-bindings](cluster/set-access-bindings.md) — Sets cluster's access bindings

  - [yc beta managed-kubernetes cluster start](cluster/start.md) — Starts the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster stop](cluster/stop.md) — Stops the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster update](cluster/update.md) — Updates the specified Kubernetes cluster.

  - [yc beta managed-kubernetes cluster update-access-bindings](cluster/update-access-bindings.md) — Updates cluster's access bindings

- [yc beta managed-kubernetes marketplace](marketplace/index.md) — 



- [yc beta managed-kubernetes node-group](node-group/index.md) — A set of methods for managing node groups.

  - [yc beta managed-kubernetes node-group create](node-group/create.md) — Creates a node group in the specified Kubernetes cluster.

  - [yc beta managed-kubernetes node-group delete](node-group/delete.md) — Deletes the specified node group.

  - [yc beta managed-kubernetes node-group get](node-group/get.md) — Returns the specified node group.

  - [yc beta managed-kubernetes node-group list](node-group/list.md) — Retrieves the list of node group in the specified Kubernetes cluster.

  - [yc beta managed-kubernetes node-group list-nodes](node-group/list-nodes.md) — Retrieves the list of nodes in the specified Kubernetes cluster.

  - [yc beta managed-kubernetes node-group list-operations](node-group/list-operations.md) — Lists operations for the specified node group.

  - [yc beta managed-kubernetes node-group update](node-group/update.md) — Updates the specified node group.

- [yc beta managed-kubernetes resource-preset](resource-preset/index.md) — A set of methods for managing ResourcePreset resources.

  - [yc beta managed-kubernetes resource-preset get](resource-preset/get.md) — Returns the specified ResourcePreset resource.

  - [yc beta managed-kubernetes resource-preset list](resource-preset/list.md) — Retrieves the list of available ResourcePreset resources.

- [yc beta managed-kubernetes version](version/index.md) — A set of methods for managing Kubernetes versions.

  - [yc beta managed-kubernetes version list](version/list.md) — Retrieves the list of versions in the specified release channel.

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
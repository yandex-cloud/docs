---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-kubernetes/cli-ref/v0/index
editable: false
---

# yc managed-kubernetes v0

Manage Kubernetes clusters.

#### Command Usage

Syntax:

`yc managed-kubernetes v0 <group|command>`

#### Command Tree

- [yc managed-kubernetes v0 create-token](create-token.md) — Create K8S token and print to STDOUT.

- [yc managed-kubernetes v0 list-versions](list-versions.md) — List available kubernetes versions.

- [yc managed-kubernetes v0 cluster](cluster/index.md) — Manage Kubernetes clusters.

  - [yc managed-kubernetes v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster add-labels](cluster/add-labels.md) — Add labels to the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster create](cluster/create.md) — Create a Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster delete](cluster/delete.md) — Delete a Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster get](cluster/get.md) — Get information about a Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster get-credentials](cluster/get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster list](cluster/list.md) — List Kubernetes clusters available in a folder.

  - [yc managed-kubernetes v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster list-node-groups](cluster/list-node-groups.md) — List Kubernetes cluster node groups.

  - [yc managed-kubernetes v0 cluster list-nodes](cluster/list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule mandatory maintenance for the specified Kubernetes cluster.

  - [yc managed-kubernetes v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Kubernetes cluster and delete all existing access bindings if there were any

  - [yc managed-kubernetes v0 cluster start](cluster/start.md) — Start a Kubernetes cluster and all its node groups.

  - [yc managed-kubernetes v0 cluster stop](cluster/stop.md) — Stop a Kubernetes cluster and all its node groups.

  - [yc managed-kubernetes v0 cluster update](cluster/update.md) — Modify configuration or attributes of a Kubernetes cluster.

- [yc managed-kubernetes v0 marketplace](marketplace/index.md) — Manage Marketplace products.



- [yc managed-kubernetes v0 node-group](node-group/index.md) — Manage node groups.

  - [yc managed-kubernetes v0 node-group add-labels](node-group/add-labels.md) — Add labels to the specified node group.

  - [yc managed-kubernetes v0 node-group add-metadata](node-group/add-metadata.md) — Add or update metadata of the node template of the specified node group.

  - [yc managed-kubernetes v0 node-group add-node-labels](node-group/add-node-labels.md) — Add NODE labels to the specified node group.

  - [yc managed-kubernetes v0 node-group create](node-group/create.md) — Create a node group.

  - [yc managed-kubernetes v0 node-group delete](node-group/delete.md) — Delete a node group.

  - [yc managed-kubernetes v0 node-group get](node-group/get.md) — Get information about a node group.

  - [yc managed-kubernetes v0 node-group list](node-group/list.md) — List node groups available in a folder.

  - [yc managed-kubernetes v0 node-group list-nodes](node-group/list-nodes.md) — List nodes for the specified node group.

  - [yc managed-kubernetes v0 node-group list-operations](node-group/list-operations.md) — List operations for the specified node group.

  - [yc managed-kubernetes v0 node-group remove-labels](node-group/remove-labels.md) — Remove labels from the specified node group.

  - [yc managed-kubernetes v0 node-group remove-metadata](node-group/remove-metadata.md) — Remove keys from metadata of the node template of the specified node group.

  - [yc managed-kubernetes v0 node-group remove-node-labels](node-group/remove-node-labels.md) — Remove NODE labels from the specified node group.

  - [yc managed-kubernetes v0 node-group update](node-group/update.md) — Modify configuration or attributes of a node group.

- [yc managed-kubernetes v0 resource-preset](resource-preset/index.md) — Manage Kubernetes master resource presets.

  - [yc managed-kubernetes v0 resource-preset get](resource-preset/get.md) — Show information about the specified master resource preset.

  - [yc managed-kubernetes v0 resource-preset list](resource-preset/list.md) — List available master resource presets.

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

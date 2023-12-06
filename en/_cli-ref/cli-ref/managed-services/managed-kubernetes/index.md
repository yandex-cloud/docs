---
editable: false
---

# yc managed-kubernetes

Manage Kubernetes clusters.

#### Command Usage

Syntax: 

`yc managed-kubernetes <group|command>`

Aliases: 

- `k8s`

#### Command Tree

- [yc managed-kubernetes create-token](create-token.md) — Create K8S token and print to STDOUT.
- [yc managed-kubernetes list-versions](list-versions.md) — List available kubernetes versions.
- [yc managed-kubernetes cluster](cluster/index.md) — Manage Kubernetes clusters.
	- [yc managed-kubernetes cluster get-credentials](cluster/get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.
	- [yc managed-kubernetes cluster get](cluster/get.md) — Get information about a Kubernetes cluster.
	- [yc managed-kubernetes cluster list](cluster/list.md) — List Kubernetes clusters available in a folder.
	- [yc managed-kubernetes cluster create](cluster/create.md) — Create a Kubernetes cluster.
	- [yc managed-kubernetes cluster update](cluster/update.md) — Modify configuration or attributes of a Kubernetes cluster.
	- [yc managed-kubernetes cluster add-labels](cluster/add-labels.md) — Add labels to the specified Kubernetes cluster.
	- [yc managed-kubernetes cluster remove-labels](cluster/remove-labels.md) — Remove labels from the specified Kubernetes cluster.
	- [yc managed-kubernetes cluster delete](cluster/delete.md) — Delete a Kubernetes cluster.
	- [yc managed-kubernetes cluster stop](cluster/stop.md) — Stop a Kubernetes cluster and all its node groups.
	- [yc managed-kubernetes cluster start](cluster/start.md) — Start a Kubernetes cluster and all its node groups.
	- [yc managed-kubernetes cluster list-node-groups](cluster/list-node-groups.md) — List Kubernetes cluster node groups.
	- [yc managed-kubernetes cluster list-operations](cluster/list-operations.md) — List operations for the specified Kubernetes cluster.
	- [yc managed-kubernetes cluster list-nodes](cluster/list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.
- [yc managed-kubernetes node-group](node-group/index.md) — Manage node groups.
	- [yc managed-kubernetes node-group get](node-group/get.md) — Get information about a node group.
	- [yc managed-kubernetes node-group list](node-group/list.md) — List node groups available in a folder.
	- [yc managed-kubernetes node-group create](node-group/create.md) — Create a node group.
	- [yc managed-kubernetes node-group update](node-group/update.md) — Modify configuration or attributes of a node group.
	- [yc managed-kubernetes node-group add-metadata](node-group/add-metadata.md) — Add or update metadata of the node template of the specified node group.
	- [yc managed-kubernetes node-group remove-metadata](node-group/remove-metadata.md) — Remove keys from metadata of the node template of the specified node group.
	- [yc managed-kubernetes node-group add-labels](node-group/add-labels.md) — Add labels to the specified node group.
	- [yc managed-kubernetes node-group remove-labels](node-group/remove-labels.md) — Remove labels from the specified node group.
	- [yc managed-kubernetes node-group add-node-labels](node-group/add-node-labels.md) — Add NODE labels to the specified node group.
	- [yc managed-kubernetes node-group remove-node-labels](node-group/remove-node-labels.md) — Remove NODE labels from the specified node group.
	- [yc managed-kubernetes node-group delete](node-group/delete.md) — Delete a node group.
	- [yc managed-kubernetes node-group list-operations](node-group/list-operations.md) — List operations for the specified node group.
	- [yc managed-kubernetes node-group list-nodes](node-group/list-nodes.md) — List nodes for the specified node group.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|

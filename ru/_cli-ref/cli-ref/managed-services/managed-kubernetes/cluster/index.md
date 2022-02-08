# yc managed-kubernetes cluster

Manage Kubernetes clusters.

#### Command Usage

Syntax: 

`yc managed-kubernetes cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-kubernetes cluster get-credentials](get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.
- [yc managed-kubernetes cluster get](get.md) — Get information about a Kubernetes cluster.
- [yc managed-kubernetes cluster list](list.md) — List Kubernetes clusters available in a folder.
- [yc managed-kubernetes cluster create](create.md) — Create a Kubernetes cluster.
- [yc managed-kubernetes cluster update](update.md) — Modify configuration or attributes of a Kubernetes cluster.
- [yc managed-kubernetes cluster add-labels](add-labels.md) — Add labels to the specified Kubernetes cluster.
- [yc managed-kubernetes cluster remove-labels](remove-labels.md) — Remove labels from the specified Kubernetes cluster.
- [yc managed-kubernetes cluster delete](delete.md) — Delete a Kubernetes cluster.
- [yc managed-kubernetes cluster stop](stop.md) — Stop a Kubernetes cluster and all its node groups.
- [yc managed-kubernetes cluster start](start.md) — Start a Kubernetes cluster and all its node groups.
- [yc managed-kubernetes cluster list-node-groups](list-node-groups.md) — List Kubernetes cluster node groups.
- [yc managed-kubernetes cluster list-operations](list-operations.md) — List operations for the specified Kubernetes cluster.
- [yc managed-kubernetes cluster list-nodes](list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|

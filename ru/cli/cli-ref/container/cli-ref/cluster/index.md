---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/cluster/index.md
---

# yc container cluster

Manage Kubernetes clusters.

#### Command Usage

Syntax: 

`yc container cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc container cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Kubernetes cluster.
- [yc container cluster add-labels](add-labels.md) — Add labels to the specified Kubernetes cluster.
- [yc container cluster create](create.md) — Create a Kubernetes cluster.
- [yc container cluster delete](delete.md) — Delete a Kubernetes cluster.
- [yc container cluster get](get.md) — Get information about a Kubernetes cluster.
- [yc container cluster get-credentials](get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.
- [yc container cluster list](list.md) — List Kubernetes clusters available in a folder.
- [yc container cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Kubernetes cluster.
- [yc container cluster list-node-groups](list-node-groups.md) — List Kubernetes cluster node groups.
- [yc container cluster list-nodes](list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.
- [yc container cluster list-operations](list-operations.md) — List operations for the specified Kubernetes cluster.
- [yc container cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Kubernetes cluster.
- [yc container cluster remove-labels](remove-labels.md) — Remove labels from the specified Kubernetes cluster.
- [yc container cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule mandatory maintenance for the specified Kubernetes cluster.
- [yc container cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Kubernetes cluster and delete all existing access bindings if there were any
- [yc container cluster start](start.md) — Start a Kubernetes cluster and all its node groups.
- [yc container cluster stop](stop.md) — Stop a Kubernetes cluster and all its node groups.
- [yc container cluster update](update.md) — Modify configuration or attributes of a Kubernetes cluster.

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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|

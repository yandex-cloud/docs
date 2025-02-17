---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/index.md
---

# yc container

Manage Container resources.

#### Command Usage

Syntax: 

`yc container <group>`

#### Command Tree

- [yc container cluster](cluster/index.md) — Manage Kubernetes clusters.
	- [yc container cluster add-labels](cluster/add-labels.md) — Add labels to the specified Kubernetes cluster.
	- [yc container cluster create](cluster/create.md) — Create a Kubernetes cluster.
	- [yc container cluster delete](cluster/delete.md) — Delete a Kubernetes cluster.
	- [yc container cluster get](cluster/get.md) — Get information about a Kubernetes cluster.
	- [yc container cluster get-credentials](cluster/get-credentials.md) — Create or update kubeconfig for the specified Kubernetes cluster.
	- [yc container cluster list](cluster/list.md) — List Kubernetes clusters available in a folder.
	- [yc container cluster list-node-groups](cluster/list-node-groups.md) — List Kubernetes cluster node groups.
	- [yc container cluster list-nodes](cluster/list-nodes.md) — List nodes in all node groups of the specified Kubernetes cluster.
	- [yc container cluster list-operations](cluster/list-operations.md) — List operations for the specified Kubernetes cluster.
	- [yc container cluster remove-labels](cluster/remove-labels.md) — Remove labels from the specified Kubernetes cluster.
	- [yc container cluster start](cluster/start.md) — Start a Kubernetes cluster and all its node groups.
	- [yc container cluster stop](cluster/stop.md) — Stop a Kubernetes cluster and all its node groups.
	- [yc container cluster update](cluster/update.md) — Modify configuration or attributes of a Kubernetes cluster.
- [yc container image](image/index.md) — Manage Docker images.
	- [yc container image delete](image/delete.md) — Delete a Docker image.
	- [yc container image get](image/get.md) — Get information about a Docker image.
	- [yc container image get-last-scan-result](image/get-last-scan-result.md) — [PREVIEW] Get recent scan result of Docker image.
	- [yc container image get-scan-result](image/get-scan-result.md) — [PREVIEW] Get scan result.
	- [yc container image list](image/list.md) — List Docker images.
	- [yc container image list-scan-results](image/list-scan-results.md) — [PREVIEW] List scan results of Docker image.
	- [yc container image list-vulnerabilities](image/list-vulnerabilities.md) — [PREVIEW] List vulnerabilities found during scan.
	- [yc container image scan](image/scan.md) — [PREVIEW] Start scan of Docker image for vulnerabilities.
- [yc container node-group](node-group/index.md) — Manage node groups.
	- [yc container node-group add-labels](node-group/add-labels.md) — Add labels to the specified node group.
	- [yc container node-group add-metadata](node-group/add-metadata.md) — Add or update metadata of the node template of the specified node group.
	- [yc container node-group add-node-labels](node-group/add-node-labels.md) — Add NODE labels to the specified node group.
	- [yc container node-group create](node-group/create.md) — Create a node group.
	- [yc container node-group delete](node-group/delete.md) — Delete a node group.
	- [yc container node-group get](node-group/get.md) — Get information about a node group.
	- [yc container node-group list](node-group/list.md) — List node groups available in a folder.
	- [yc container node-group list-nodes](node-group/list-nodes.md) — List nodes for the specified node group.
	- [yc container node-group list-operations](node-group/list-operations.md) — List operations for the specified node group.
	- [yc container node-group remove-labels](node-group/remove-labels.md) — Remove labels from the specified node group.
	- [yc container node-group remove-metadata](node-group/remove-metadata.md) — Remove keys from metadata of the node template of the specified node group.
	- [yc container node-group remove-node-labels](node-group/remove-node-labels.md) — Remove NODE labels from the specified node group.
	- [yc container node-group update](node-group/update.md) — Modify configuration or attributes of a node group.
- [yc container registry](registry/index.md) — Manage registries.
	- [yc container registry add-access-binding](registry/add-access-binding.md) — Add access binding for the specified registry
	- [yc container registry add-ip-permissions](registry/add-ip-permissions.md) — Add ip permissions for the specified registry
	- [yc container registry add-labels](registry/add-labels.md) — Add labels to a registry.
	- [yc container registry configure-docker](registry/configure-docker.md) — Configure docker to use Yandex Cloud credential helper.
	- [yc container registry create](registry/create.md) — Create a registry.
	- [yc container registry delete](registry/delete.md) — Delete a registry.
	- [yc container registry get](registry/get.md) — Get information about a registry.
	- [yc container registry list](registry/list.md) — List registries.
	- [yc container registry list-access-bindings](registry/list-access-bindings.md) — List access bindings for the specified registry
	- [yc container registry list-ip-permissions](registry/list-ip-permissions.md) — List ip permissions for the specified registry
	- [yc container registry remove-access-binding](registry/remove-access-binding.md) — Remove access binding for the specified registry
	- [yc container registry remove-ip-permissions](registry/remove-ip-permissions.md) — Remove ip permissions for the specified registry
	- [yc container registry remove-labels](registry/remove-labels.md) — Remove labels from a registry.
	- [yc container registry set-access-bindings](registry/set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any
	- [yc container registry set-ip-permissions](registry/set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any
	- [yc container registry update](registry/update.md) — Modify configuration or attributes of a registry.
- [yc container repository](repository/index.md) — Manage Docker image repositories.
	- [yc container repository add-access-binding](repository/add-access-binding.md) — Add access binding for the specified repository
	- [yc container repository get](repository/get.md) — Get information about a Docker image repository.
	- [yc container repository list](repository/list.md) — List Docker image repositories.
	- [yc container repository list-access-bindings](repository/list-access-bindings.md) — List access bindings for the specified repository
	- [yc container repository remove-access-binding](repository/remove-access-binding.md) — Remove access binding for the specified repository
	- [yc container repository set-access-bindings](repository/set-access-bindings.md) — Set access bindings for the specified repository and delete all existing access bindings if there were any

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

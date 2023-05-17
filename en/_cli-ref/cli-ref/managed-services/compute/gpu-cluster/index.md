---
editable: false
---

# yc compute gpu-cluster

Manage GPU clusters

#### Command Usage

Syntax: 

`yc compute gpu-cluster <command>`

Aliases: 

- `gpu-clusters`

#### Command Tree

- [yc compute gpu-cluster get](get.md) — Show information about the specified GPU cluster
- [yc compute gpu-cluster list](list.md) — List GPU clusters
- [yc compute gpu-cluster create](create.md) — Create a GPU cluster
- [yc compute gpu-cluster update](update.md) — Update the specified GPU cluster
- [yc compute gpu-cluster add-labels](add-labels.md) — Add labels to specified GPU cluster
- [yc compute gpu-cluster remove-labels](remove-labels.md) — Remove labels from specified GPU cluster
- [yc compute gpu-cluster delete](delete.md) — Delete the specified GPU cluster
- [yc compute gpu-cluster list-operations](list-operations.md) — List operations for the specified GPU cluster
- [yc compute gpu-cluster list-instances](list-instances.md) — List instances created in the specified GPU cluster

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|

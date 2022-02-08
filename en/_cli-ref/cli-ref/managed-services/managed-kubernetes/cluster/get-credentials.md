# yc managed-kubernetes cluster get-credentials

Create or update kubeconfig for the specified Kubernetes cluster.

#### Command Usage

Syntax: 

`yc managed-kubernetes cluster get-credentials <CLUSTER-NAME>|<CLUSTER-ID> [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Kubernetes cluster.|
|`--name`|<b>`string`</b><br/>Name of the Kubernetes cluster.|
|`--kubeconfig`|<b>`string`</b><br/>Path to kubeconfig file.|
|`--context-name`|<b>`string`</b><br/>A name of the context|
|`--internal`|Use Kubernetes cluster internal endpoint.|
|`--external`|Use Kubernetes cluster external endpoint.|
|`--force`|Overwrite context|

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

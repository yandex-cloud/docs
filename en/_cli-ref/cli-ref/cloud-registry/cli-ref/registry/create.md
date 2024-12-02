---
editable: false
---

# yc cloud-registry registry create

Creates a registry in the specified folder

#### Command Usage

Syntax: 

`yc cloud-registry registry create <REGISTRY_NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the registry|
|`--description`|<b>`string`</b><br/>Registry description|
|`--registry-kind`|<b>`string`</b><br/>Registry kind Values: 'maven', 'npm', 'docker'|
|`--registry-type`|<b>`string`</b><br/>Registry type Values: 'local'|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>List of label KEY=VALUE pairs to add.|
|`--properties`|<b>`key=value[,key=value...]`</b><br/>List of property KEY=VALUE pairs to add.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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

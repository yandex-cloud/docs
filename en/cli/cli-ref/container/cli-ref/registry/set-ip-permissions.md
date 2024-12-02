---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/registry/set-ip-permissions.md
---

# yc container registry set-ip-permissions

Set ip permissions for the specified registry and delete all existing ip permission if there were any

#### Command Usage

Syntax: 

`yc container registry set-ip-permissions <REGISTRY-NAME>|<REGISTRY-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Registry id.|
|`--name`|<b>`string`</b><br/>Registry name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--pull`|<b>`value[,value]`</b><br/>Pull ip permission to set. Can be used multiple times.|
|`--push`|<b>`value[,value]`</b><br/>Push ip permission to set. Can be used multiple times.|
|`-y`,`--yes`|Automatic yes to prompts.|

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

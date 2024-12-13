---
editable: false
sourcePath: en/_cli-ref/cli-ref/kms/cli-ref/symmetric-key/update.md
---

# yc kms symmetric-key update

Update the specified symmetric key

#### Command Usage

Syntax: 

`yc kms symmetric-key update <SYMMETRIC-KEY> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Symmetric key id.|
|`--name`|<b>`string`</b><br/>Symmetric key name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name of a symmetric key.|
|`--description`|<b>`string`</b><br/>New description of a symmetric key.|
|`--status`|<b>`string`</b><br/>New status of a symmetric key. Values: 'creating', 'active', 'inactive'|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of new label KEY=VALUE pairs to update.|
|`--default-algorithm`|<b>`string`</b><br/>New default symmetric key version algorithm. Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm'|
|`--rotation-period`|<b>`duration`</b><br/>New rotation period for symmetric key version.|
|`--deletion-protection`|Inhibits deletion of a symmetric key.|
|`--no-deletion-protection`|Allows deletion of a symmetric key.|

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

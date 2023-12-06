---
editable: false
---

# yc kms asymmetric-encryption-key update

Update the specified asymmetric encryption key

#### Command Usage

Syntax: 

`yc kms asymmetric-encryption-key update <ASYMMETRIC-ENCRYPTION-KEY> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Asymmetric encryption key id.|
|`--name`|<b>`string`</b><br/>Asymmetric encryption key name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name of an asymmetric encryption key.|
|`--description`|<b>`string`</b><br/>New description of an asymmetric encryption key.|
|`--status`|<b>`string`</b><br/>New status of a asymmetric encryption key. Values: 'creating', 'active', 'inactive'|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of new label KEY=VALUE pairs to update.|
|`--deletion-protection`|Inhibits deletion of an asymmetric encryption key.|
|`--no-deletion-protection`|Allows deletion of an asymmetric encryption key.|

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

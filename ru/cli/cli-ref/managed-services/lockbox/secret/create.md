---
sourcePath: en/_cli-ref/cli-ref/managed-services/lockbox/secret/create.md
---
# yc lockbox secret create

Create a secret

#### Command Usage

Syntax: 

`yc lockbox secret create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Secret name.|
|`--description`|<b>`string`</b><br/>Secret description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add.|
|`--kms-key-id`|<b>`string`</b><br/>KMS key ID will be used to encrypt the secret payload.|
|`--version-description`|<b>`string`</b><br/>Description of the first version.|
|`--payload`|<b>`string`</b><br/>YAML or JSON array defining the entries of the secret payload.<br/>Each item of the array must match the format: https://cloud.yandex.com/docs/lockbox/api-ref/grpc/secret_service#PayloadEntryChange<br/>For instance, the following payload JSON defines a payload containing two text value entries:<br/>[{"key": "username", "text_value": "alice"}, {"key": "password", "text_value": "p@$$w0rd"}]<br/>Use - value to pass payload string via stdin.|
|`--deletion-protection`|Enable deletion protection for the secret.|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|

---
sourcePath: en/_cli-ref/cli-ref/managed-services/lockbox/secret/add-version.md
---
# yc lockbox secret add-version

Add new payload version for the specified secret based on an existing one

#### Command Usage

Syntax: 

`yc lockbox secret add-version <SECRET-NAME>|<SECRET-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Secret id.|
|`--name`|<b>`string`</b><br/>Secret name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--description`|<b>`string`</b><br/>Version description.|
|`--payload`|<b>`string`</b><br/>YAML or JSON array defining how to change payload from the base version. Each item of the array must match the format: https://cloud.yandex.com/docs/lockbox/api-ref/grpc/secret_service#PayloadEntryChange For instance, to modify the value of "password" entry from the base version payload: [{"key": "username", "text_value": "alice"}, {"key": "password", "text_value": "p@$$w0rd"}] the following JSON can be passed: [{"key": "password", "text_value": "another-p@$$w0rd"}] so the resulting payload of the newly added version will be: [{"key": "username", "text_value": "alice"}, {"key": "password", "text_value": "another-p@$$w0rd"}] To remove the entry pass an item containing only the "key" field, e.g.: [..., {"key": "the-key-of-the-entry-to-remove"}, ...] Use - value to pass payload string via stdin.|
|`--base-version-id`|<b>`string`</b><br/>Base version id. By default, the current one is used.|

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

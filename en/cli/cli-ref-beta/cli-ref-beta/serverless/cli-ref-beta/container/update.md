---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/container/update.md
---

# yc beta serverless container update

Updates the specified container.

#### Command Usage

Syntax: 

`yc beta serverless container update <CONTAINER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--container-id`|<b>`string`</b><br/>ID of the container to update.<br/><br/>To get a container ID make a [ContainerService.List] request.|
|`--description`|<b>`string`</b><br/>New description for the container.|
|`--labels`|<b>`stringToString`</b><br/>Container labels as 'key:value' pairs.<br/><br/>Existing set of labels is completely replaced by the provided set, so if you just want<br/>to add or remove a label, request the current set of labels with a [ContainerService.Get] request.|
|`--name`|<b>`string`</b><br/>New name for the container.<br/>The name must be unique within the folder.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|

---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/container/repository/lifecycle-policy/create.md
---

# yc container repository lifecycle-policy create

Create a lifecycle policy.

#### Command Usage

Syntax: 

`yc container repository lifecycle-policy create <LIFECYCLE-POLICY-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the lifecycle policy.|
|`--repository-id`|<b>`string`</b><br/>Repository id.|
|`--repository-name`|<b>`string`</b><br/>Repository name.|
|`--active`|Make the lifecycle policy active..|
|`--description`|<b>`string`</b><br/>Description of the lifecycle policy.|
|`--rules`|<b>`string`</b><br/>Path to a file with lifecycle rules in json format. File content example: [{"description": "rule description", "expire_period": "48h", "tag_regexp": ".*", "untagged": true, "retained_top": 5}]|
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

---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/oslogin/user-ssh-key/create.md
---

# yc organization-manager oslogin user-ssh-key create

Create a user SSH key

#### Command Usage

Syntax: 

`yc organization-manager oslogin user-ssh-key create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--organization-id`|<b>`string`</b><br/>Set the ID of the organization to use.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--name`|<b>`string`</b><br/>A name for the SSH key.|
|`--subject-id`|<b>`string`</b><br/>The ID of the subject who owns the key.|
|`--data`|<b>`string`</b><br/>SSH public key.|
|`--expires-at`|<b>`timestamp`</b><br/>The date/time after which the key is considered expired.|

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

---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/resource-manager/folder/remove-access-binding.md
---

# yc resource-manager folder remove-access-binding

Remove access binding for the specified folder

#### Command Usage

Syntax: 

`yc resource-manager folder remove-access-binding <FOLDER-NAME>|<FOLDER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Folder id.|
|`--name`|<b>`string`</b><br/>Folder name.|
|`--role`|<b>`string`</b><br/>Binding role ID.|
|`--service-account-id`|<b>`string`</b><br/>Service account, whose access will be updated.|
|`--service-account-name`|<b>`string`</b><br/>Service account, whose access will be updated.|
|`--user-account-id`|<b>`string`</b><br/>User account, whose access will be updated.|
|`--user-yandex-login`|<b>`string`</b><br/>User account, whose access will be updated.|
|`--agent`|<b>`string`</b><br/>Agent service account, whose access will be updated; in SERVICE_ID:MICROSERVICE_ID format.|
|`--all-authenticated-users`|Access will be updated for all authenticated users|
|`--group-members`|<b>`string`</b><br/>Update access for members of the group with specified ID|
|`--organization-users`|<b>`string`</b><br/>Update access for users of organization with specified ID|
|`--federation-users`|<b>`string`</b><br/>Update access for users of federation with specified ID|
|`--subject`|<b>`string`</b><br/>Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:\<ID\>, serviceAccount:\<ID\>, system:\<ID\>.|
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
|`-h`,`--help`|Display help for the command.|

---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/user/create.md
---

# yc organization-manager idp user create

Create a user in the specified user pool

#### Command Usage

Syntax: 

`yc organization-manager idp user create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--userpool-id`|<b>`string`</b><br/>ID of the userpool to create the user in|
|`--username`|<b>`string`</b><br/>Username for the new user|
|`--full-name`|<b>`string`</b><br/>Full name of the user|
|`--given-name`|<b>`string`</b><br/>First name of the user|
|`--family-name`|<b>`string`</b><br/>Last name of the user|
|`--email`|<b>`string`</b><br/>Email address of the user|
|`--phone-number`|<b>`string`</b><br/>Phone number of the user|
|`--password`|<b>`string`</b><br/>Password for the user|
|`--external-id`|<b>`string`</b><br/>External identifier for the user|
|`--is-active`|Whether the user is active|

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

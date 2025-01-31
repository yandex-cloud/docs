---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/refresh-token/list.md
---

# yc iam refresh-token list

List subjects Refresh Tokens

#### Command Usage

Syntax: 

`yc iam refresh-token list [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--limit`|<b>`int`</b><br/>The maximum number of items to list. Default is 1000 items|
|`--subject-id`|<b>`string`</b><br/>Subject Id for which the token was issued.|
|`--client-id`|<b>`string`</b><br/>Client Id for which the token was issued.|
|`--client-instance-info`|<b>`string`</b><br/>Client Instance Info for which the token was issued.|
|`--protection-level`|<b>`string`</b><br/>Protection Level of refresh token. Valid values: NO_PROTECTION, INSECURE_KEY_DPOP, SECURE_KEY_DPOP|

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

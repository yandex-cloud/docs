---
editable: false
---

# yc storage s3api head-object

Returns object metadata from Object Storage

#### Command Usage

Syntax: 

`yc storage s3api head-object [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--bucket`|<b>`string`</b><br/>[REQUIRED] Bucket name|
|`--key`|<b>`string`</b><br/>[REQUIRED] Object key|
|`--version-id`|<b>`string`</b><br/>Version ID used to reference a specific version of the object.|
|`--if-match`|<b>`string`</b><br/>Return the object only if its ETag is the same as the one specified in this Header.|
|`--if-none-match`|<b>`string`</b><br/>Return the object only if its ETag is different from the one specified in this Header.|
|`--if-modified-since`|<b>`timestamp`</b><br/>Return the object only if it has been modified since the specified time.|
|`--if-unmodified-since`|<b>`timestamp`</b><br/>Return the object only if it has not been modified since the specified time.|
|`--range`|<b>`string`</b><br/>Fetches the specified byte range of an object.|

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

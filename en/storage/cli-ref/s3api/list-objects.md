---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3api/list-objects.md
---

# yc storage s3api list-objects

Lists objects in a bucket using listObjectsV2 http method

#### Command Usage

Syntax: 

`yc storage s3api list-objects [Flags...] [Global Flags...]`

Aliases: 

- `list-objects-v2`

#### Flags

| Flag | Description |
|----|----|
|`--bucket`|<b>`string`</b><br/>[REQUIRED] Bucket name|
|`--prefix`|<b>`string`</b><br/>Limits the response to keys that begin with the specified prefix.|
|`--delimiter`|<b>`string`</b><br/>A delimiter is a character that is used to group keys.|
|`--start-after`|<b>`string`</b><br/>Starts listing after this specified key. StartAfter can be used with listing objects in a bucket.|
|`--max-keys`|<b>`int32`</b><br/>The maximum number of keys returned in the response. By default, the action returns up to 1,000 key names.|
|`--continuation-token`|<b>`string`</b><br/>Used to continue a list objects operation. Contains the value returned as NextContinuationToken in the previous response.|
|`--fetch-owner`|Specifies whether to include the owner information in the response. By default, this is not included.|

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

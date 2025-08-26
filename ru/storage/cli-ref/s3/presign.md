---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3/presign.md
---

# yc storage s3 presign

Generate pre-signed URLs for S3 objects

#### Command Usage

Syntax: 

`yc storage s3 presign <S3Uri> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--expires-in`|<b>`int`</b><br/>Number of seconds until the pre-signed URL expires (default: 3600, max: 604800)|
|`--local`|Generate pre-signed URL locally without using API|
|`--access-key`|<b>`string`</b><br/>Access key for local S3 authentication|
|`--secret-key`|<b>`string`</b><br/>Secret key for local S3 authentication|
|`--as-attachment`|Generate pre-signed URL that forces file download as attachment|

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

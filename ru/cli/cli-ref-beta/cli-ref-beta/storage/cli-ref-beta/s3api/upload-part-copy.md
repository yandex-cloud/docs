---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3api/upload-part-copy.md
---

# yc beta storage s3api upload-part-copy

Uploads a part by copying data from an existing object as data source

#### Command Usage

Syntax: 

`yc beta storage s3api upload-part-copy [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Bucket name|
|`--key`|<b>`string`</b><br/>Object key|
|`--upload-id`|<b>`string`</b><br/>Upload ID is used to reference a specific upload.|
|`--part-number`|<b>`int32`</b><br/>Part number of the object being uploaded.|
|`--copy-source`|<b>`string`</b><br/>Specifies the source object for the copy operation.|
|`--copy-source-range`|<b>`string`</b><br/>The range of bytes to copy from the source object (e.g., bytes=0-9)|
|`--copy-source-if-match`|<b>`string`</b><br/>Copies the object if its entity tag (ETag) matches the specified tag.|
|`--copy-source-if-modified-since`|<b>`time`</b><br/>Copies the object if it has been modified since the specified time. (RFC3339)|
|`--copy-source-if-none-match`|<b>`string`</b><br/>Copies the object if its entity tag (ETag) is different than the specified ETag.|
|`--copy-source-if-unmodified-since`|<b>`time`</b><br/>Copies the object if it hasn't been modified since the specified time. (RFC3339)|

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

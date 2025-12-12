---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3api/upload-part.md
---

# yc beta storage s3api upload-part

Uploads a part in a multipart upload

#### Command Usage

Syntax: 

`yc beta storage s3api upload-part [Flags...] [Global Flags...]`

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
|`--body`|<b>`string`</b><br/>Object data.|
|`--content-md5`|<b>`string`</b><br/>128-bit MD5 hash value of the request body, base64 encoded.|
|`--content-length`|<b>`int`</b><br/>Length of the request body (without headers) in compliance with RFC 2616.|

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

---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3api/get-object.md
---

# yc beta storage s3api get-object

Returns an object from Object Storage

#### Command Usage

Syntax: 

`yc beta storage s3api get-object [Flags...] [Global Flags...] <outfile>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Bucket name|
|`--key`|<b>`string`</b><br/>Object key|
|`--version-id`|<b>`string`</b><br/>Object version ID.|
|`--if-match`|<b>`string`</b><br/>Return the object only if its ETag matches the specified value.|
|`--if-none-match`|<b>`string`</b><br/>Return the object only if its ETag is different from the specified value.|
|`--if-modified-since`|<b>`time`</b><br/>Return the object only if it has been modified since the specified time. (RFC3339)|
|`--if-unmodified-since`|<b>`time`</b><br/>Return the object only if it has not been modified since the specified time. (RFC3339)|
|`--range`|<b>`string`</b><br/>Byte range of the object to retrieve.|
|`--response-cache-control`|<b>`string`</b><br/>Overrides Cache-Control in the response.|
|`--response-content-disposition`|<b>`string`</b><br/>Overrides Content-Disposition in the response.|
|`--response-content-encoding`|<b>`string`</b><br/>Overrides Content-Encoding in the response.|
|`--response-content-language`|<b>`string`</b><br/>Overrides Content-Language in the response.|
|`--response-content-type`|<b>`string`</b><br/>Overrides Content-Type in the response.|
|`--response-expires`|<b>`time`</b><br/>Overrides Expires in the response. (RFC3339)|

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

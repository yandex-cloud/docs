---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3api/copy-object.md
---

# yc beta storage s3api copy-object

Creates a copy of an object that is already stored in Object Storage

#### Command Usage

Syntax: 

`yc beta storage s3api copy-object [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Bucket name|
|`--copy-source`|<b>`string`</b><br/>Specifies the source object for the copy operation.|
|`--key`|<b>`string`</b><br/>Object key|
|`--acl`|<b>`string`</b><br/>Sets a predefined ACL for an object.|
|`--cache-control`|<b>`string`</b><br/>Directives for caching data according to RFC 2616.|
|`--content-disposition`|<b>`string`</b><br/>Filename suggestion for saving the object.|
|`--content-encoding`|<b>`string`</b><br/>Defines the content encoding according to RFC 2616.|
|`--content-type`|<b>`string`</b><br/>Data type in a request.|
|`--copy-source-if-match`|<b>`string`</b><br/>Copies the object only if its ETag matches the specified tag.|
|`--copy-source-if-none-match`|<b>`string`</b><br/>Copies the object only if its ETag is different from the specified tag.|
|`--copy-source-if-modified-since`|<b>`time`</b><br/>Copies the object if it has been modified since the specified time. (RFC3339)|
|`--copy-source-if-unmodified-since`|<b>`time`</b><br/>Copies the object if it has not been modified since the specified time. (RFC3339)|
|`--expires`|<b>`time`</b><br/>Response expiration date. (RFC3339)|
|`--grant-full-control`|<b>`string`</b><br/>Grants READ, WRITE, READ_ACP, WRITE_ACP permissions.|
|`--grant-read`|<b>`string`</b><br/>Grants read permission.|
|`--grant-read-acp`|<b>`string`</b><br/>Grants ACL read permission.|
|`--grant-write-acp`|<b>`string`</b><br/>Grants ACL write permission.|
|`--metadata`|<b>`stringToString`</b><br/>User-defined metadata.|
|`--metadata-directive`|<b>`string`</b><br/>Whether metadata is copied or replaced.|
|`--storage-class`|<b>`string`</b><br/>Object storage class.|
|`--server-side-encryption`|<b>`string`</b><br/>The encryption algorithm used for upload.|
|`--ssekms-key-id`|<b>`string`</b><br/>KMS key ID for encryption.|
|`--object-lock-mode`|<b>`string`</b><br/>Type of retention applied (GOVERNANCE/COMPLIANCE).|
|`--object-lock-retain-until-date`|<b>`time`</b><br/>Date and time until which the object is retained. (RFC3339)|
|`--object-lock-legal-hold-status`|<b>`string`</b><br/>Type of legal hold applied to the object.|

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

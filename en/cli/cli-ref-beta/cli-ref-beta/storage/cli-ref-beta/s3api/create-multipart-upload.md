---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/s3api/create-multipart-upload.md
---

# yc beta storage s3api create-multipart-upload

Creates a new multipart upload

#### Command Usage

Syntax: 

`yc beta storage s3api create-multipart-upload [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Bucket name|
|`--key`|<b>`string`</b><br/>Object key|
|`--acl`|<b>`string`</b><br/>Sets a predefined ACL for an object.|
|`--cache-control`|<b>`string`</b><br/>Directives for caching data according to RFC 2616.|
|`--content-disposition`|<b>`string`</b><br/>Name Object Storage will suggest for the object to save it as a file when downloaded.|
|`--content-encoding`|<b>`string`</b><br/>Defines the content encoding according to RFC 2616.|
|`--content-type`|<b>`string`</b><br/>Data type in a request.|
|`--expires`|<b>`time`</b><br/>Response expiration date. (RFC3339)|
|`--grant-full-control`|<b>`string`</b><br/>Grants the access grantee the following permissions: READ, WRITE, READ_ACP, and WRITE_ACP for an object.|
|`--grant-read`|<b>`string`</b><br/>Grants the access grantee object read permission.|
|`--grant-read-acp`|<b>`string`</b><br/>Grants the access grantee object ACL read permission.|
|`--grant-write-acp`|<b>`string`</b><br/>Grants the access grantee object ACL write permission.|
|`--metadata`|<b>`stringToString`</b><br/>User-defined metadata.|
|`--storage-class`|<b>`string`</b><br/>Object storage class.|
|`--server-side-encryption`|<b>`string`</b><br/>The encryption algorithm of an uploaded object. Possible values: aws:kms.|
|`--ssekms-key-id`|<b>`string`</b><br/>The ID of the KMS key for encrypting an uploaded object.|
|`--object-lock-mode`|<b>`string`</b><br/>Type of retention put on the object (if the bucket is versioned and object lock is enabled in it).|
|`--object-lock-retain-until-date`|<b>`time`</b><br/>Date and time until which the object is retained. (RFC3339)|
|`--object-lock-legal-hold-status`|<b>`string`</b><br/>Type of legal hold put on the object.|

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

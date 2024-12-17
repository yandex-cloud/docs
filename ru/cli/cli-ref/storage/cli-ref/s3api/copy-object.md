---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3api/copy-object.md
---

# yc storage s3api copy-object

Creates a copy of an object that is already stored in Object Storage

#### Command Usage

Syntax: 

`yc storage s3api copy-object [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--bucket`|<b>`string`</b><br/>[REQUIRED] Bucket name|
|`--copy-source`|<b>`string`</b><br/>Specifies the source object for the copy operation.|
|`--key`|<b>`string`</b><br/>[REQUIRED] Object key|
|`--acl`|<b>`string`</b><br/>Sets a predefined ACL for an object.|
|`--cache-control`|<b>`string`</b><br/>Directives for caching data according to RFC 2616.|
|`--content-disposition`|<b>`string`</b><br/>Name Object Storage will suggest for the object to save it as a file when downloaded. Compliant with RFC 2616.|
|`--content-encoding`|<b>`string`</b><br/>Defines the content encoding according to RFC 2616.|
|`--content-type`|<b>`string`</b><br/>Data type in a request.|
|`--copy-source-if-match`|<b>`string`</b><br/>Copies the object if its entity tag (ETag) matches the specified tag.|
|`--copy-source-if-none-match`|<b>`string`</b><br/>Copies the object if its entity tag (ETag) is different than the specified ETag.|
|`--copy-source-if-modified-since`|<b>`timestamp`</b><br/>Copies the object if it has been modified since the specified time.|
|`--copy-source-if-unmodified-since`|<b>`timestamp`</b><br/>Copies the object if it hasnt been modified since the specified time.|
|`--expires`|<b>`timestamp`</b><br/>Response expiration date.|
|`--grant-full-control`|<b>`string`</b><br/>Grants the access grantee the following permissions: READ, WRITE, READ_ACP, and WRITE_ACP for an object.|
|`--grant-read`|<b>`string`</b><br/>Grants the access grantee object read permission.|
|`--grant-read-acp`|<b>`string`</b><br/>Grants the access grantee object ACL read permission.|
|`--grant-write-acp`|<b>`string`</b><br/>Grants the access grantee object ACL write permission.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/>User-defined metadata.|
|`--metadata-directive`|<b>`string`</b><br/>Specifies whether the metadata is copied from the source object or replaced with metadata thats provided in the request.|
|`--storage-class`|<b>`string`</b><br/>Object storage class.|
|`--server-side-encryption`|<b>`string`</b><br/>The encryption algorithm of an uploaded object. Possible values: aws:kms.|
|`--ssekms-key-id`|<b>`string`</b><br/>The ID of the KMS key for encrypting an uploaded object.|
|`--object-lock-mode`|<b>`string`</b><br/>Type of retention put on the object (if the bucket is versioned and object lock is enabled in it). Possible values: GOVERNANCE and COMPLIANCE|
|`--object-lock-retain-until-date`|<b>`timestamp`</b><br/>Date and time until which the object is retained.|
|`--object-lock-legal-hold-status`|<b>`string`</b><br/>Type of legal hold put on the object.|

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

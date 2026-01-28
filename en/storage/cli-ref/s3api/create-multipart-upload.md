---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3api/create-multipart-upload.md
---

# yc storage s3api create-multipart-upload

Creates a new multipart upload

#### Command Usage

Syntax:

`yc storage s3api create-multipart-upload [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--key` | `string`

[REQUIRED] Object key ||
|| `--acl` | `string`

Sets a predefined ACL for an object. ||
|| `--cache-control` | `string`

Directives for caching data according to RFC 2616. ||
|| `--content-disposition` | `string`

Name Object Storage will suggest for the object to save it as a file when downloaded. Compliant with RFC 2616. ||
|| `--content-encoding` | `string`

Defines the content encoding according to RFC 2616. ||
|| `--content-type` | `string`

Data type in a request. ||
|| `--expires` | `timestamp`

Response expiration date. ||
|| `--grant-full-control` | `string`

Grants the access grantee the following permissions: READ, WRITE, READ_ACP, and WRITE_ACP for an object. ||
|| `--grant-read` | `string`

Grants the access grantee object read permission. ||
|| `--grant-read-acp` | `string`

Grants the access grantee object ACL read permission. ||
|| `--grant-write-acp` | `string`

Grants the access grantee object ACL write permission. ||
|| `--metadata` | `key=value[,key=value...]`

User-defined metadata. ||
|| `--storage-class` | `string`

Object storage class. ||
|| `--server-side-encryption` | `string`

The encryption algorithm of an uploaded object. Possible values: aws:kms. ||
|| `--ssekms-key-id` | `string`

The ID of the KMS key for encrypting an uploaded object. ||
|| `--object-lock-mode` | `string`

Type of retention put on the object (if the bucket is versioned and object lock is enabled in it). Possible values: GOVERNANCE and COMPLIANCE ||
|| `--object-lock-retain-until-date` | `timestamp`

Date and time until which the object is retained. ||
|| `--object-lock-legal-hold-status` | `string`

Type of legal hold put on the object. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
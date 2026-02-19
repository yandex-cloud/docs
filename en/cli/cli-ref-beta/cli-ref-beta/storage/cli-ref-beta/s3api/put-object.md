---
editable: false
noIndex: true
---

# yc beta storage s3api put-object

Puts an object and its metadata to Object Storage

#### Command Usage

Syntax:

`yc beta storage s3api put-object [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--bucket` | `string`

Bucket name ||
|| `--key` | `string`

Object key ||
|| `--acl` | `string`

Sets a predefined ACL for an object. ||
|| `--body` | `string`

Object data: literal string, @path/to/file or - for stdin. ||
|| `--cache-control` | `string`

Directives for caching data according to RFC 2616. ||
|| `--content-disposition` | `string`

Filename suggestion for saving the object. ||
|| `--content-encoding` | `string`

Defines the content encoding according to RFC 2616. ||
|| `--content-md5` | `string`

Base64-encoded 128-bit MD5 digest of the message. ||
|| `--content-type` | `string`

Data type in a request. ||
|| `--expires` | `time`

Response expiration date. (RFC3339) ||
|| `--grant-full-control` | `string`

Grants READ, WRITE, READ_ACP, WRITE_ACP permissions. ||
|| `--grant-read` | `string`

Grants read permission. ||
|| `--grant-read-acp` | `string`

Grants ACL read permission. ||
|| `--grant-write-acp` | `string`

Grants ACL write permission. ||
|| `--metadata` | `map<string><string>`

User-defined metadata. ||
|| `--storage-class` | `string`

Object storage class. ||
|| `--server-side-encryption` | `string`

The encryption algorithm used for upload. ||
|| `--ssekms-key-id` | `string`

KMS key ID for encryption. ||
|| `--object-lock-mode` | `string`

Type of retention applied (GOVERNANCE/COMPLIANCE). ||
|| `--object-lock-retain-until-date` | `time`

Date and time until which the object is retained. (RFC3339) ||
|| `--object-lock-legal-hold-status` | `string`

Type of legal hold applied to the object. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
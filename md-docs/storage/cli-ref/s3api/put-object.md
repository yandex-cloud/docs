[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Справочник YC CLI (англ.)](../index.md) > [s3api](index.md) > put-object

# yc storage s3api put-object

Puts an object and its metadata to Object Storage

#### Command Usage

Syntax:

`yc storage s3api put-object [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
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
|| `--expires` | `timestamp`

Response expiration date. (RFC3339) ||
|| `--grant-full-control` | `string`

Grants READ, WRITE, READ_ACP, WRITE_ACP permissions. ||
|| `--grant-read` | `string`

Grants read permission. ||
|| `--grant-read-acp` | `string`

Grants ACL read permission. ||
|| `--grant-write-acp` | `string`

Grants ACL write permission. ||
|| `--metadata` | `key=value[,key=value...]`

User-defined metadata. ||
|| `--storage-class` | `string`

Object storage class. ||
|| `--server-side-encryption` | `string`

The encryption algorithm used for upload. ||
|| `--ssekms-key-id` | `string`

KMS key ID for encryption. ||
|| `--object-lock-mode` | `string`

Type of retention applied (GOVERNANCE/COMPLIANCE). ||
|| `--object-lock-retain-until-date` | `timestamp`

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
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
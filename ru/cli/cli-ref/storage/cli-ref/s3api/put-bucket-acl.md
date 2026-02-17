---
editable: false
---

# yc storage s3api put-bucket-acl

Sets bucket access control list

#### Command Usage

Syntax:

`yc storage s3api put-bucket-acl [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--key` | `string`

[REQUIRED] Object key ||
|| `--acl` | `string`

Sets a predefined ACL for an object. ||
|| `--access-control-policy` | `string`

Contains the elements that set the ACL permissions for an object per grantee. ||
|| `--grant-full-control` | `string`

Grants the access grantee the following permissions: READ, WRITE, READ_ACP, and WRITE_ACP for an object. ||
|| `--grant-read` | `string`

Grants the access grantee object read permission. ||
|| `--grant-read-acp` | `string`

Grants the access grantee object ACL read permission. ||
|| `--grant-write-acp` | `string`

Grants the access grantee object ACL write permission. ||
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
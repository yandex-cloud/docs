---
editable: false
---

# yc storage s3api head-object

Returns object metadata from Object Storage

#### Command Usage

Syntax:

`yc storage s3api head-object [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--key` | `string`

[REQUIRED] Object key ||
|| `--version-id` | `string`

Version ID used to reference a specific version of the object. ||
|| `--if-match` | `string`

Return the object only if its ETag is the same as the one specified in this Header. ||
|| `--if-none-match` | `string`

Return the object only if its ETag is different from the one specified in this Header. ||
|| `--if-modified-since` | `timestamp`

Return the object only if it has been modified since the specified time. ||
|| `--if-unmodified-since` | `timestamp`

Return the object only if it has not been modified since the specified time. ||
|| `--range` | `string`

Fetches the specified byte range of an object. ||
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
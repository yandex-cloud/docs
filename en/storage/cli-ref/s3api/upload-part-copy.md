---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/storage/cli-ref/s3api/upload-part-copy/
---

# yc storage s3api upload-part-copy

Uploads a part by copying data from an existing object as data source

#### Command Usage

Syntax:

`yc storage s3api upload-part-copy [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

Bucket name ||
|| `--key` | `string`

Object key ||
|| `--upload-id` | `string`

Upload ID is used to reference a specific upload. ||
|| `--part-number` | `int32`

Part number of the object being uploaded. ||
|| `--copy-source` | `string`

Specifies the source object for the copy operation. ||
|| `--copy-source-range` | `string`

The range of bytes to copy from the source object (e.g., bytes=0-9) ||
|| `--copy-source-if-match` | `string`

Copies the object if its entity tag (ETag) matches the specified tag. ||
|| `--copy-source-if-none-match` | `string`

Copies the object if its entity tag (ETag) is different than the specified ETag. ||
|| `--copy-source-if-modified-since` | `timestamp`

Copies the object if it has been modified since the specified time. (RFC3339) ||
|| `--copy-source-if-unmodified-since` | `timestamp`

Copies the object if it hasn't been modified since the specified time. (RFC3339) ||
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
---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3api/list-multipart-uploads.md
---

# yc storage s3api list-multipart-uploads

Lists in-progress multipart uploads

#### Command Usage

Syntax:

`yc storage s3api list-multipart-uploads [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--delimiter` | `string`

A delimiter is a character that is used to group keys. ||
|| `--page-size` | `int32`

The number of items to return per page. ||
|| `--starting-token` | `string`

A token to specify where to start paginating. This is the NextToken from a previously truncated response. ||
|| `--prefix` | `string`

Limits the response to keys that begin with the specified prefix. ||
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
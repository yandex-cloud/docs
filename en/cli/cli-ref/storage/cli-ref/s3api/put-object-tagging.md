---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3api/put-object-tagging.md
---

# yc storage s3api put-object-tagging

Adds labels to a bucket object. This overwrites any existing object labels

#### Command Usage

Syntax:

`yc storage s3api put-object-tagging [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--key` | `string`

[REQUIRED] Object key ||
|| `--version-id` | `string`

Version ID used to reference a specific version of the object. ||
|| `--tagging` | `string`

[REQUIRED] Set of tags for the object. Syntax: TagSet=[{Key=string,Value=string},{Key=string,Value=string}] ||
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
---
editable: false
noIndex: true
---

# yc beta storage s3api upload-part-copy

Uploads a part by copying data from an existing object as data source

#### Command Usage

Syntax:

`yc beta storage s3api upload-part-copy [Flags...] [Global Flags...]`

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
|| `--copy-source-if-modified-since` | `time`

Copies the object if it has been modified since the specified time. (RFC3339) ||
|| `--copy-source-if-none-match` | `string`

Copies the object if its entity tag (ETag) is different than the specified ETag. ||
|| `--copy-source-if-unmodified-since` | `time`

Copies the object if it hasn't been modified since the specified time. (RFC3339) ||
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
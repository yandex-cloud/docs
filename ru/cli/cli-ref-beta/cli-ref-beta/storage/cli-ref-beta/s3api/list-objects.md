---
editable: false
noIndex: true
---

# yc beta storage s3api list-objects

Lists objects in a bucket using listObjectsV2 http method

#### Command Usage

Syntax:

`yc beta storage s3api list-objects [Flags...] [Global Flags...]`

Aliases:

- `list-objects-v2`

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
|| `--prefix` | `string`

Limits the response to keys that begin with the specified prefix. ||
|| `--delimiter` | `string`

A delimiter is a character that is used to group keys. ||
|| `--start-after` | `string`

Starts listing after this specified key. StartAfter can be used with listing objects in a bucket. ||
|| `--max-keys` | `int32`

The maximum number of keys returned in the response. By default, the action returns up to 1,000 key names. ||
|| `--continuation-token` | `string`

Used to continue a list objects operation. Contains the value returned as NextContinuationToken in the previous response. ||
|| `--fetch-owner` | Specifies whether to include the owner information in the response. By default, this is not included. ||
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
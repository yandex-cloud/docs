[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Справочник YC CLI (англ.)](../index.md) > [s3api](index.md) > list-objects

# yc storage s3api list-objects

Lists objects in a bucket using listObjectsV2 http method

#### Command Usage

Syntax:

`yc storage s3api list-objects [Flags...] [Global Flags...]`

Aliases:

- `list-objects-v2`

#### Flags

#|
||Flag | Description ||
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
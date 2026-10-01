[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > [Справочник YC CLI (англ.)](../../index.md) > [v0](../index.md) > [s3api](index.md) > get-object

# yc storage v0 s3api get-object

Returns an object from Object Storage

#### Command Usage

Syntax:

`yc storage v0 s3api get-object [Flags...] [Global Flags...] <outfile>`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

Bucket name ||
|| `--key` | `string`

Object key ||
|| `--version-id` | `string`

Object version ID. ||
|| `--if-match` | `string`

Return the object only if its ETag matches the specified value. ||
|| `--if-none-match` | `string`

Return the object only if its ETag is different from the specified value. ||
|| `--if-modified-since` | `timestamp`

Return the object only if it has been modified since the specified time. (RFC3339) ||
|| `--if-unmodified-since` | `timestamp`

Return the object only if it has not been modified since the specified time. (RFC3339) ||
|| `--range` | `string`

Byte range of the object to retrieve. ||
|| `--response-cache-control` | `string`

Overrides Cache-Control in the response. ||
|| `--response-content-disposition` | `string`

Overrides Content-Disposition in the response. ||
|| `--response-content-encoding` | `string`

Overrides Content-Encoding in the response. ||
|| `--response-content-language` | `string`

Overrides Content-Language in the response. ||
|| `--response-content-type` | `string`

Overrides Content-Type in the response. ||
|| `--response-expires` | `timestamp`

Overrides Expires in the response. (RFC3339) ||
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
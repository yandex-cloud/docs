---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/storage/cli-ref/v0/s3/presign/
---

# yc storage v0 s3 presign

Generate pre-signed URLs for S3 objects

#### Command Usage

Syntax:

`yc storage v0 s3 presign <S3URI> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--expires-in` | `int`

Number of seconds until the pre-signed URL expires (default: 3600) ||
|| `--local` | Generate pre-signed URL locally without using API ||
|| `--access-key` | `string`

Access key ID to use when generating a local presigned URL. ||
|| `--secret-key` | `string`

Secret key to use when generating a local presigned URL. ||
|| `--as-attachment` | Set Content-Disposition=attachment so that the browser suggests downloading the object. ||
|| `--http-method` | `string`

HTTP method for the pre-signed URL. Values: GET, PUT. ||
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
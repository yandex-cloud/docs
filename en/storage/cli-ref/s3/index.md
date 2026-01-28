---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/s3/index.md
---

# yc storage s3

[PREVIEW] An aws s3-like interface

#### Command Usage

Syntax:

`yc storage s3 <command>`

#### Command Tree

- [yc storage s3 cp](cp.md) — Copies a local file or S3 object to another location locally or in S3

- [yc storage s3 mv](mv.md) — Moves a local file or S3 object to another location locally or in S3

- [yc storage s3 presign](presign.md) — Generate pre-signed URLs for S3 objects

- [yc storage s3 rm](rm.md) — Deletes an S3 object

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
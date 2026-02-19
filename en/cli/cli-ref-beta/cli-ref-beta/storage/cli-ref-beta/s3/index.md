---
editable: false
noIndex: true
---

# yc beta storage s3

[PREVIEW] An aws s3-like interface

#### Command Usage

Syntax:

`yc beta storage s3 <command>`

#### Command Tree

- [yc beta storage s3 cp](cp.md) — Copies a local file or S3 object to another location locally or in S3

- [yc beta storage s3 mv](mv.md) — Moves a local file or S3 object to another location locally or in S3

- [yc beta storage s3 presign](presign.md) — Generate pre-signed URLs for S3 objects

- [yc beta storage s3 rm](rm.md) — Deletes an S3 object

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
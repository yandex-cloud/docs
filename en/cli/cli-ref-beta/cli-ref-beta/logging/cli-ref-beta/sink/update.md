---
editable: false
noIndex: true
---

# yc beta logging sink update

Updates the specified sink.

#### Command Usage

Syntax:

`yc beta logging sink update <SINK-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New Description of the sink. ||
|| `--labels` | `map<string><string>`

New sink labels as 'key:value' pairs. ||
|| `--name` | `string`

New name of the sink. The name must be unique within the folder. ||
|| `--service-account-id` | `string`

new service account to use for logs writing to the sink. ||
|| `--sink-id` | `string`

ID of the sink to update. To get a sink ID make a [SinkService.List] request. ||
|| `--yds` | `shorthand/json`

Yandex data stream

Shorthand Syntax:

```hcl
{
  stream-name = string
}
```

JSON Syntax:

```json
{
  "stream-name": "string"
}
```

Fields:

```
stream-name -> (string)
  Fully qualified name of data stream
``` ||
|| `--s3` | `shorthand/json`

Object storage

Shorthand Syntax:

```hcl
{
  bucket = string,
  prefix = string
}
```

JSON Syntax:

```json
{
  "bucket": "string",
  "prefix": "string"
}
```

Fields:

```
bucket -> (string)
  Object storage bucket
prefix -> (string)
  Prefix to use for saved log object names
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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
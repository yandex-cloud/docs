---
editable: false
noIndex: true
---

# yc beta logging export update

Updates the specified export.

#### Command Usage

Syntax:

`yc beta logging export update <EXPORT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New Description of the export. ||
|| `--export-id` | `string`

ID of the export to update. To get a export ID make a [ExportService.List] request. ||
|| `--group-id` | `string`

New logging Group ID logs exported from ||
|| `--labels` | `map<string><string>`

New export labels as 'key:value' pairs. ||
|| `--name` | `string`

New name of the export. The name must be unique within the folder. ||
|| `--params` | `shorthand/json`

New parameters for logs filtration

Shorthand Syntax:

```hcl
{
  filter = string,
  levels = [
    TRACE|DEBUG|INFO|WARN|ERROR|FATAL, ...
  ],
  resource-ids = string,...,
  resource-types = string,...,
  stream-names = string,...
}
```

JSON Syntax:

```json
{
  "filter": "string",
  "levels": [
    "TRACE|DEBUG|INFO|WARN|ERROR|FATAL", ...
  ],
  "resource-ids": [
    "string", ...
  ],
  "resource-types": [
    "string", ...
  ],
  "stream-names": [
    "string", ...
  ]
}
```

Fields:

```
filter -> (string)
levels -> ([]struct)
resource-ids -> ([]string)
resource-types -> ([]string)
stream-names -> ([]string)
``` ||
|| `--sink-id` | `string`

New logging Sink ID logs exported to ||
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
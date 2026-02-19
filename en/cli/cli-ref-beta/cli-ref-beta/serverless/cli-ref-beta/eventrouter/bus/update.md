---
editable: false
noIndex: true
---

# yc beta serverless eventrouter bus update

Updates the specified bus.

#### Command Usage

Syntax:

`yc beta serverless eventrouter bus update <BUS-ID>`

#### Flags

#|
||Flag | Description ||
|| `--bus-id` | `string`

ID of the bus to update. ||
|| `--deletion-protection` | New flag that disallow deletion of the bus. ||
|| `--description` | `string`

New description of the bus. ||
|| `--labels` | `map<string><string>`

New labels of the bus. ||
|| `--log-options` | `shorthand/json`

New options for logging from the bus.

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
min-level -> (struct)
  Minimum log entry level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    Entry will be written to log group resolved by ID.
  folder-id -> (string)
    Entry will be written to default log group for specified folder.
``` ||
|| `--logging-enabled` | Is logging from the bus enabled. ||
|| `--name` | `string`

New name of the bus. ||
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
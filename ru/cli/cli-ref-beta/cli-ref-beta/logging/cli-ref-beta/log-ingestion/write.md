---
editable: false
noIndex: true
---

# yc beta logging log-ingestion write

Write log entries to specified destination.

#### Command Usage

Syntax:

`yc beta logging log-ingestion write`

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
|| `--defaults` | `shorthand/json`

Log entries defaults. See [LogEntryDefaults] for details.

Shorthand Syntax:

```hcl
{
  json-payload = {},
  level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL,
  stream-name = string
}
```

JSON Syntax:

```json
{
  "json-payload": {},
  "level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL",
  "stream-name": "string"
}
```

Fields:

```
json-payload -> (struct)
  Default entry annotation. Will be merged with entry annotation. Any conflict will be resolved in favor of entry own annotation.
level -> (struct)
  Default entry severity. Will be applied if entry level is unspecified. See [LogLevel.Level] for details.
stream-name -> (string)
  Entry stream name.
``` ||
|| `--destination` | `shorthand/json`

Log entries destination. See [Destination] for details.

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  }
}
```

Fields:

```
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    Entry should be written to log group resolved by ID.
  folder-id -> (string)
    Entry should be written to default log group for the folder.
``` ||
|| `--entries` | `shorthand/json`

List of log entries.

Shorthand Syntax:

```hcl
[
  {
    json-payload = {},
    level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL,
    message = string,
    stream-name = string,
    timestamp = timestamp
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "json-payload": {},
    "level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL",
    "message": "string",
    "stream-name": "string",
    "timestamp": "timestamp"
  }, ...
]
```

Fields:

```
json-payload -> (struct)
  Entry annotation.
level -> (struct)
  Entry severity. See [LogLevel.Level] for details.
message -> (string)
  Entry text message.
stream-name -> (string)
  Entry stream name.
timestamp -> (timestamp)
  Timestamp of the entry.
``` ||
|| `--resource` | `shorthand/json`

Common resource (type, ID) specification for log entries.

Shorthand Syntax:

```hcl
{
  id = string,
  type = string
}
```

JSON Syntax:

```json
{
  "id": "string",
  "type": "string"
}
```

Fields:

```
id -> (string)
  Resource ID, i.e., ID of the function producing logs.
type -> (string)
  Resource type, i.e., 'serverless.function'
``` ||
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
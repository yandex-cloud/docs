---
editable: false
noIndex: true
---

# yc beta logging log-reading read

Read log entries from the specified log group.

#### Command Usage

Syntax:

`yc beta logging log-reading read`

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
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ReadResponse.next_page_token] or [ReadResponse.previous_page_token] returned by a previous read request. ||
|| `--criteria` | `shorthand/json`

Read criteria. See [Criteria] for details.

Shorthand Syntax:

```hcl
{
  filter = string,
  levels = [
    TRACE|DEBUG|INFO|WARN|ERROR|FATAL, ...
  ],
  log-group-id = string,
  max-response-size = integer,
  page-size = integer,
  resource-ids = string,...,
  resource-types = string,...,
  since = timestamp,
  stream-names = string,...,
  until = timestamp
}
```

JSON Syntax:

```json
{
  "filter": "string",
  "levels": [
    "TRACE|DEBUG|INFO|WARN|ERROR|FATAL", ...
  ],
  "log-group-id": "string",
  "max-response-size": "integer",
  "page-size": "integer",
  "resource-ids": [
    "string", ...
  ],
  "resource-types": [
    "string", ...
  ],
  "since": "timestamp",
  "stream-names": [
    "string", ...
  ],
  "until": "timestamp"
}
```

Fields:

```
filter -> (string)
  Filter expression. For details about filtering, see documentation.
levels -> ([]struct)
  List of log levels to limit log entries to. Empty list disables filter.
log-group-id -> (string)
  ID of the log group to return. To get a log group ID make a [LogGroupService.List] request.
max-response-size -> (integer)
  Limits response to maximum size in bytes. Prevents gRPC resource exhaustion. Default value for max response size is 3.5 MiB
page-size -> (integer)
  The maximum number of results per page to return.
resource-ids -> ([]string)
  List of resource IDs to limit log entries to. Empty list disables filter.
resource-types -> ([]string)
  List of resource types to limit log entries to. Empty list disables filter.
since -> (timestamp)
  Lower bound of log entries timestamps.
stream-names -> ([]string)
  List of stream names to limit log entries to. Empty list disables filter.
until -> (timestamp)
  Upper bound of log entries timestamps.
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
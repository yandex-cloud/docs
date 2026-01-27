---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/rule/update.md
---

# yc beta serverless eventrouter rule update

Updates the specified rule.

#### Command Usage

Syntax:

`yc beta serverless eventrouter rule update <RULE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--deletion-protection` | New flag that disallow deletion of the rule. ||
|| `--description` | `string`

New description of the rule. ||
|| `--filter` | `shorthand/json`

New filter for the rule.

Shorthand Syntax:

```hcl
{
  condition = jq-filter=str
}
```

JSON Syntax:

```json
{
  "condition": {
    "jq-filter": "str"
  }
}
```

Fields:

```
condition -> (oneof<jq-filter>)
  Oneof condition field
  jq-filter -> (string)
    JQ filter for matching events.
``` ||
|| `--labels` | `stringToString`

New labels for the rule. ||
|| `--name` | `string`

New name of the rule. ||
|| `--rule-id` | `string`

ID of the rule to update. ||
|| `--targets` | `shorthand/json`

New targets for the rule.

Shorthand Syntax:

```hcl
[
  {
    dead-letter = dead-letter-queue={
      queue-arn = str,
      service-account-id = str
    },
    retry-settings = {
      maximum-age = duration,
      retry-attempts = int
    },
    status = ENABLED|DISABLED|RESOURCE_NOT_FOUND|PERMISSION_DENIED|SUBJECT_NOT_FOUND,
    target = container={
      batch-settings = {
        cutoff = duration,
        max-bytes = int,
        max-count = int
      },
      container-id = str,
      container-revision-id = str,
      path = str,
      service-account-id = str
    } | function={
      batch-settings = {
        cutoff = duration,
        max-bytes = int,
        max-count = int
      },
      function-id = str,
      function-tag = str,
      service-account-id = str
    } | gateway-ws-broadcast={
      batch-settings = {
        cutoff = duration,
        max-bytes = int,
        max-count = int
      },
      gateway-id = str,
      path = str,
      service-account-id = str
    } | logging={
      destination = folder-id=str | log-group-id=str,
      service-account-id = str
    } | workflow={
      batch-settings = {
        cutoff = duration,
        max-bytes = int,
        max-count = int
      },
      service-account-id = str,
      workflow-id = str
    } | yds={
      database = str,
      service-account-id = str,
      stream-name = str
    } | ymq={
      queue-arn = str,
      service-account-id = str
    },
    transformer = {
      transformer = jq-transformer=str
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "dead-letter": {
      "dead-letter-queue": {
        "queue-arn": "str",
        "service-account-id": "str"
      }
    },
    "retry-settings": {
      "maximum-age": "duration",
      "retry-attempts": "int"
    },
    "status": "ENABLED|DISABLED|RESOURCE_NOT_FOUND|PERMISSION_DENIED|SUBJECT_NOT_FOUND",
    "target": {
      "container": {
        "batch-settings": {
          "cutoff": "duration",
          "max-bytes": "int",
          "max-count": "int"
        },
        "container-id": "str",
        "container-revision-id": "str",
        "path": "str",
        "service-account-id": "str"
      },
      "function": {
        "batch-settings": {
          "cutoff": "duration",
          "max-bytes": "int",
          "max-count": "int"
        },
        "function-id": "str",
        "function-tag": "str",
        "service-account-id": "str"
      },
      "gateway-ws-broadcast": {
        "batch-settings": {
          "cutoff": "duration",
          "max-bytes": "int",
          "max-count": "int"
        },
        "gateway-id": "str",
        "path": "str",
        "service-account-id": "str"
      },
      "logging": {
        "destination": {
          "folder-id": "str",
          "log-group-id": "str"
        },
        "service-account-id": "str"
      },
      "workflow": {
        "batch-settings": {
          "cutoff": "duration",
          "max-bytes": "int",
          "max-count": "int"
        },
        "service-account-id": "str",
        "workflow-id": "str"
      },
      "yds": {
        "database": "str",
        "service-account-id": "str",
        "stream-name": "str"
      },
      "ymq": {
        "queue-arn": "str",
        "service-account-id": "str"
      }
    },
    "transformer": {
      "transformer": {
        "jq-transformer": "str"
      }
    }
  }, ...
]
```

Fields:

```
retry-settings -> (struct)
  Retry settings of the target.
  maximum-age -> (duration)
    Event goes to dlq when its age exceeds this value. Default is 24h.
  retry-attempts -> (int)
    Maximum number of retries (extra calls) before an action fails.
status -> (struct)
  Status of the target.
transformer -> (struct)
  Transformer of the target.
  transformer -> (oneof<jq-transformer>)
    Oneof transformer field
    jq-transformer -> (string)
      JQ string inrerpolation expression for changing event format.
dead-letter -> (oneof<dead-letter-queue>)
  Oneof dead-letter field
  dead-letter-queue -> (struct)
    Dead letter queue.
    queue-arn -> (string)
      ID of the queue.
    service-account-id -> (string)
      Service account which has write permission on the queue.
target -> (oneof<container|function|gateway-ws-broadcast|logging|workflow|yds|ymq>)
  Oneof target field
  yds -> (struct)
    database -> (string)
      Stream database.
    service-account-id -> (string)
      Service account, which has write permission on the stream.
    stream-name -> (string)
      Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test.
  ymq -> (struct)
    queue-arn -> (string)
      Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test
    service-account-id -> (string)
      Service account which has write access to the queue.
  function -> (struct)
    batch-settings -> (struct)
      Batch settings.
      cutoff -> (duration)
        Maximum batch size: trigger will send a batch if its lifetime exceeds this value.
      max-bytes -> (int)
        Maximum batch size: trigger will send a batch if total size of events exceeds this value.
      max-count -> (int)
        Maximum batch size: trigger will send a batch if number of events exceeds this value.
    function-id -> (string)
      Function ID.
    function-tag -> (string)
      Function tag, optional.
    service-account-id -> (string)
      Service account which has call permission on the function, optional.
  container -> (struct)
    batch-settings -> (struct)
      Batch settings.
      cutoff -> (duration)
        Maximum batch size: trigger will send a batch if its lifetime exceeds this value.
      max-bytes -> (int)
        Maximum batch size: trigger will send a batch if total size of events exceeds this value.
      max-count -> (int)
        Maximum batch size: trigger will send a batch if number of events exceeds this value.
    container-id -> (string)
      Container ID.
    container-revision-id -> (string)
      Container revision ID.
    path -> (string)
      Endpoint HTTP path to invoke.
    service-account-id -> (string)
      Service account which should be used to call a container, optional.
  gateway-ws-broadcast -> (struct)
    batch-settings -> (struct)
      Batch settings.
      cutoff -> (duration)
        Maximum batch size: trigger will send a batch if its lifetime exceeds this value.
      max-bytes -> (int)
        Maximum batch size: trigger will send a batch if total size of events exceeds this value.
      max-count -> (int)
        Maximum batch size: trigger will send a batch if number of events exceeds this value.
    gateway-id -> (string)
      Gateway ID.
    path -> (string)
      Path.
    service-account-id -> (string)
      Service account which has permission for writing to websockets.
  logging -> (struct)
    service-account-id -> (string)
      Service account which has permission for writing logs.
    destination -> (oneof<folder-id|log-group-id>)
      Oneof destination field
      log-group-id -> (string)
      folder-id -> (string)
  workflow -> (struct)
    batch-settings -> (struct)
      Batch settings.
      cutoff -> (duration)
        Maximum batch size: trigger will send a batch if its lifetime exceeds this value.
      max-bytes -> (int)
        Maximum batch size: trigger will send a batch if total size of events exceeds this value.
      max-count -> (int)
        Maximum batch size: trigger will send a batch if number of events exceeds this value.
    service-account-id -> (string)
      SA which should be used to start workflow.
    workflow-id -> (string)
      Workflow ID.
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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
---
editable: false
noIndex: true
---

# yc beta serverless eventrouter connector create

Creates a connector in the specified folder.

#### Command Usage

Syntax:

`yc beta serverless eventrouter connector create <BUS-ID>`

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
|| `--bus-id` | `string`

ID of the bus to create a connector in. ||
|| `--deletion-protection` | Flag that disallow deletion of the connector. ||
|| `--description` | `string`

Description of the connector. ||
|| `--labels` | `map<string><string>`

Labels for the connector. ||
|| `--name` | `string`

Name of the connector. ||
|| `--source` | `shorthand/json`

Source of the connector.

Shorthand Syntax:

```hcl
{
  source = audit-trails={} | data-stream={
    consumer = string,
    database = string,
    service-account-id = string,
    stream-name = string
  } | event-service-source={} | message-queue={
    batch-size = integer,
    polling-timeout = duration,
    queue-arn = string,
    service-account-id = string,
    visibility-timeout = duration
  } | timer={
    cron-expression = string,
    payload = string,
    time-zone = string
  }
}
```

JSON Syntax:

```json
{
  "source": {
    "audit-trails": {},
    "data-stream": {
      "consumer": "string",
      "database": "string",
      "service-account-id": "string",
      "stream-name": "string"
    },
    "event-service-source": {},
    "message-queue": {
      "batch-size": "integer",
      "polling-timeout": "duration",
      "queue-arn": "string",
      "service-account-id": "string",
      "visibility-timeout": "duration"
    },
    "timer": {
      "cron-expression": "string",
      "payload": "string",
      "time-zone": "string"
    }
  }
}
```

Fields:

```
source -> (oneof<audit-trails|data-stream|event-service-source|message-queue|timer>)
  Oneof source field
  data-stream -> (struct)
    consumer -> (string)
      Consumer name.
    database -> (string)
      Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********
    service-account-id -> (string)
      Service account which has read permission on the stream.
    stream-name -> (string)
      Stream name, absolute or relative.
  message-queue -> (struct)
    batch-size -> (integer)
      Batch size for polling.
    polling-timeout -> (duration)
      Queue polling timeout.
    queue-arn -> (string)
      Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test
    service-account-id -> (string)
      Service account which has read access to the queue.
    visibility-timeout -> (duration)
      Queue visibility timeout override.
  timer -> (struct)
    cron-expression -> (string)
      cron expression, with second precision
    payload -> (string)
      payload to send to target
    time-zone -> (string)
      time zone, e.g. Europe/Moscow
  event-service-source -> (struct)
  audit-trails -> (struct)
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
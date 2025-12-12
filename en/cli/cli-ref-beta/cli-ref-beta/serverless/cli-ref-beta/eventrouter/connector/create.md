---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/connector/create.md
---

# yc beta serverless eventrouter connector create

Creates a connector in the specified folder.

#### Command Usage

Syntax: 

`yc beta serverless eventrouter connector create <BUS-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bus-id`|<b>`string`</b><br/>ID of the bus to create a connector in.|
|`--deletion-protection`|Flag that disallow deletion of the connector.|
|`--description`|<b>`string`</b><br/>Description of the connector.|
|`--labels`|<b>`stringToString`</b><br/>Labels for the connector.|
|`--name`|<b>`string`</b><br/>Name of the connector.|
|`--source`|<b>`shorthand/json`</b><br/>Source of the connector.<br/>Shorthand Syntax:<br/>{<br/>source = audit-trails={} \| data-stream={<br/>consumer = str,<br/>database = str,<br/>service-account-id = str,<br/>stream-name = str<br/>} \| event-service-source={} \| message-queue={<br/>batch-size = int,<br/>polling-timeout = duration,<br/>queue-arn = str,<br/>service-account-id = str,<br/>visibility-timeout = duration<br/>} \| timer={<br/>cron-expression = str,<br/>payload = str,<br/>time-zone = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"source": {<br/>"audit-trails": {},<br/>"data-stream": {<br/>"consumer": "str",<br/>"database": "str",<br/>"service-account-id": "str",<br/>"stream-name": "str"<br/>},<br/>"event-service-source": {},<br/>"message-queue": {<br/>"batch-size": "int",<br/>"polling-timeout": "duration",<br/>"queue-arn": "str",<br/>"service-account-id": "str",<br/>"visibility-timeout": "duration"<br/>},<br/>"timer": {<br/>"cron-expression": "str",<br/>"payload": "str",<br/>"time-zone": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>source -> (oneof<audit-trails\|data-stream\|event-service-source\|message-queue\|timer>)<br/>Oneof source field<br/>data-stream -> (struct)<br/>consumer -> (string)<br/>Consumer name.<br/>database -> (string)<br/>Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********<br/>service-account-id -> (string)<br/>Service account which has read permission on the stream.<br/>stream-name -> (string)<br/>Stream name, absolute or relative.<br/>message-queue -> (struct)<br/>batch-size -> (int)<br/>Batch size for polling.<br/>polling-timeout -> (duration)<br/>Queue polling timeout.<br/>queue-arn -> (string)<br/>Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test<br/>service-account-id -> (string)<br/>Service account which has read access to the queue.<br/>visibility-timeout -> (duration)<br/>Queue visibility timeout override.<br/>timer -> (struct)<br/>cron-expression -> (string)<br/>cron expression, with second precision<br/>payload -> (string)<br/>payload to send to target<br/>time-zone -> (string)<br/>time zone, e.g. Europe/Moscow<br/>event-service-source -> (struct)<br/>audit-trails -> (struct)|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|

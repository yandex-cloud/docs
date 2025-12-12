---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/log-ingestion/write.md
---

# yc beta logging log-ingestion write

Write log entries to specified destination.

#### Command Usage

Syntax: 

`yc beta logging log-ingestion write`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--defaults`|<b>`shorthand/json`</b><br/>Log entries defaults. See [LogEntryDefaults] for details.<br/>Shorthand Syntax:<br/>{<br/>json-payload = {},<br/>level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL,<br/>stream-name = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"json-payload": {},<br/>"level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL",<br/>"stream-name": "str"<br/>}"<br/>Fields:<br/>json-payload -> (struct)<br/>Default entry annotation. Will be merged with entry annotation. Any conflict will be resolved in favor of entry own annotation.<br/>level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Default entry severity. Will be applied if entry level is unspecified. See [LogLevel.Level] for details.<br/>stream-name -> (string)<br/>Entry stream name.|
|`--destination`|<b>`shorthand/json`</b><br/>Log entries destination. See [Destination] for details.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>}<br/>}"<br/>Fields:<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>Entry should be written to log group resolved by ID.<br/>folder-id -> (string)<br/>Entry should be written to default log group for the folder.|
|`--entries`|<b>`shorthand/json`</b><br/>List of log entries.<br/>Shorthand Syntax:<br/>[<br/>{<br/>json-payload = {},<br/>level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL,<br/>message = str,<br/>stream-name = str,<br/>timestamp = timestamp<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"json-payload": {},<br/>"level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL",<br/>"message": "str",<br/>"stream-name": "str",<br/>"timestamp": "timestamp"<br/>}, ...<br/>]"<br/>Fields:<br/>json-payload -> (struct)<br/>Entry annotation.<br/>level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Entry severity. See [LogLevel.Level] for details.<br/>message -> (string)<br/>Entry text message.<br/>stream-name -> (string)<br/>Entry stream name.<br/>timestamp -> (timestamp)<br/>Timestamp of the entry.|
|`--resource`|<b>`shorthand/json`</b><br/>Common resource (type, ID) specification for log entries.<br/>Shorthand Syntax:<br/>{<br/>id = str,<br/>type = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"id": "str",<br/>"type": "str"<br/>}"<br/>Fields:<br/>id -> (string)<br/>Resource ID, i.e., ID of the function producing logs.<br/>type -> (string)<br/>Resource type, i.e., 'serverless.function'|

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

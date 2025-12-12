---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/workflow/update.md
---

# yc beta serverless workflow update

Updates specified Workflow.

#### Command Usage

Syntax: 

`yc beta serverless workflow update <WORKFLOW-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the Workflow.|
|`--express`|Express execution mode.|
|`--labels`|<b>`stringToString`</b><br/>Workflow labels as 'key:value' pairs.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the Workflow.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>disabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"disabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>disabled -> (bool)<br/>Is logging from Workflow disabled.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum logs level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>ID of the logging group which should be used for Workflows logs.<br/>folder-id -> (string)<br/>ID of the folder which default logging group should be used for Workflows.|
|`--name`|<b>`string`</b><br/>Name of the Workflow. The name is unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the VPC network Workflow will be executed in, in order to access private resources.|
|`--schedule`|<b>`shorthand/json`</b><br/>Workflow schedule settings.<br/>Shorthand Syntax:<br/>{<br/>cron-expression = str,<br/>timezone = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"cron-expression": "str",<br/>"timezone": "str"<br/>}"<br/>Fields:<br/>cron-expression -> (string)<br/>Cron expression for the Workflow schedule.<br/>timezone -> (string)<br/>Timezone for the Workflow schedule.|
|`--service-account-id`|<b>`string`</b><br/>ID of the Service Account which will be used for resources access in Workflow execution.|
|`--specification`|<b>`shorthand/json`</b><br/>Specification of the Workflow.<br/>Shorthand Syntax:<br/>{<br/>spec = spec-yaml=str<br/>}<br/>JSON Syntax:<br/>"{<br/>"spec": {<br/>"spec-yaml": "str"<br/>}<br/>}"<br/>Fields:<br/>spec -> (oneof\<spec-yaml\>)<br/>Oneof spec field<br/>spec-yaml -> (string)<br/>Workflow specification in YAML format.|
|`--workflow-id`|<b>`string`</b><br/>ID of the Workflow.|
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

---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/workflow/create.md
---

# yc beta serverless workflow create

Creates Workflow in specified folder.

#### Command Usage

Syntax: 

`yc beta serverless workflow create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of Workflow.|
|`--express`|Express execution mode.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create Workflow in.|
|`--labels`|<b>`stringToString`</b><br/>Workflow labels as 'key:value' pairs.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from Workflow.<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>disabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, disabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>disabled     bool                                     — Is logging from Workflow disabled.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum logs level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — ID of the logging group which should be used for Workflows logs.<br/>folder-id     string  — ID of the folder which default logging group should be used for Workflows.<br/>|
|`--name`|<b>`string`</b><br/>Name of Workflow.<br/>The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the VPC network Workflow will be executed in, in order to access private resources.|
|`--schedule`|<b>`shorthand/json`</b><br/>Workflow schedule settings.<br/><br/>Example:|
|`--schedule`|<b>`cron-expression=value,`</b><br/>timezone=value<br/><br/>Shorthand Syntax:<br/>{cron-expression=str, timezone=str}<br/>Fields:<br/>cron-expression  string  required  — Cron expression for the Workflow schedule.<br/>timezone         string  required  — Timezone for the Workflow schedule.<br/>|
|`--service-account-id`|<b>`string`</b><br/>ID of the Service Account which will be used for resources access in Workflow execution.|
|`--specification`|<b>`shorthand/json`</b><br/>Specification of Workflow<br/><br/>Example:<br/>--specification spec={spec-yaml=value}<br/><br/>Shorthand Syntax:<br/>{spec={spec-yaml=str}}<br/>Fields:<br/>spec  oneof\<spec-yaml\>  — Oneof spec field<br/>spec-yaml  string  — Workflow specification in YAML format.<br/>|
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

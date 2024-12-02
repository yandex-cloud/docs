---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/serverless/workflow/index.md
---

# yc serverless workflow

Manage workflows

#### Command Usage

Syntax: 

`yc serverless workflow <group|command>`

Aliases: 

- `wf`

#### Command Tree

- [yc serverless workflow get](get.md) — Get Workflow
- [yc serverless workflow list](list.md) — List Workflows
- [yc serverless workflow create](create.md) — Create Workflow
- [yc serverless workflow update](update.md) — Update Workflow
- [yc serverless workflow delete](delete.md) — Delete Workflow
- [yc serverless workflow list-operations](list-operations.md) — List Workflow operations
- [yc serverless workflow execution](execution/index.md) — Manage execution
	- [yc serverless workflow execution get](execution/get.md) — Get Execution
	- [yc serverless workflow execution get-history](execution/get-history.md) — Get Execution history
	- [yc serverless workflow execution list](execution/list.md) — List Execution
	- [yc serverless workflow execution start](execution/start.md) — Start Execution
	- [yc serverless workflow execution stop](execution/stop.md) — Stop Execution
	- [yc serverless workflow execution terminate](execution/terminate.md) — Terminate Execution

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|

---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/workflow/index.md
---

# yc beta serverless workflow

Set of methods for managing Workflows.

#### Command Usage

Syntax: 

`yc beta serverless workflow <command>`

#### Command Tree

- [yc beta serverless workflow create](create.md) — Creates Workflow in specified folder.
- [yc beta serverless workflow delete](delete.md) — Deletes specified Workflow.
- [yc beta serverless workflow get](get.md) — Retrieves specified Workflow.
- [yc beta serverless workflow list](list.md) — Retrieves list of Workflows in specified folder.
- [yc beta serverless workflow list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified Workflow.
- [yc beta serverless workflow list-operations](list-operations.md) — Lists operations for specified Workflow.
- [yc beta serverless workflow set-access-bindings](set-access-bindings.md) — Sets access bindings for the Workflow.
- [yc beta serverless workflow update](update.md) — Updates specified Workflow.
- [yc beta serverless workflow update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Workflow.

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

---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/mcp-gateway/index.md
---

# yc beta serverless mcp-gateway

A set of methods for managing MCP Gateway resources.

#### Command Usage

Syntax: 

`yc beta serverless mcp-gateway <command>`

#### Command Tree

- [yc beta serverless mcp-gateway create](create.md) — Creates an MCP Gateway in the specified folder.
- [yc beta serverless mcp-gateway delete](delete.md) — Deletes the specified MCP Gateway.
- [yc beta serverless mcp-gateway get](get.md) — Retrieves the specified MCP Gateway.
- [yc beta serverless mcp-gateway list](list.md) — Retrieves the list of MCP Gateways in the specified folder.
- [yc beta serverless mcp-gateway list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified MCP Gateway.
- [yc beta serverless mcp-gateway list-operations](list-operations.md) — Lists operations for the specified MCP Gateway.
- [yc beta serverless mcp-gateway set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified MCP Gateway.
- [yc beta serverless mcp-gateway update](update.md) — Updates the specified MCP Gateway.
- [yc beta serverless mcp-gateway update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified MCP Gateway.

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

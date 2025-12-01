---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/mcp-gateway/index.md
---

# yc serverless mcp-gateway

Manage MCP Gateways

#### Command Usage

Syntax: 

`yc serverless mcp-gateway <command>`

Aliases: 

- `mcpgw`

#### Command Tree

- [yc serverless mcp-gateway add-access-binding](add-access-binding.md) — Add access binding for the specified MCP Gateway
- [yc serverless mcp-gateway allow-unauthenticated-invoke](allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified MCP Gateway
- [yc serverless mcp-gateway create](create.md) — Create MCP Gateway
- [yc serverless mcp-gateway delete](delete.md) — Delete MCP Gateway
- [yc serverless mcp-gateway deny-unauthenticated-invoke](deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified MCP Gateway
- [yc serverless mcp-gateway get](get.md) — Get MCP Gateway
- [yc serverless mcp-gateway list](list.md) — List MCP Gateways
- [yc serverless mcp-gateway list-access-bindings](list-access-bindings.md) — List access bindings for the specified MCP Gateway
- [yc serverless mcp-gateway list-operations](list-operations.md) — List MCP Gateway operations
- [yc serverless mcp-gateway remove-access-binding](remove-access-binding.md) — Remove access binding for the specified MCP Gateway
- [yc serverless mcp-gateway set-access-bindings](set-access-bindings.md) — Set access bindings for the specified MCP Gateway and delete all existing access bindings if there were any
- [yc serverless mcp-gateway update](update.md) — Update MCP Gateway

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

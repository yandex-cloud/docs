---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/v0/mcp-gateway/
---

# yc serverless v0 mcp-gateway

Manage MCP Gateways

#### Command Usage

Syntax:

`yc serverless v0 mcp-gateway <command>`

Aliases:

- `mcpgw`

#### Command Tree

- [yc serverless v0 mcp-gateway add-access-binding](add-access-binding.md) — Add access binding for the specified MCP Gateway

- [yc serverless v0 mcp-gateway allow-unauthenticated-invoke](allow-unauthenticated-invoke.md) — Allow unauthenticated invoke for the specified MCP Gateway

- [yc serverless v0 mcp-gateway create](create.md) — Create MCP Gateway

- [yc serverless v0 mcp-gateway delete](delete.md) — Delete MCP Gateway

- [yc serverless v0 mcp-gateway deny-unauthenticated-invoke](deny-unauthenticated-invoke.md) — Deny unauthenticated invoke for the specified MCP Gateway

- [yc serverless v0 mcp-gateway get](get.md) — Get MCP Gateway

- [yc serverless v0 mcp-gateway list](list.md) — List MCP Gateways

- [yc serverless v0 mcp-gateway list-access-bindings](list-access-bindings.md) — List access bindings for the specified MCP Gateway

- [yc serverless v0 mcp-gateway list-operations](list-operations.md) — List MCP Gateway operations

- [yc serverless v0 mcp-gateway remove-access-binding](remove-access-binding.md) — Remove access binding for the specified MCP Gateway

- [yc serverless v0 mcp-gateway set-access-bindings](set-access-bindings.md) — Set access bindings for the specified MCP Gateway and delete all existing access bindings if there were any

- [yc serverless v0 mcp-gateway update](update.md) — Update MCP Gateway

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
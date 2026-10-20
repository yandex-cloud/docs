{#ai-mcp1-id}

Requirement ID: `AI-MCP1`

{#ai-mcp1-requirement}

**Requirement**

The owner must separately define the caller identity, Gateway invocation and configuration editing permissions, permission to manage bindings, the Gateway service account, and the target service’s permission to access the resource. Role semantics is defined in the [{{ ai-studio-name }} access model]({{ link-docs-ai }}ai-studio/security/index.html): `serverless.mcpGateways.invoker` is used to make calls, `serverless.mcpGateways.editor`, to update the Gateway, and `serverless.mcpGateways.admin`, to manage bindings. The CLI reference serves as a source of command syntax rather than the sole authoritative source of role descriptions.

{#ai-mcp1-implementation}

**Implementation**

For each tool, the following must be recorded: the channel and backend URL, authentication method, allowed headers, input JSON schema version, and rule for handling unknown fields. Parameter size limits and action approval are application or orchestrator settings, not documented MCP Gateway configuration fields. The `mcp_approval_request` and `mcp_approval_response` Responses elements serve as evidence only for the documented path.

The `serverless.mcpGateways.anonymousInvoker` role is used for documented scenarios involving access to external MCP servers or template servers; the role name does not imply public or unauthenticated access.

Gateway visibility is configured separately: a public MCP server allows unauthenticated agent access, whereas an agent accessing a private MCP server requires a service account IAM token or an API key with the `yc.serverless.mcpGateways.invoke` scope. These branches are described in the [MCP Hub overview]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index.html) and [API key guide]({{ link-docs-ai }}ai-studio/operations/get-api-key.html).

Gateway visibility, client access, the Gateway service account, and target service reachability are verified independently. Gateway access permission does not prove that the target service authorized the operation.

Access to the MCP Hub API requires an IAM token according to the [{{ ai-studio-name }} authentication guide]({{ link-docs-ai }}ai-studio/api-ref/authentication.html).

Learn about HTTP tool parameters and how to link a service account in the [MCP Gateway creation guide]({{ link-docs-ai }}ai-studio/operations/mcp-servers/create-brand-new-api.html). Terraform does not provide an official resource for the gateway; a private {{ vpc-short-name }} endpoint does not disable access through the public address.

The `--tools-file` operation replaces the entire tool list. Without explicit documentation, a native {{ lockbox-short-name }} link for arbitrary user-defined target system credentials is not supported.

{#ai-mcp1-check}

**Check**

```bash
yc serverless mcp-gateway list
yc serverless mcp-gateway get <gateway-id>
yc serverless mcp-gateway list-access-bindings <gateway-id>
yc serverless mcp-gateway list-operations <gateway-id>
```

1. Check the configuration, network, service account, bindings, schema, and authentication parameters.
1. Then make an allowed call, a call without the required role, an oversized request or a request with an unknown field, and a direct call to the target service that bypasses the Gateway.

The bypass must not provide more access. For application tracing, use documented {{ ai-studio-name }} events, including MCP calls, but do not treat them as proof of complete authorization by the target service. For details, see the [{{ ai-studio-name }} event reference]({{ link-docs-ai }}ai-studio/at-ref.html).

{#ai-mcp1-artifacts}

**Artifact**

* Gateway configuration.
* Allowed and denied call.
* Backend bypass.
* GET result and gateway bindings.
* Complete tool specification.
* Public access status.
* API key scope.

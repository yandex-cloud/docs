{#profile-mcp-agent-applicability}

**Scope and status**

The profile is applied only if the agent calls MCP Gateway or is managed via MCP Hub. Gateway publicity, access to external or templateMCP server, and action confirmation are independent properties.

{#profile-mcp-agent-flow}

**Flow and trust boundaries**

`user → application → agent → MCP Gateway → tool HTTP backend → target resource`. Gateway input, Gateway service account, backend authorization, and permissions for the target resources are checked separately.

{#profile-mcp-agent-authentication}

**Workload identity and authentication**

The calling and managing identities, the Gateway service account and backend credentials, are separate. For MCP Hub management, an IAM token is used. The calling environment gets the IAM token of its service account; the API key with the `yc.serverless.mcpGateways.invoke` scope is used only in the documented call scenario and delivered through that environment's profile.

{#profile-mcp-agent-roles}

**Roles and scope**

`serverless.mcpGateways.invoker` allows the call, `serverless.mcpGateways.editor` allows the Gateway update, `serverless.mcpGateways.admin` is for binding management.

The additional `serverless.mcpGateways.anonymousInvoker` role is assigned for documented external MCP servers and template-based servers. This assignment does not replace and prove configured Gateway publicity.

The subject creating the Gateway gets the `serverless.mcpGateways.editor` and `iam.serviceAccounts.user` roles for the folder as per the [creation guide]({{ link-docs-ai }}ai-studio/operations/mcp-servers/create-brand-new-api.html). The second one allows service account binding and is not a working Gateway role.

The semantics of other roles are taken from the [{{ ai-studio-name }} access model]({{ link-docs-ai }}ai-studio/security/) and the [MCP Hub overview]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index.html), not derived from names.

{#profile-mcp-agent-network}

**Network**

`public`, IAM bindings, {{ vpc-short-name }} cloud networks (when used), and backend reachability are recorded. `public=true` stands for unauthenticated access for agents. The `serverless.mcpGateways.anonymousInvoker` role relates to a documented branch of external and template servers and is not an equivalent of the flag above. None of the branches is an evidence of target service authorization.

{#profile-mcp-agent-secrets}

**Secrets and credentials**

With `useServiceAccount`, Gateway uses the linked service account, so the long-lived backend secret is marked as `N/A`. The account’s permissions for the target resource are checked separately.

If the backend requires a bearer token or credentials in a user header, a supported mechanism for storage, transfer to Gateway, and rotation must be named prior to admission. The current link for creating Gateway does not confirm the native link to {{ lockbox-short-name }}, so putting the value into the configuration without proper justification is not a permissible path.

Headers allowed for forwarding are provided as an explicit list. Secret values are not included into the tool schema or evidence.

{#profile-mcp-agent-configuration}

**Configuration objects**

Gateway, folder and service account IDs, `public`, cloud network, log group and logging level, list of tools, URL and method, `inputJsonSchema` version, body, headers, request parameters, authorization and header forwarding mode. Supported fields are checked against the [Gateway creation guide]({{ link-docs-ai }}ai-studio/operations/mcp-servers/create-brand-new-api.html).

Parameter size limits and action approval by a human are implemented by the application or agent orchestrator using `AI-AGENT-HITL1` and are not documented MCP Gateway configuration fields.

{#profile-mcp-agent-telemetry}

**Telemetry and blind spots**

{{ cloud-logging-name }} is enabled by the Gateway configuration. [{{ ai-studio-name }} events]({{ link-docs-ai }}ai-studio/at-ref.html), including `mcp_hub.InvokeMcpTool`, do not prove full backend authorization, effect at the target resource, or response content. These parts are associated by the application-level trace and the target service log.

{#profile-mcp-agent-checks}

**Positive and negative checks**

The syntax of diagnostic commands is taken from the [MCP Gateway CLI reference](../../../../cli/cli-ref/serverless/cli-ref/mcp-gateway/index.md).

1. Run `list`, `get`, `list-access-bindings`, `list-operations`.
1. Check the private Gateway call with an IAM token or API key and failure without `invoker`.
1. Check access to the selected external or template server with required additional role and failure without it.
1. For `public=true`, check an unauthenticated call and its rejection after disabling publicity.
1. Additionally, check a managing operation from the production environment, exceeded size or schema limit, direct bypass of backend, action requiring confirmation, and cycle stop.

{#profile-mcp-agent-inputs}

**What you need for profile implementation**

* Architecture: tools, backends, target resources, and delegation scheme.
* Policy: public/anonymous, approval, headers, sizes, and cycle limits.
* Legal approach: external backends and transmitted data categories.

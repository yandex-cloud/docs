### Use public MCP servers only when strictly required {#public-mcp}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.public-mcp ||
|#

#### Description

**How the rule works**: The system checks whether the created MCP server is public.

By default, any MCP gateway must be private. Public access expands the attack surface and creates a risk of unauthorized execution of Tools and agent logic. Binding the [`allUsers`](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group#allUsers) public group with the `serverless.mcpGateways.anonymousInvoker` role poses a particularly high security risk, since it allows anonymous calls to MCP Gateway.

Granting access to the [`allAuthenticatedUsers`](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group#allAuthenticatedUsers) group with a role that allows invoking a resource or service is also considered public access, even though it requires authentication in Yandex Cloud.

This rule maps to [OWASP MCP07:2025 Insufficient Authentication &amp; Authorization](https://owasp.org/www-project-mcp-top-10/2025/MCP07-2025–Insufficient-Authentication&amp;Authorization).

#### Instructions and solutions

1. Get the list of MCP gateways:

   ```bash
   yc serverless mcp-gateway list --format json 
   ``` 
1. For each gateway, check access to a public group: 

   ```bash
   yc serverless mcp-gateway list-access-bindings --name <name> --format json 
   ```

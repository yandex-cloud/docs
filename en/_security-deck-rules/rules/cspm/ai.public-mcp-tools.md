### Non-public functions, workflows, and tools that require authorization must not be connected to public MCP servers. {#public-mcp-tools}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.public-mcp-tools ||
|#

#### Description

**How the rule works:** The system verifies that functions, workflows, and tools linked to the MCP server are public.

This scenario can lead to a confused deputy vulnerability and potential proxy abuse, where an external subject leverages a public MCP gateway as an intermediary to invoke an internal tool.

The risk arises even if the tool itself is not directly public: it is sufficient for the public gateway to have a service account with permissions that allow accessing the internal tool.

This rule relates to [OWASP MCP07:2025 Insufficient Authentication &amp; Authorization](https://owasp.org/www-project-mcp-top-10/2025/MCP07-2025–Insufficient-Authentication&amp;Authorization) and excessive privilege risks.

#### Instructions and solutions

1. Identify public MCP gateways by running a check based on the [_Use public MCP servers only when strictly required_ rule](#public-mcp). 
1. Get the list of tools of the public gateway: 

   ```bash
   yc serverless mcp-gateway get --name <gateway-name> --format json
   ```

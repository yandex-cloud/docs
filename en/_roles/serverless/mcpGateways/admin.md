The `serverless.mcpGateways.admin` role enables managing MCP servers and access to them.

Users with this role can:


* View info on [MCP servers]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), as well as create, update, and delete them.
* View info on [access permissions](../../../iam/concepts/access-control/roles.md) assigned for MCP servers and modify such permissions.
* View info on usage [quotas]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) for MCP servers.
* Access MCP servers, including external ones, via {{ mcp-hub-name }}.


This role includes the `serverless.mcpGateways.editor`, `serverless.mcpGateways.invoker`, and `serverless.mcpGateways.anonymousInvoker` permissions.
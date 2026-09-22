### Different service accounts must be used for different tools, agents, and MCP servers {#mcp-sa-duplicate}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | ai.mcp-sa-duplicate ||
|#

#### Description

**How the rule works:** The system evaluates service accounts assigned to the MCP server, Cloud Functions, and Workflows. If a single service account is assigned to more than one object, the rule is considered violated.

A service account must be mapped to a single security boundary. You do not have to always adhere to the _one service account per resource_ principle: it is acceptable to use a single account within an approved logical agent if MCP Gateway, Cloud Functions, and Workflow share the same security boundary, owner, data classification, and minimum access requirements. However, sharing a service account across independent agents, MCP Gateway, DataSphere projects, or Tools creates an excessive potential impact. Development, staging, and production environments must use different service accounts.

#### Instructions and solutions

1. Get an inventory of all component types: MCP Gateway, Functions, Containers, Workflows, DataSphere projects and communities, XXX, AI Assistants and agent wrappers. 
1. For each resource, save its `type, id, name, folderId, owner, dataClass, environment, serviceAccountId`. 
1. Get service accounts for serverless resources: 

   ```bash
   yc serverless mcp-gateway get --name <name> --format json 
   ``` 
1. Use different service accounts for different tools, agents, and MCP servers. You may want to grant granular roles to a service account when working with MCP servers, such as [`serverless.mcpGateways.viewer`](https://aistudio.yandex.ru/en/docs/ai-studio/security/#mcp-roles).

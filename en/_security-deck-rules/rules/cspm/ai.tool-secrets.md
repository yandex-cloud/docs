### Secrets used by MCP Gateway и Tools should be stored in Yandex Lockbox {#tool-secrets}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.tool-secrets ||
|#

#### Description

**How the rule works:** If there are AI Studio resources in the environment, the system verifies that tokens for connecting to Tools are stored in [Yandex Lockbox](https://yandex.cloud/en/services/lockbox).

The secrets stored in MCP Gateway and Tools must be stored in [Yandex Lockbox](https://yandex.cloud/en/services/lockbox).

Only the service account that actively runs Tools must have access to the secret payload, and it must be restricted to that specific secret.

For [Cloud Functions](https://yandex.cloud/en/docs/functions/concepts/) and [Serverless Containers](https://yandex.cloud/en/docs/serverless-containers/), you should use native secret injection into the runtime configuration, ensuring that the function version or container revision stores a reference to the secret rather than the raw value.

For Workflows, secrets must not be provided through input parameters; the workflow must retrieve the secret payload either via runtime access to Lockbox or through a supported secure integration.

For external HTTP Tools, the secret header must not be stored in plain text within the MCP Gateway configuration.

This rule maps to [OWASP MCP01:2025 Token Mismanagement and Secret Exposure](https://owasp.org/www-project-mcp-top-10/2025/MCP01-2025-Token-Mismanagement-and-Secret-Exposure).

#### Instructions and solutions

1. Get the list of MCP gateways and the associated tools:

   ```bash

   yc serverless mcp-gateway list --format json; 
   ```

2. For each gateway run:

   ```bash

   yc serverless mcp-gateway get --name <gateway-name> --format json 
   ```

### Do not use highly privileged service accounts for MCP servers, functions, and workflows {#mcp-sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | ai.mcp-sa-privileges ||
|#

#### Description

**How the rule works:** The system checks whether service accounts assigned to MCP servers, functions, and workflows implementing Tools (or individual steps within such workflows) have permissions higher than `editor`.

By compromising the service account under which an agent workload is running, an attacker can gain access beyond a single tool or gateway.

Roles that allow managing [Yandex Identity and Access Management](https://yandex.cloud/en/docs/iam/security/#service-roles), [service accounts](https://yandex.cloud/en/docs/iam/security/#iam-serviceAccounts-admin), [Lockbox secrets](https://yandex.cloud/en/docs/lockbox/concepts/secret), [KMS keys](https://yandex.cloud/en/docs/kms/concepts/), [Serverless containers](https://yandex.cloud/en/docs/serverless-containers/concepts/container) and object storages, as well as the [`organization-manager`](https://yandex.cloud/en/docs/organization/security/#organization-manager-organizations-owner) role, pose a particularly high security risk.

The `admin` and `editor` primitive roles are prohibited without exception for the service account under which an agent workload is running. The `viewer` and `auditor` read roles are not always administrative; however, they can lead to data leaks and require separate justification.

#### Instructions and solutions

1. Get an inventory of MCP Gateway, Functions, Containers, and Workflows. 
1. For each resource, determine its `serviceAccountId`: 

   ```bash
   yc serverless function get --name <name> --format json 
   ```
1. Revoke access permissions through [CIEM](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions).

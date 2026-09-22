### Do not grant privileged roles in AI services to system groups or groups with a large number of subjects {#system-groups}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.system-groups ||
|#

#### Description

**How the rule works:** The system checks whether there are [system groups](https://yandex.cloud/en/docs/iam/concepts/access-control/system-group) within the organization.

You should grant privileged AI and MCP roles to narrow groups only if they are genuinely required to perform a specific task. Roles for managing models, [datasets](https://aistudio.yandex.ru/docs/en/ai-studio/security/#datasets-roles), AI Assistant, and MCP Gateway, as well as `ai.admin`and `ai.editor` and model response moderation [roles](https://aistudio.yandex.ru/docs/en/ai-studio/security/#guardrails-roles) pose a particularly high security risk.

Such roles must never be assigned to public and system groups. For the `viewer` and `auditor` read roles, as well as `*user` roles, the risk is lower; however, broad assignment still requires review.

#### Instructions and solutions

1. Get the organization’s access bindings:

   ```bash 
   yc organization-manager organization list-access-bindings --id <org-id> --format json 
   ``` 
1. Also check bindings at the folder and cloud levels if you assign AI and MCP roles below the organization level. 
1. The critical- and high-risk roles for broad groups are: `ai.admin, ai.editor, ai.models.admin, ai.models.editor, ai.datasets.admin, ai.datasets.editor, ai.guardrails.admin, ai.guardrails.editor, ai.assistants.admin, ai.assistants.editor, serverless.mcpGateways.admin, serverless.mcpGateways.editor`. 
1. The medium-risk and potentially high-risk roles for broad groups are: `ai.viewer, ai.auditor, ai.models.user, ai.models.viewer, ai.datasets.user, ai.datasets.viewer, ai.guardrails.user, ai.guardrails.viewer, ai.assistants.user, ai.assistants.viewer, ai.languageModels.user, ai.imageGeneration.user, ai.translate.user, ai.vision.user, ai.speechkit-stt.user, ai.speechkit-tts.user, ai.playground.user, serverless.mcpGateways.invoker`. 
1. Before deploying to a specific tenant, cross-reference the role names with the current [role reference](https://yandex.cloud/en/docs/iam/roles-reference). If the role is missing from the tenant, the scanner must not abort the task; instead, it must issue the `role not found / not applicable` message. 
1. Retrieve group membership: 

   ```bash
   yc organization-manager group list-members --group-id <id> --format json 
   ``` 
1. Public and system groups (`allUsers, allAuthenticatedUsers`) are always a violation for privileged roles. 
1. Broad group threshold: 
   * By default: Over 50 human subjects. 
   * For high-risk roles (`ai.admin, ai.editor, ai.models.admin, ai.models.editor, serverless.mcpGateways.admin, serverless.mcpGateways.editor`): Over 10 human subjects.

The solution is to create a restricted group with an owner, an approval process for granting permissions, and regular access reviews, transfer the role to this group, and remove the permission assignment from the broad or public group.

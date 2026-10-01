### API keys for AI Studio services must have restricted scopes {#api-key-scopes}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.api-key-scopes ||
|#

#### Description

**How the rule works:** The system evaluates AI Studio API keys with defined scopes and outputs a list of keys with overly broad permissions.

The API key scope must comply with the least privilege principle. If you do not specify a scope when creating an API key via the CLI, API, or Terraform, a broad set of [default](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key#scoped-api-keys) scopes is applied. Such a key often gets access not only to AI service operations, but also to Monitoring, Search API, Serverless Functions and Containers Invoke.

You cannot change the API key scope after you create it; you can, however, re-issue the key with the minimum required scopes and delete the legacy key once the client migration is complete.

#### Instructions and solutions

1. Get the service account API keys:

   ```bash
   yc iam api-key list --service-account-id <sa-id> --format json 
   ```

1. For each key, get the details:

   ```bash
   yc iam api-key get --id <key-id> --format json 
   ```

   Here is a list of scopes for an API key created via the CLI, API, or Terraform without specifying scopes: `yc.ai.imageGeneration.execute, yc.ai.languageModels.execute, yc.ai.speechkitStt.execute, yc.ai.speechkitTts.execute, yc.ai.translate.execute, yc.ai.vision.execute, yc.monitoring.manage, yc.search-api.execute, yc.serverless.containers.invoke, yc.serverless.functions.invoke`.

   If the key's retrieved scope matches the default list or is broader than the minimum required application profile, it constitutes a violation.

   The minimum recommended profiles are: 
   * Text generation only: yc.ai.languageModels.execute 
   * Image generation only: yc.ai.imageGeneration.execute 
   * Speech-to-text only: yc.ai.speechkitStt.execute 
   * Text-to-speech only: yc.ai.speechkitTts.execute * Translate only: yc.ai.translate.execute 
   * Vision/OCR only: yc.ai.vision.execute 
   * MCP invoke only: yc.serverless.mcpGateways.invoke 
   * Workflow execution only: yc.serverless.workflows.execute

   The additional available scopes that must not be used unless explicitly required are `yc.monitoring.manage, yc.monitoring.read, yc.search-api.execute, yc.serverless.functions.invoke, yc.serverless.containers.invoke, yc.serverless.workflows.execute, yc.serverless.mcpGateways.invoke, yc.logging.write, yc.datasphere.community-projects.manageResource, yc.speech-sense.use`, and and other scopes from the [current API key reference](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key#scoped-api-keys).

1. If you created a key via the AI Studio interface, do not rely on the creation source. Always verify the key's actual scopes. 4. Re-issue the key with the minimum required scopes:

   ```bash
   yc iam api-key create --service-account-id <sa-id> --scopes <scope1>,<scope2> --expires-at <iso8601> 
   ``` 
1. Update consumers, and then delete the legacy key:

   ```bash
   yc iam api-key delete --id <old-key-id> 
   ```

In Terraform, use the current attribute: `scopes = [...]`. Do not use `lifecycle.ignore_changes` for scopes if your goal is to detect and remediate drift.

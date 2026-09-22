### API keys for AI Studio services must have a defined lifetime {#api-key-rotation}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.api-key-rotation ||
|#

#### Description

**How this rule works**: The system evaluates whether API keys created to work with AI Studio have a determined lifetime.

Yandex Cloud allows you to define the API key [lifetime](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key#scoped-api-keys); the maximum lifetime, however, must be defined by the organization policy.

The recommended default lifetime is 90 days for cloud systems and 30 days for high-risk AI systems and agents. Both AWS API-compatible [static access keys](https://yandex.cloud/en/docs/iam/concepts/authorization/access-key) and [authorized keys](https://yandex.cloud/en/docs/iam/concepts/authorization/key) may not have any server-defined lifetime; this is why they require manual or automated rotation using the `createdAt` property, as well as deleting unused keys.

#### Instructions and solutions

1. Get all key types for each service account used in AI, MCP, and DataSphere:

   ```bash
   yc iam api-key list --service-account-id <sa-id> --format json 
   ``` 
1. If the retrieved keys do not have any value in the `expires at` field, their lifetime is unlimited. 3. Make sure to [re-issue](https://yandex.cloud/en/docs/iam/operations/compromised-credentials#api-key-reissue) such keys and define their lifetime.

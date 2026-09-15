### The minimum required scopes for service account API keys are defined {#defined-key-scopes}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | access.defined-key-scopes ||
|#

#### Description

**How this rule works:** The rule automatically scans all API keys for service accounts in the organization and identifies keys that have no scopes defined. It flags these keys regardless of whether they are actively used. The rule does not verify whether the key has been rotated recently or whether it is stored securely.

This rule detects API keys without specified scopes.

A scope is the total of the actions a service account is allowed to perform with the service's resources. A service can have more than one scope. You cannot use an API key with specified scopes in other services or scopes.

In addition to service account access permissions, you can define [scopes](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key#scoped-api-keys) to restrict the use of [API keys](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key). Configuring scope limits and expiration dates will reduce the risk of unauthorized use of your keys. Assign only the strictly required scopes to API keys.

more details: <https://yandex.cloud/en/docs/security/standard/authentication#api-key-scopes>

**Risks if the rule is not followed:** An API key without defined scopes can be used to call any API that the service account has access to. If such a key leaks — for example, into a public repository or log file — an attacker can use it to access all services the account is authorized for, not just the one the key was intended for. Scoped keys limit the damage from a key compromise to a single service or action.

#### Instructions and solutions

[Create](https://yandex.cloud/en/docs/iam/operations/authentication/manage-api-keys#create-api-key) an API key with a specified scope.

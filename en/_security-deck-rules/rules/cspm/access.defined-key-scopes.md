### The minimum required scopes for service account API keys are defined {#defined-key-scopes}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.defined-key-scopes ||
|#

#### Description

A scope is the total of the actions a service account is allowed to perform with the service's resources. A service can have more than one scope. You cannot use an API key with specified scopes in other services or scopes.

In addition to service account access permissions, you can define [scopes](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key#scoped-api-keys) to restrict the use of [API keys](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key). Configuring scope limits and expiration dates will reduce the risk of unauthorized use of your keys. Assign only the strictly required scopes to API keys.

more details: <<https://yandex.cloud/en/docs/security/standard/authentication#api-key-scopes>>

#### Guides and solutions

**Guides and solutions to use:**

[Create](https://yandex.cloud/en/docs/iam/operations/authentication/manage-api-keys#create-api-key) an API key with a specified scope.
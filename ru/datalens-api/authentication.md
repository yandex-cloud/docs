# Аутентификация клиента в API

Для выполнения операций через {{ datalens-api-short-name }} необходим [IAM-токен](../iam/concepts/authorization/iam-token.md).

Чтобы пройти аутентификацию в API:

1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. {% include [iam-token-usage](../_includes/iam-token-usage.md) %}
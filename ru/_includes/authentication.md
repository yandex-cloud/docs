# Аутентификация в API

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../iam/concepts/authorization/iam-token.md).

Чтобы пройти аутентификацию в API:

1. Получите IAM-токен:
    * [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.

2. {% include [iam-token-usage](iam-token-usage.md) %}
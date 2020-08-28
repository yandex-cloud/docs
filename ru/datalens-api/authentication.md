# Аутентификация клиента в API

Для выполнения операций через {{ datalens-api-short-name }} необходим [IAM-токен](../iam/concepts/authorization/iam-token.md).

Чтобы пройти аутентификацию в API, необходимо обменять пользовательский OAuth-токен на IAM-токен:

1. Получите IAM-токен:
    * [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
    * [Инструкция](../compute/operations/vm-connect/auth-inside-vm.md) по аутентификации изнутри виртуальной машины {{ yandex-cloud }}.

2. {% include [iam-token-usage](../_includes/iam-token-usage.md) %}
# Аутентификация в API


Для выполнения операций через API необходимо получить [IAM-токен](../iam/concepts/authorization/iam-token.md):

* [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
* [Инструкция](../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.

{% note info %}

Для доступа к API сервиса {{ billing-name }} нельзя использовать [сервисный аккаунт](../iam/concepts/users/service-accounts.md).

{% endnote %}

{% include [iam-token-usage](iam-token-usage.md) %}

#### См. также {#see-also}

[{#T}](../iam/concepts/index.md#accounts)


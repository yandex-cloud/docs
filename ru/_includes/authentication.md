# Аутентификация в API

Для выполнения операций через API необходимо получить [IAM-токен](../iam/concepts/authorization/iam-token.md):

{% if audience == "internal" %}
* [Инструкция](../iam/operations/iam-token/create-for-robot.md) для робота.

{% else %}
* [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.

{% endif %}
* [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
* [Инструкция](../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.

{% include [iam-token-usage](iam-token-usage.md) %}

#### См. также {#see-also}

[{#T}](../iam/concepts/index.md#accounts)
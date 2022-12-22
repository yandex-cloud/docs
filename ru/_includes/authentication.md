# Аутентификация в API

{% if audience != "internal" %}

Для выполнения операций через {% if lang == "ru"%}[API](../glossary/rest-api.md){% else %}API{% endif %} необходимо получить [IAM-токен](../iam/concepts/authorization/iam-token.md):

{% if product == "yandex-cloud" %}
* [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
{% endif %}
* [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
* [Инструкция](../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.

{% include [iam-token-usage](iam-token-usage.md) %}

#### См. также {#see-also}

[{#T}](../iam/concepts/index.md#accounts)

{% else %}

Для выполнения операций через API необходимо получить IAM-токен.

{% include [create-iam-token-for-robot](iam/create-iam-token-for-robot.md) %}

{% endif %}

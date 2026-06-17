---
title: Аутентификация в API {{ sw-name }}
description: Для выполнения операций через API в {{ sw-name }} необходимо получить IAM-токен для своего аккаунта.
---

# Аутентификация в API {{ sw-name }}

Для выполнения операций через [API](../../../glossary/rest-api.md) можно использовать [IAM-токен](../../../iam/concepts/authorization/iam-token.md) или [API-ключ](../../../iam/concepts/authorization/api-key.md).

{% note info %}

API-ключ можно использовать только для методов ресурса `Execution`.

{% endnote %}

## IAM-токен {#iam-token}

{% include [authentication-iam-token](../../../_includes/authentication-iam-token.md) %}

## API-ключ {#api-key}

{% include [authentication-api-key](../../../_includes/authentication-api-key.md) %}


#### Полезные ссылки {#see-also}

[{#T}](../../../iam/concepts/users/accounts.md)

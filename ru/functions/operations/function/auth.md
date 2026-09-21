---
title: Как аутентифицироваться при вызове приватной функции через HTTPS в {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете аутентифицироваться при вызове приватной функции через HTTPS.
---

# Аутентифицироваться при вызове приватной функции через HTTPS

Чтобы [вызвать](function-invoke.md) приватную функцию через HTTPS, необходимо аутентифицироваться. Для этого используйте один из следующих типов учетных данных:

{% include [auth-invoke-private](../../../_includes/functions/auth-invoke-private.md) %}

* [API-ключ](../../../iam/operations/authentication/manage-api-keys.md) для сервисного аккаунта.

    Для аутентификации по API-ключу задайте ему [область действия](*api-key-scope) `yc.serverless.functions.invoke`. Полученный API-ключ передайте в заголовке `Authorization` в следующем формате:

    ```text
    Authorization: Api-Key <API-ключ>
    ```

    {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

[*api-key-scope]: {% include notitle [api-key-scope](../../../_popups/iam/api-key-scope.md) %}

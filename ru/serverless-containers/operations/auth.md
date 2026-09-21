---
title: Как аутентифицироваться при вызове приватного контейнера через HTTPS в {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете аутентифицироваться при вызове приватного контейнера через HTTPS.
---

# Аутентифицироваться при вызове приватного контейнера через HTTPS

Чтобы [вызвать](invoke.md) приватный контейнер через HTTPS, необходимо аутентифицироваться. Для этого получите:

{% include [auth-invoke-private](../../_includes/functions/auth-invoke-private.md) %}

* [API-ключ](../../iam/operations/authentication/manage-api-keys.md) для сервисного аккаунта.

    Для аутентификации по API-ключу задайте ему [область действия](*api-key-scope) `yc.serverless.containers.invoke`. Полученный API-ключ передайте в заголовке `Authorization` в следующем формате:

    ```text
    Authorization: Api-Key <API-ключ>
    ```

    {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

[*api-key-scope]: {% include notitle [api-key-scope](../../_popups/iam/api-key-scope.md) %}

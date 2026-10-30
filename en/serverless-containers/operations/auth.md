---
title: How to authenticate when invoking a private container via HTTPS in {{ sf-full-name }}
description: Follow this guide to get authenticated when invoking a private container via HTTPS.
---

# Authenticating when invoking a private container via HTTPS

To [invoke](invoke.md) a private container via HTTPS, you need to get authenticated. To do this, get:

{% include [auth-invoke-private](../../_includes/functions/auth-invoke-private.md) %}

* Service account [API key](../../iam/operations/authentication/manage-api-keys.md).

    For authentication with an API key, specify `yc.serverless.containers.invoke` as the key [scope](*api-key-scope). Provide the API key in the `Authorization` header in the following format:

    ```text
    Authorization: Api-Key <API_key>
    ```

    {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

[*api-key-scope]: {% include notitle [api-key-scope](../../_popups/iam/api-key-scope.md) %}

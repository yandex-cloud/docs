---
title: How to authenticate when invoking a private function via HTTPS in {{ sf-full-name }}
description: Follow this guide to get authenticated when invoking a private function via HTTPS.
---

# Authenticating when invoking a private function via HTTPS

To [invoke](function-invoke.md) a private function via HTTPS, you need to get authenticated. These are the types of credentials you can use:

{% include [auth-invoke-private](../../../_includes/functions/auth-invoke-private.md) %}

* Service account [API key](../../../iam/operations/authentication/manage-api-keys.md).

    For authentication with an API key, specify `yc.serverless.functions.invoke` as the key [scope](*api-key-scope). Provide the API key in the `Authorization` header in the following format:

    ```text
    Authorization: Api-Key <API_key>
    ```

    {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

[*api-key-scope]: {% include notitle [api-key-scope](../../../_popups/iam/api-key-scope.md) %}

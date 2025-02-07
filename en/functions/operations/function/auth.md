---
title: How to authenticate when invoking a private function via HTTPS in {{ sf-full-name }}
description: Follow this guide to get authenticated when invoking a private function via HTTPS.
---

# Authenticating when invoking a private function via HTTPS

To invoke a private function via HTTPS, you must authenticate. To do this, get:

* [IAM token](../../../iam/concepts/authorization/iam-token.md):
    * [How to get a token](../../../iam/operations/iam-token/create.md) for a Yandex account.
    * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
    * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.

    Provide the IAM token in the `Authorization` header in the following format:
    ```
    Authorization: Bearer <IAM_token>
    ```
    IAM tokens are valid for up to 12 hours.

* [API key](../../../iam/operations/api-key/create) for a service account.

    Provide the API key in the `Authorization` header in the following format:
    ```
    Authorization: Api-Key <API_key>
    ```

    {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}


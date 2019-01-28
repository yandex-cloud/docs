# Get an IAM token for your account

To perform operations in Yandex.Cloud via the API, you need an [IAM token](../../concepts/authorization/iam-token.md).

> [!NOTE]
>
> [!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]

---

**[!TAB CLI]**

Get an IAM token:

```
$ yc iam create-token
```

**[!TAB API]**

1. [Log in](https://passport.yandex.com/auth) to your Yandex or Yandex.Connect account.
2. Get an OAuth token from Yandex.OAuth. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), click **Allow** and copy the OAuth token that is issued.
3. Exchange the OAuth token for an IAM token:

    ```
    curl -X POST \
    -H 'Content-Type: application/json' \
    -d '{"yandexPassportOauthToken": "<OAuth-token>"}' \
    https://iam.api.cloud.yandex.net/iam/v1/tokens
    ```

---

[!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]


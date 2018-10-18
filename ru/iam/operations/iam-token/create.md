# Получить IAM-токен для пользователя

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md). Чтобы получить IAM-токен для [пользователя](../../concepts/users/users.md):

---

**[!TAB CLI]**

Получите IAM-токен:

```
$ yc iam create-token
```

**[!TAB API]**

1. Авторизуйтесь на Яндексе с [вашим аккаунтом Яндекс.Паспорта](https://yandex.ru/support/passport/auth.html).
2. Получите [OAuth-токен](../../concepts/authorization/oauth-token.md) в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
3. Обменяйте OAuth-токен на IAM-токен:

    ```
    curl -X POST \
    -H 'Content-Type: application/json' \
    -d '{"yandexPassportOauthToken": "<OAuth-token>"}' \
    https://iam.api.cloud.yandex.net/iam/v1/tokens
    ```

---

[!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]

[!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]
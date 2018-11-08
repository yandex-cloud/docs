# Получить IAM-токен для своей учетной записи

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md). Чтобы получить IAM-токен для [своей учетной записи](../../concepts/users/users.md):

---

**[!TAB CLI]**

Получите IAM-токен:

```
$ yc iam create-token
```

**[!TAB API]**

1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе или Яндекс.Коннекте.
2. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
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

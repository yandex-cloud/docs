# Получить IAM-токен

Чтобы получить [IAM-токен](../../concepts/authorization/iam-token.md):

1. Авторизуйтесь на Яндексе с [вашим аккаунтом Яндекс.Паспорта](https://yandex.ru/support/passport/auth.html).
1. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
   
1. Обменяйте OAuth-токен на IAM-токен:
   ```
   curl -X POST \
        -H "Content-Type: application/json" \
        -d "{\"yandexPassportOauthToken\": \"<OAuth-token>\"}" \
        https://api.cloud.yandex.net/iam/v1/tokens
   ```
   Полученный IAM-токен действителен в течение 12 часов. После истечения срока действия получите новый IAM-токен.




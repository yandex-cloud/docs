1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе или Яндекс.Коннекте.
2. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
3. Обменяйте OAuth-токен на IAM-токен:

    * с помощью [curl](https://curl.haxx.se) в Bash или CMD:
        ```
        curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"
        ```
    * с помощью встроенной функции в PowerShell:

        ```
        (Invoke-RestMethod -Uri 'https://iam.api.cloud.yandex.net/iam/v1/tokens' -Method 'POST' -Body (@{yandexPassportOauthToken="<OAuth-Token>";}|ConvertTo-Json) -ContentType "application/json").iamToken
        ```
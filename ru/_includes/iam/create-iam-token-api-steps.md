1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе или Яндекс.Коннекте.
2. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
3. Обменяйте OAuth-токен на IAM-токен:

    * с помощью [curl](https://curl.haxx.se) в Bash или CMD:
        ```
        curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"
        ```
    * с помощью встроенной функции в PowerShell:

        ```
        $yandexPassportOauthToken = "<OAuth-Token>"
        $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
        Invoke-RestMethod -Method 'POST' -Uri 'https://iam.api.cloud.yandex.net/iam/v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
        ```
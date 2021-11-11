# Получение IAM-токена для робота

Во внутренней инсталляции вместо сервисного аккаунта удобнее использовать робота. В этом случае сервис сможет сам назначать роли роботу, как обычному пользователю:
1. [Заведите робота](https://staff.yandex-team.ru/preprofile/create/robot/) в ABC команде сервиса. Ответственный за робота получает право чтения пароля робота в секретнице.
2. Назначте роботу нужную роль через ABC: 
    * роль _Администратор MDB_ позволяет создавать, модифицировать и удалять сущности (кластеры, хосты, пользователи т. д.), а также получать информацию о них;
    * роль _Пользователь MDB_ позволяет только получать информацию о сущностях — просматривать список кластеров, логи, графики мониторинга и прочее.
3. Ответственному за робота [получить OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d), авторизовавшись под роботом, используя пароль из секретницы.
4. Обменяйте OAuth-токен на IAM-токен:

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
Полученный IAM-токен указывайте при обращении к ресурсам Yandex.Cloud через API. Передайте IAM-токен в заголовке Authorization в следующем формате:
```
Authorization: Bearer <IAM-TOKEN>
```
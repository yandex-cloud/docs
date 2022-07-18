Во внутренней инсталляции вместо сервисного аккаунта удобнее использовать робота. В этом случае сервис сможет сам назначать роли роботу как обычному пользователю:

1. [Заведите робота](https://staff.yandex-team.ru/preprofile/create/robot/) в ABC-команде сервиса. Ответственный за робота получает право чтения пароля робота в секретнице.
2. Назначьте роботу нужную роль через ABC:
    * Роль _Администратор MDB_ позволяет создавать, модифицировать и удалять сущности (кластеры, хосты, пользователи и т.д.), а также получать информацию о них.
    * Роль _Пользователь MDB_ позволяет только получать информацию о сущностях — просматривать список кластеров, логи, графики мониторинга и прочее.
3. Ответственному за робота нужно [получить OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d), авторизовавшись под роботом, используя пароль из секретницы.
4. Обменяйте OAuth-токен на IAM-токен:

    * с помощью [curl](https://curl.haxx.se) в Bash или CMD:
    
    {% if audience != "internal" %}

    ```bash
    curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.{{ api-host }}/iam/v1/tokens"
    ```

    {% else %}
   
    ```bash
    curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.{{ api-host }}/v1/tokens"
    ```

    {% endif %}

  * с помощью встроенной функции в PowerShell:

    {% if audience != "internal" %}

     ```powershell
     yandexPassportOauthToken = "<OAuth-Token>" `
     Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress `
     Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}/iam/v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
     ```

    {% else %}

     ```powershell
     yandexPassportOauthToken = "<OAuth-Token>" `
     Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress `
     Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
     ```

    {% endif %}
{% include [iam-token-usage](../iam-token-usage.md) %}

1. [Log in]({{ link-passport-login }}) to your Yandex or {{ yandex-360 }} account.

2. Get an OAuth token from Yandex.OAuth. To do this, follow the [link]({{ link-cloud-oauth }}), click **Allow**, and copy the OAuth token obtained.

3. Exchange the OAuth token for an IAM token:

    * Using [cURL](https://curl.haxx.se) in Bash or CMD:

        ```
        curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.{{ api-host }}/iam/v1/tokens"
        ```

    * Using the built-in PowerShell function:

        ```
        $yandexPassportOauthToken = "<OAuth-Token>"
        $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
        Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}/iam/v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
        ```


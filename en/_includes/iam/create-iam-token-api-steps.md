1. [Log in]({{ link-passport-login }}) to your Yandex account.
1. Get an [OAuth token](../../iam/concepts/authorization/oauth-token.md) from Yandex.OAuth. To do this, follow [this link]({{ link-cloud-oauth }}), click **Allow**, and copy the OAuth token you got.
1. Exchange the OAuth token for an [IAM token](../../iam/concepts/authorization/iam-token.md):

    * Using [curl](https://curl.haxx.se) in Bash:

        ```bash
        curl \
          --request POST \
          --data '{"yandexPassportOauthToken":"<OAuth_token>"}' \
          https://iam.{{ api-host }}/iam/v1/tokens
        ```
    * Using the built-in PowerShell function:

        ```powershell
        $yandexPassportOauthToken = "<OAuth_token>"
        $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
        Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}/iam/v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
        ```
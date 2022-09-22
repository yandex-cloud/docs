In the internal installation, it's more convenient to use a robot instead of a service account. In this case, the service can, on its own, assign roles to the robot as a regular user:

1. [Create a robot](https://staff.yandex-team.ru/preprofile/create/robot/) in the service ABC team. The user in charge of the robot is granted the right to read the robot's password in the vault.
2. Assign a proper role to the robot via ABC:
   * The _MDB administrator_ role lets you create, modify, and delete entities (clusters, hosts, users, and so on) and get information about them.
   * The _MDB user_ role only lets you get information about entities: view the cluster list, logs, monitoring charts, and so on.
3. The user in charge of the robot needs to [get an OAuth token](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) by logging in under the robot and using the password from the vault.
4. Exchange the OAuth token for an IAM token:

   * using [curl](https://curl.haxx.se) in Bash or CMD:

     {% if audience != "internal" %}

     ```bash
     curl \
       -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" \
       -H "Content-Type: application/json" \
       "https://iam.{{ api-host }}/iam/v1/tokens"
     ```

     {% else %}

     ```bash
     curl \
       -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" \
       -H "Content-Type: application/json" \
       "https://iam.{{ api-host }}/v1/tokens"
     ```

     {% endif %}

   * Using the built-in PowerShell function:

     {% if audience != "internal" %}
  
     ```powershell
     $yandexPassportOauthToken = "<OAuth-Token>"
     $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
     Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}/iam/v1/tokens' -Body $Body -ContentType 'application/json' | Select-Object -ExpandProperty iamToken
     ```
  
     {% else %}
  
     ```powershell
     $yandexPassportOauthToken = "<OAuth-Token>"
     $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
     Invoke-RestMethod -Method 'POST' -Uri 'https://iam.{{ api-host }}/v1/tokens' -Body $Body -ContentType 'application/json' | Select-Object -ExpandProperty iamToken
     ```
  
     {% endif %}

{% include [iam-token-usage](../iam-token-usage.md) %}

Save the IAM token to a variable in the CLI and use it in other requests from the command line. Sample request to get cloud list:

{% list tabs %}

- Bash

  ```bash
  export IAM_TOKEN=`yc iam create-token`
  curl -H "Authorization: Bearer ${IAM_TOKEN}" \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

- PowerShell

  ```
  $IAM_TOKEN=yc iam create-token
  curl.exe -H "Authorization: Bearer $IAM_TOKEN" https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

{% endlist %}


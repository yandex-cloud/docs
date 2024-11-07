Save the IAM token to a variable in the CLI and use it in other requests from the command line. Sample request to get cloud list:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export IAM_TOKEN=`yc iam create-token`
  curl \
    --request GET \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
  ```

- PowerShell {#powershell}

  ```powershell
  $IAM_TOKEN=yc iam create-token
  curl.exe \
    --request GET \
    --header "Authorization: Bearer $IAM_TOKEN" `
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
  ```

{% endlist %}

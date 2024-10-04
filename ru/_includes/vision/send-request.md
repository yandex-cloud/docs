Отправьте запрос с помощью метода [batchAnalyze](../../vision/vision/api-ref/Vision/batchAnalyze.md) и сохраните ответ в файл, например `output.json`:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export IAM_TOKEN=<IAM-токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --data '@body.json' \
    https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

- CMD {#cmd}

  ```cmd
  set IAM_TOKEN=<IAM-токен>
  curl ^
    --request POST ^
    --header "Content-Type: application/json" ^
    --header "Authorization: Bearer %IAM_TOKEN%" ^
    --data "@body.json" ^
    https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

- PowerShell {#powershell}

  ```powershell
  $Env:IAM_TOKEN="<IAM-токен>"
  curl `
    --request POST `
    --header "Content-Type: application/json" `
    --header "Authorization: Bearer $Env:IAM_TOKEN" `
    --data '@body.json' `
    https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

{% endlist %}
Отправьте запрос с помощью метода [batchAnalyze](../../vision/vision/api-ref/Vision/batchAnalyze.md) и сохраните ответ в файл, например `output.json`:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export IAM_TOKEN=<IAM-токен>
  curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '@body.json' \
      https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

- CMD {#cmd}

  ```cmd
  set IAM_TOKEN=<IAM-токен>
  curl -X POST ^
      -H "Content-Type: application/json" ^
      -H "Authorization: Bearer %IAM_TOKEN%" ^
      -d "@body.json" ^
      https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

- PowerShell {#powershell}

  ```powershell
  $Env:IAM_TOKEN="<IAM-токен>"
  curl -X POST `
      -H "Content-Type: application/json" `
      -H "Authorization: Bearer $Env:IAM_TOKEN" `
      -d '@body.json' `
      https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
  ```

{% endlist %}
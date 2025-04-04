{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  export IAM_TOKEN=<IAM-токен>

  curl \
    --request POST \
    --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    --header "x-data-logging-enabled: true" \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --data '@<путь_до_файла_json>' \
    "https://translate.{{ api-host }}/translate/v2/translate"
  ```
  Где `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.

{% endlist %}
{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  export IAM_TOKEN=<IAM_token>

  curl \
    --request POST \
    --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    --header "x-data-logging-enabled: true" \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --data '@<path_to_JSON_file>' \
    "https://translate.{{ api-host }}/translate/v2/translate"
  ```
  Where `IAM_TOKEN` is the [IAM token](../../iam/operations/iam-token/create.md) required for authentication.

{% endlist %}